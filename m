From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 09:20:27 -0400
Message-ID: <fcaeb9bf0707260620i2ec1ab36ka470758edfd570d2@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <Pine.LNX.4.64.0707251510130.14781@racer.site>
	 <fcaeb9bf0707250715p7c183a81vc78f641eef493777@mail.gmail.com>
	 <46d6db660707260600w6c3ca5d2ve6aaf06c7684789d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 15:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE3GZ-0000vS-W6
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 15:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759629AbXGZNU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 09:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760275AbXGZNU2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 09:20:28 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:27204 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759142AbXGZNU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 09:20:28 -0400
Received: by an-out-0708.google.com with SMTP id d31so102158and
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 06:20:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZZ5Z2W3mmZi9do37gDhpQUXx1pRqcMk13D3KFNjVtFVgeLkElSJ1Tgbo5e+LCgliOPW2N4IxB3Tq2T7H80uIye058OwtTg5T7gChaQj+MhFg6p6E3JRjreUYtkSA0rDpH8QRKYVPq3TP8W6FlBAMCn5ZOE0Fv2pC3k1xRHqn5lA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RllkBKj6ZtYtjIjOIStH0vH3+vXstBn7CoVQL6ufN9EW93ja49DyM/v3b5Op9RnywPXMHnX6rDt6yAgqcU3G4zFR729chsUKzGubOVSfr21ThVsM6Z/B7b1oyxVTS5cGkPn9gJmwzKb+U1oTVzH8RXRQEQxAq7Ss9SWLRfWhK8g=
Received: by 10.100.190.8 with SMTP id n8mr1249947anf.1185456027207;
        Thu, 26 Jul 2007 06:20:27 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 06:20:27 -0700 (PDT)
In-Reply-To: <46d6db660707260600w6c3ca5d2ve6aaf06c7684789d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53828>

On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> On 7/25/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > On 7/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi,
> > >
> > > On Wed, 25 Jul 2007, Nguyen Thai Ngoc Duy wrote:
> > >
> > > > FYI, I'm working on getting rid of msys requirement from mingw port. I
> > > > can't tell you how long it would take though. Could be one month or two.
> > >
> > > Is there a repo out there?
> >
> > http://repo.or.cz/w/git/pclouds.git?a=shortlog;h=gitbox
> >
> > There are some patches on mob I have not merged to gitbox branch yet.
> >
>
> beautiful piece of work, IMHO. I really like the fact you managed some
> busybox applets to actually work without msys. Really cool idea!
>
> it seems you're not very far off. I believe you intend to replace in git-commit
> "#!c:/msys/bin/sh" with something like "#!c:/gitbox/bin/gitbox ash", right ?

No. I tweaked try_shell_exec() to use gitbox shell if the interpreter is "sh".

-- 
Duy
