From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 15:26:00 +0300
Message-ID: <BANLkTi=pPtsRMbJpgqMZy0Qq+HqT0uR_wQ@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
	<BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
	<BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
	<BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
	<BANLkTi=-d+8ynv5NQ1SZA3V7PMiGiHauCw@mail.gmail.com>
	<BANLkTikCQkt+e-kA2hbtMh+OFqrrZHt-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:26:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3on-0006LV-HS
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548Ab1D0M0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:26:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45031 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab1D0M0C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 08:26:02 -0400
Received: by fxm17 with SMTP id 17so1074757fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pr68t8v8Nop4ifjdxic5csj5KUfaGpYbQQMFauw/JTc=;
        b=Kz2pVQWPYmw8XIqby542BSYDjNoLZlrsQKC/iBjkRHlYAzlerAT0IpnkWO/+OAyuO3
         wlOiDwBYIN0CoAxGFynkSsANdaUbV6NLKX5vja58bZaRugMEu48xB9sL/ymQPYkHypOA
         RfnCOO7IFzr60+jCOfNFgQhh/jNm2D8JLmgUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PNyl/bn6g3JsKPdQTII5hzqKtY6OrwAYknjNV9xyUHyh6YNfXQHBWiYRgwV1d8WlHn
         PS7UIYrPWXE0xPF24WuT0uUecTxwx8qfsgDMwdEsfhO0hY6HuadGhqffRai0Y7vqTThh
         U0PQITqbDwZOqqXQwfgM5pxqmIhf65/jADwoI=
Received: by 10.223.87.215 with SMTP id x23mr2298711fal.32.1303907160788; Wed,
 27 Apr 2011 05:26:00 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 05:26:00 -0700 (PDT)
In-Reply-To: <BANLkTikCQkt+e-kA2hbtMh+OFqrrZHt-NQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172231>

On Wed, Apr 27, 2011 at 2:37 PM, Stephen Kelly <steveire@gmail.com> wrote:
> It is not expected.
>
> Alices repo is fubar'd. gitk doesn't work. The info about master being
> ahead of remote etc is wrong or git push tells me it worked, though it
> doesn't seem to.

gitk --all works fine, and gitk show a precise warning explaining the problem.

Also, the 'git push' worked fine. Perhaps what you didn't expect is
that when push.default=current, instead of pushing the current branch,
the 'HEAD' branch is being pushed.

So the test can be simplified to:

mkdir remote
cd remote/
git init --bare
cd ../
git clone remote/ alice
cd alice/
echo test >> file
git add file
git commit -am w
git push origin master
echo test >> file
git commit -am w
git branch HEAD
git push origin HEAD
git -c push.default=current push
git diff master origin/master

And the diff should be empty. With that in mind, it should be easy to
create a test script that does something similar, and add it to the
suite.

-- 
Felipe Contreras
