From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 12:00:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610181159050.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610172209070.1971@xanadu.home> <7v64eii7hh.fsf@assigned-by-dhcp.cox.net>
 <7vu022gqji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 12:00:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga8E1-0006y5-49
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 12:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWJRKAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 06:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJRKAd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 06:00:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:58859 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751455AbWJRKAc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 06:00:32 -0400
Received: (qmail invoked by alias); 18 Oct 2006 10:00:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 18 Oct 2006 12:00:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu022gqji.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29216>

Hi,

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> +/*
> + * Even if sizeof(union delta_base) == 24 on 64-bit archs, we really want
> + * to memcmp() only the first 20 bytes.
> + */
> +#define UNION_BASE_SZ	20

Excuse me for joining the game, but why don't you just use the 
recently introduced hashcmp() for that purpose? AFAIU you do exactly that, 
you compare hashes.

Ciao,
Dscho
