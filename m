From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] git-daemon virtual hosting implementation.
Date: Thu, 24 Aug 2006 15:15:16 -0500
Message-ID: <1156450516.10054.276.camel@cashmere.sps.mot.com>
References: <11563591572194-git-send-email-madcoder@debian.org>
	 <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
	 <200608232256.10108.madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 24 22:23:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGLiO-0007Vd-W0
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 22:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWHXUVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 16:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWHXUVy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 16:21:54 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:47546 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1422640AbWHXUVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 16:21:53 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k7OKLeSa018916;
	Thu, 24 Aug 2006 13:21:40 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7OKLd2K022217;
	Thu, 24 Aug 2006 15:21:40 -0500 (CDT)
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <200608232256.10108.madcoder@debian.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25975>

On Wed, 2006-08-23 at 15:56, Pierre Habouzit wrote:

> Another option would be not to support virtual hosts, but instead 
> superseed the --base-path and --user-path with some --base-path-fmt 
> and --user-path-fmt where the user can specify how to build the path 
> with simple sprintf-like formats. One could e.g. support:
>  * %% obviously ;
>  * %h that will be replaced with the hostname
>  * %u (only for --user-path-fmt)
>  * %p (asked path)
>  * ...

And this is exactly what I have implemented and
running on my system today!

> I think that's more clever, and allow more flexible use of the virtual 
> hosting code. It e.g. allow to use the virtual host scheme for the 
> `base-path` repos and to disallow it for the users.
> 
> --*-path and --*-path-fmt are obviously mutually exclusive.
> 
> What do you think ?

I kinda like it... :-)

jdl
