From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: clone --bare vs push
Date: Mon, 3 Jan 2011 22:40:32 -0600
Message-ID: <ifu8d2$t61$1@dough.gmane.org>
References: <AANLkTi=+cRqD_CDFyaYj8uWOxUA1+5Dgr_pv1guaaT40@mail.gmail.com> <AANLkTi=RNDYrRbyEJXA_c30JEVr=SYUQ01cfA3FyWpLT@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 05:41:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZyi4-0006wn-IV
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 05:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab1ADElT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 23:41:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:35697 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab1ADElT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 23:41:19 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PZyhx-0006uc-OQ
	for git@vger.kernel.org; Tue, 04 Jan 2011 05:41:17 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 05:41:17 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 05:41:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164473>


"Levend Sayar" <levendsayar@gmail.com> wrote in message 
news:AANLkTi=RNDYrRbyEJXA_c30JEVr=SYUQ01cfA3FyWpLT@mail.gmail.com...
> Hi, all.
>
> We cloned a repo from github on our local server. Say X for this. At
> that repo, we did
>
> git clone --bare X y.git
>
> Now y.git is ready for other machines to clone.
>
> To update our upstream repo X, we do
>
> git pull
>
> and then
>
> git push --all
>
> to update y.git.
>
> Now questions:
>
> 1) When I compare X/.git directory and y.git directory there are many
> objects missing in y.git. What is the reason ?
>
> 2) git clone --bare is too fast. My .git directory is nearly 1GB. How
> can it be copied that much fast ?
>
> 3) Is this more safe then git pull, git push
>
> rm -rf y.git
> git pull
> git clone --bare X y.git
>
> Namely bare cloning each time when we update our main repo ?
>
> TIA
>
> _lvnd_
> (^_^)

you can also use the file:// url format to create a complete copy and not 
use hardlinks.  see git-clone manpage.

e.g. git clone --bare file:///fullpathto/X y.git

v/r,
Neal 
