From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility
Date: Sat, 7 May 2005 16:22:15 -0400
Message-ID: <118833cc0505071322480e8e09@mail.gmail.com>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de>
	 <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net>
	 <20050507090543.GG23680@cip.informatik.uni-erlangen.de>
	 <20050507172429.GJ3562@admingilde.org>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 07 22:15:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUVhw-0006kx-Ax
	for gcvg-git@gmane.org; Sat, 07 May 2005 22:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVEGUWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 16:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVEGUWS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 16:22:18 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:12750 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262750AbVEGUWP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 May 2005 16:22:15 -0400
Received: by rproxy.gmail.com with SMTP id a41so641823rng
        for <git@vger.kernel.org>; Sat, 07 May 2005 13:22:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dupCbQ/Amn+uBe+GySwmGOH9FBDXVb7FnWizB1onOBD1svr43qpbXOZo7HwZb0JL1W1tGLl+s7Rz4WofDj8dRCxOsIMMyAskv6qfzEggKGtb4yvVgULKvhuTvRXUKgiaujG2W+x+kiSSnoUjGLmtYW5q3Echq7KcUzE+Nq+GW3k=
Received: by 10.38.90.57 with SMTP id n57mr742030rnb;
        Sat, 07 May 2005 13:22:15 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Sat, 7 May 2005 13:22:15 -0700 (PDT)
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20050507172429.GJ3562@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/7/05, Martin Waitz <tali@admingilde.org> wrote:
> hoi :)
> 
> On Sat, May 07, 2005 at 11:05:43AM +0200, Thomas Glanzmann wrote:
> > * Junio C Hamano <junkio@cox.net> [050507 10:54]:
> > > A quick question.  Which construct in this bashism?
> > > Not using backtick but saying $(command)?
> >
> > Exactly:
> 
> huh? which broken shell does not understand $()?

Solaris' /bin/sh

I thought everything we were relying on bash anyway.  It'll take it.

Morten
