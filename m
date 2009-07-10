From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Problem with git bisect in git-1.6.3.3
Date: Fri, 10 Jul 2009 07:05:24 +0200
Message-ID: <200907100705.24199.chriscool@tuxfamily.org>
References: <c6b1100b0907082242y7b348b13m8a4607c96b1d164b@mail.gmail.com> <4A5590A3.8070404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Chris Clayton <chris2553@googlemail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 07:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP8IP-0000d0-U7
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 07:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbZGJFFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 01:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbZGJFFD
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 01:05:03 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44537 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbZGJFFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 01:05:01 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D014E8180DA;
	Fri, 10 Jul 2009 07:04:53 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AF1F1818102;
	Fri, 10 Jul 2009 07:04:50 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A5590A3.8070404@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 09 July 2009, Johannes Sixt wrote:
> Chris Clayton schrieb:
> > git bisect start
> > # good: [07a2039b8eb0af4ff464efd3dfd95de5c02648c6] Linux 2.6.30
> > git bisect good 07a2039b8eb0af4ff464efd3dfd95de5c02648c6
> > # bad: [8e4a718ff38d8539938ec3421935904c27e00c39] Linux 2.6.31-rc2
>
> ...
>
> > but, from Makefile, it appears the last "bad" has placed me at a
> > change earlier than 2.6.30:
> >
> > [chris:~/kernel/linux-2.6]$ head Makefile
> > VERSION = 2
> > PATCHLEVEL = 6
> > SUBLEVEL = 30
> > EXTRAVERSION = -rc6
>
> ...
>
> > I'm not an experienced git user, so it may be that I have made an
> > error or false assumption.
>
> Not an error, but false assumptions:
>
> http://thread.gmane.org/gmane.comp.version-control.git/99967/focus=99977
>
> Just continue bisecting. If you can't test the version that bisect warps
> you to because the feature where the bug happens is not present, mark
> that revision as "good".

For information, I added the following very short FAQ entry:

http://git.or.cz/gitwiki/GitFaq#Whydoes.22gitbisect.22makesmetestversionsoutsidethe.22good-bad.22range.3F

Thanks,
Christian.
