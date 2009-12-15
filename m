From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 03/23] Introduce "skip-worktree" bit in index, teach Git
    to get/set this bit
Date: Tue, 15 Dec 2009 08:20:49 +0100
Message-ID: <4B2738D1.90002@viscovery.net>
References: <1260786666-8405-4-git-send-email-pclouds@gmail.com> 	<20091214230619.GA30538@dr-wily.mit.edu> <fcaeb9bf0912141951l5bbb4baanb991354aa3f11ae4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Greg Price <price@ksplice.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 08:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKRiN-0006su-VL
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 08:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbZLOHU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 02:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756955AbZLOHUy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 02:20:54 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35385 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756949AbZLOHUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 02:20:52 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NKRiD-0003d5-OQ; Tue, 15 Dec 2009 08:20:49 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 481DD1660F;
	Tue, 15 Dec 2009 08:20:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <fcaeb9bf0912141951l5bbb4baanb991354aa3f11ae4@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135275>

Nguyen Thai Ngoc Duy schrieb:
> 2009/12/15 Greg Price <price@ksplice.com>:
>> I confess I can't tell how the skip-worktree bit does differ from
>> assume-unchanged.  Is its 'goal' different only in that you have a
>> different motivation for introducing it, or does it actually have a
>> different effect -- and what is that different effect?
> 
> On the fun side, you could use both bits in the same worktree, to
> narrow your worktree and have some assume-unchanged files.
> 
> Another difference is that with assume-unchanged bit, you make a
> promise to Git that those assume-unchanged files are "good", Git does
> not have to care for them. If somehow you violate the promise, Git can
> harm your files on worktree.

So, the difference is that skip-worktree will not overwrite a file that is
different from the version in the index, but assume-unchanged can? Right?

-- Hannes
