From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Thu, 9 Aug 2007 10:47:12 +0200
Message-ID: <81b0412b0708090147y11783e3i4f0a6251dbe2c736@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
	 <Pine.LNX.4.64.0708031334530.14781@racer.site>
	 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708032231320.14781@racer.site>
	 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com>
	 <Pine.LNX.4.64.0708040123560.14781@racer.site>
	 <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com>
	 <Pine.LNX.4.64.0708060054020.14781@racer.site>
	 <46B6B60C.4080805@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Torgil Svensson" <torgil.svensson@gmail.com>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3fu-00023X-GX
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 10:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934776AbXHIIrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 04:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934644AbXHIIrS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 04:47:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:25591 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbXHIIrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 04:47:16 -0400
Received: by nf-out-0910.google.com with SMTP id g13so115592nfb
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 01:47:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J0lPcxIDWpkfhXEr7Uqm/qhVW186FeFRlPUvQOpmn/0R0cDss/YchxB+GHXZ1X26jSLqIuP8EfCMrKzWzZz5vz1QlJT2kqepf8EzHPOUz/njJEQ+nrKDETDqCTA3GndmLgpxiBBiVZMqQM6zZoUv98QVzFsBjoFRja5PzFwNRHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jkmjPYT0HJB3VFwnUqKwWfQxZDo20dw7rU2Mi7pLB9nKt1xd2qbH/69M/c0lV/UPlc8bzYXDnMVlePDQQpH/a9ZeRSBwVFNyPniqTHpG/geSAz1+ksmbCrjgTCMVHq7vavkzhjfSETuTNClbWT+LQt9utvHmkeflA0eHCqytncA=
Received: by 10.78.175.14 with SMTP id x14mr376371hue.1186649232262;
        Thu, 09 Aug 2007 01:47:12 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Thu, 9 Aug 2007 01:47:12 -0700 (PDT)
In-Reply-To: <46B6B60C.4080805@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55429>

On 8/6/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> Johannes Schindelin said the following on 06.08.2007 02:11:
> On Windows we have a replacement terminal, which has all the features
> you want, and also supports tabs like Konsole. I've used it for
> several years, and it works great. Have a look and see if you like it,
> then we can add it to the repo:
>      http://sourceforge.net/projects/console/
>
> Original name, ey? :-)

A fine example of windows hackery (they had to inject some code into
the process running a standard windows console to redirect the IO,
because windows has no tty of any form).
It is wonder it works, but it really does (surprisingly often).
Very impressive.
