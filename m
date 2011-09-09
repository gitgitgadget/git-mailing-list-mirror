From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git Bug - diff in commit message.
Date: Fri, 09 Sep 2011 08:14:19 +0200
Message-ID: <4E69AEBB.7080007@viscovery.net>
References: <1315493353942-6772145.post@n2.nabble.com> <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com> <201109090256.36306.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	anikey <arty.anikey@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Sep 09 08:16:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1uNZ-0004WJ-NT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 08:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758427Ab1IIGOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 02:14:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19987 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758410Ab1IIGOX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 02:14:23 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R1uM0-0000vI-5E; Fri, 09 Sep 2011 08:14:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D57711660F;
	Fri,  9 Sep 2011 08:14:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <201109090256.36306.trast@student.ethz.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181027>

Am 9/9/2011 2:56, schrieb Thomas Rast:
> Michael Witten wrote:
>> Perhaps `git rebase' should be reimplemented to use `git cherry-pick',
>> or does that suffer from the same problem?
> 
> It doesn't, since it uses a three-way merge.  But there's no real
> reason to reimplement anything; just use an interactive rebase, it
> uses cherry-pick in a loop.

But you can just as well use 'git rebase -m', which uses cherry-pick (or
something equivalent, dunno).

-- Hannes
