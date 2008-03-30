From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: why multiple password prompts?
Date: Sun, 30 Mar 2008 18:05:05 -0400
Message-ID: <3e8340490803301505y7df70787wad4449b1821e0d05@mail.gmail.com>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl>
	 <alpine.LNX.1.00.0803291241020.19665@iabervon.org>
	 <3e8340490803301334g2127451cu6e9dc71eefa6241c@mail.gmail.com>
	 <alpine.LNX.1.00.0803301755200.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul <lists@pote.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 00:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg5ew-0004M4-5N
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 00:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbYC3WFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 18:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbYC3WFI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 18:05:08 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:9850 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYC3WFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 18:05:07 -0400
Received: by py-out-1112.google.com with SMTP id u52so1873682pyb.10
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l0HTeOf/DmxnbWc31fAnBbuoOmSOx1TCERzF74YKtWE=;
        b=qpcVH8YWGeZISMvJv5Gborp1Vcky8Dx/j60IPdotHtQkkKF2axl8cm4QPghUVjGdCQrqsVZTN0GYVOTABTRMATkS8APoUby1p3RgdL0Tj+Nlo2F4YiEUkRHClsIuaEfMkjndgRO1fxzxyjPE6M6GDbIzI9iMaaet/uUpTy/e95I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EhumeHSb6fNdGVbeETjE+bCma2b7YcJwwv3QpCAGl1Ops/GASVLjC6OO8OLTae9v/CwNoSFtaUFibkkj/HltocZI6F9Z5n3oFt+JfA+HfMeye+42mz11Qe91zPkByO9WW+kLTDoC9LMZMuranp2yrpr/UgaJ+JPSu5rScTOy6A4=
Received: by 10.64.112.7 with SMTP id k7mr2647554qbc.72.1206914705667;
        Sun, 30 Mar 2008 15:05:05 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Sun, 30 Mar 2008 15:05:05 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0803301755200.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78519>

On Sun, Mar 30, 2008 at 5:56 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Sun, 30 Mar 2008, Bryan Donlan wrote:
>
>  > git.git's master branch seems to be hitting ssh twice fairly reliably...
>  > [bd@shion git-test] SSH_AUTH_SOCK= ~/src/git/git-pull
>  > bd@130.111.246.25's password:
>  > bd@130.111.246.25's password:
>  > remote: Counting objects: 5, done.
>  > remote: Compressing objects: 100% (2/2)remote: , done.
>  > remote: Total 3 (delta 0), reused 0 (delta 0)
>  > Unpacking objects: 100% (3/3), done.
>  > From ssh+git://bd@130.111.246.25/home/bd/git-test
>  >    b0b8450..57a92a7  master     -> origin/master
>  > Updating b0b8450..57a92a7
>  > Fast forward
>  >  fob |    1 +
>  >  1 files changed, 1 insertions(+), 0 deletions(-)
>  > [bd@shion git-test] ~/src/git/git --version
>  > git version 1.5.5.rc2
>  >
>  > The remote's still on 1.5.4.4 if it matters...
>
>  No, but ~/src/git/git-pull will run the installed git-fetch, not the
>  locally built one, IIRC.

Ah, that would be it, thanks.
