From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk with hyperspace support
Date: Thu, 1 Sep 2005 22:10:51 +0200
Message-ID: <81b0412b0509011310386ee9a1@mail.gmail.com>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
	 <7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
	 <17171.47747.10616.537936@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 22:11:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAvOl-0000zc-4K
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 22:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVIAUK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 16:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbVIAUK4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 16:10:56 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:26312 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030351AbVIAUKz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Sep 2005 16:10:55 -0400
Received: by nproxy.gmail.com with SMTP id x37so157844nfc
        for <git@vger.kernel.org>; Thu, 01 Sep 2005 13:10:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbYSQ1Qa50N02MK7KPGeI1iyk21qYisgyyEn5CxMH9B2l9/Vpm4JLa5y9p1UHmBkOoJvHF8dOLgsSaSAv3/h2TAdhx8utJmqjVux/MVUVHqnsBL6kKhU6fmKlBNmY2ixpYMBRfG9ACVB+U9wnrKPFYd2NFIlErnGz5NTJtfIgns=
Received: by 10.48.108.4 with SMTP id g4mr126037nfc;
        Thu, 01 Sep 2005 13:10:51 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Thu, 1 Sep 2005 13:10:51 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17171.47747.10616.537936@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7999>

On 8/30/05, Paul Mackerras <paulus@samba.org> wrote:
> 
> Try now... :)
> 
> It also makes the current graph line thicker now, so it's easier to
> pick out where the line you clicked on goes.
> 

That's a fine feature :)

BTW, did you sometimes notice lines you can't click at all?
An example is the red line on the most left side of the graph
by SHA 66129f88c4cc719591f687e5c8c764fe9d3e437a.
It goes from blue up-arrow  through green left bump to the grey
down-arrow (on my system in the kernel tree). Clicking on the blue
arrow (on the line, not the arrow itself) will turn the blue line stricken-
through with the red line (a bold blue line with a red streak inside),
the next click leaves me with with just bold blue line and broken
red line above it.

It's on Gentoo's Tcl/Tk 8.4.9.
