From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 12:21:18 +0100
Message-ID: <81b0412b0511170321q4dfa54c9x5daf6d95ac504e31@mail.gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	 <b0943d9e0511160311k725526d8v@mail.gmail.com>
	 <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	 <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	 <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:22:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EchpT-0000KH-L4
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKQLVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVKQLVU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:21:20 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:48376 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750759AbVKQLVU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 06:21:20 -0500
Received: by nproxy.gmail.com with SMTP id k26so391878nfc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 03:21:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ETsqxrqMYPPxGKhvUSuNvAW17e8nLLMkxfmjIQS7hRCDZUZPloM+g3NU46tntkx9eR7jisa0UWiulg3HgL/0aevTDZy9V3IP3Dy5YApPA1rDOlnGfDPM2mQO+pu3QGycbMxWy8a5BiqEURNyO+KfNUXNZUg/8ayADTPBCdY/OIg=
Received: by 10.48.255.18 with SMTP id c18mr387524nfi;
        Thu, 17 Nov 2005 03:21:18 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Thu, 17 Nov 2005 03:21:18 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12103>

On 11/17/05, Junio C Hamano <junkio@cox.net> wrote:
> >> > Along with the git wrapper fixes and git-apply bugfix (it did
> >>
> >> cygwin is completely broken. Still debugging, but it looks like the
> >> old "windows can't unlink/rename open files" problem.
> >
> > FWIW I had no problems on cygwin (NO_MMAP=YesPlease).
>
> It appears we'd better have something like this in the main
> Makefile, so people do not have to do it themselves everywhere?

damn... Missed by 4 minutes... :)
