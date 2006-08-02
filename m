From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 02 Aug 2006 11:23:22 -0500
Message-ID: <1154535801.19994.15.camel@cashmere.sps.mot.com>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
	 <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, Git List <git@vger.kernel.org>,
	Martin Waitz <tali@admingilde.org>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 02 18:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8JZl-0003l5-VV
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 18:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWHBQ2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 12:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWHBQ2A
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 12:28:00 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:8931 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932086AbWHBQ2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 12:28:00 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k72GRi7T004898;
	Wed, 2 Aug 2006 09:27:44 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k72GRhet014950;
	Wed, 2 Aug 2006 11:27:43 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24653>

On Tue, 2006-08-01 at 18:54, Junio C Hamano wrote:

> In any case, I think tweaking gitweb.cgi from Makefile like
> Martin Waitz did is as easy and clean for people who want to
> customize; it should just be the matter of defining the
> necessary params in config.mak.

I disagree.  I run multiple virtual web servers on one
physical machine.  Several of them run different gitweb
instances, each with different configurations.

With this "params in config.mk" approach, I have to
run it multiple times, once for each web server I run.

I _really_ would prefer an "include from ." feature
where I can place the specific gitweb_config.pm parts
in the same directory where gitweb.{pl,cgi} is installed.

We really need to separate out these config values
from the gitweb.{pl,cgi} script itself.  We _need_ to
be able to update the gitweb script independently,
and easily.

> I do not think there is much difference between any of the
> customization proposed so far (yours, Martin's and the one from
> Matthias Lederhofer) from functionality and ease-of-use point of
> view.  They all try to make customization can be done in one
> place, and the difference is mostly of taste, so I'd just pick
> one from Martin.

Let's just make sure it is a separate config file, please.

I posted a patch to this end back on March 22 or 23 or so
as well.

Thanks,
jdl
