From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 15:00:52 +0200
Message-ID: <46d6db660707260600w6c3ca5d2ve6aaf06c7684789d@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <Pine.LNX.4.64.0707251510130.14781@racer.site>
	 <fcaeb9bf0707250715p7c183a81vc78f641eef493777@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 15:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE2xg-0002Gq-9S
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 15:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762235AbXGZNAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 09:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762190AbXGZNAy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 09:00:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:62219 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761447AbXGZNAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 09:00:53 -0400
Received: by nz-out-0506.google.com with SMTP id s18so460126nze
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 06:00:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GmlIH9r/Splz5tAM1m6VICtPxzzU0Fn7j521MHWndcnrYbrl6wcGUQPwko2HSFazw35RNN2RGrTeNYW2eKtf2mfq3i5lQca5ME45pcDMafjY4VnOmv78L8A6YNFc/UliNbtt1+owjvdhpHb71w3NJhiXA8W9UIlKGaYm2NtZ9x4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lMhCG4hX03j+b4LghjlEbdHeiMh1Kyec44jHlko5l4Z5hC5J1gbktIYMR9yTdOVl+pJvDedtR1wbADkcwC8niTJ7UgEgK5e79ZTjIEd27MbjLDz0bSPqFVzKWJYapbu9KZBB5pVTh7Q1OvhzpwK3nt9tCTLiG8ayBGlNmcTAoy0=
Received: by 10.114.53.1 with SMTP id b1mr1682309waa.1185454852481;
        Thu, 26 Jul 2007 06:00:52 -0700 (PDT)
Received: by 10.115.78.15 with HTTP; Thu, 26 Jul 2007 06:00:52 -0700 (PDT)
In-Reply-To: <fcaeb9bf0707250715p7c183a81vc78f641eef493777@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53827>

On 7/25/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 7/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 25 Jul 2007, Nguyen Thai Ngoc Duy wrote:
> >
> > > FYI, I'm working on getting rid of msys requirement from mingw port. I
> > > can't tell you how long it would take though. Could be one month or two.
> >
> > Is there a repo out there?
>
> http://repo.or.cz/w/git/pclouds.git?a=shortlog;h=gitbox
>
> There are some patches on mob I have not merged to gitbox branch yet.
>

beautiful piece of work, IMHO. I really like the fact you managed some
busybox applets to actually work without msys. Really cool idea!

it seems you're not very far off. I believe you intend to replace in git-commit
"#!c:/msys/bin/sh" with something like "#!c:/gitbox/bin/gitbox ash", right ?

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu
