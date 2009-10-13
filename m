From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just
 a   branch
Date: Tue, 13 Oct 2009 09:45:06 +0200
Message-ID: <4AD43002.5080003@viscovery.net>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vr5t8coex.fsf@alter.siamese.dyndns.org> <4AD420BC.5060506@viscovery.net> <7v3a5n3hgn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxc9Z-00007o-Qc
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759060AbZJMHpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759058AbZJMHpq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:45:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19919 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759043AbZJMHpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:45:46 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mxc4B-0006us-Ac; Tue, 13 Oct 2009 09:45:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 17EFB9614; Tue, 13 Oct 2009 09:45:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v3a5n3hgn.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130143>

Junio C Hamano schrieb:
> Half of the time, the commit you test in your "git bisect" section would
> be a "good" one, and immediately after you tell it "bisect good", it tells
> you that some _other_ commit you marked "bad" is the first bad commit.  In
> such a case, you won't be on the commit that the bisect has found.

Oh, yes, very true; but it is very close. But the commit that git bisect
reset warps me to is perhaps 1000 steps in history away. I certainly do
not want to go there, ever, because I want to go back near the bad commit
right away. (Think of fewer files changed means less build time.) If git
bisect reset would check out the bad commit, this would be *very* convenient.

-- Hannes
