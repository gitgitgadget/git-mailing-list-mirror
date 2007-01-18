From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-format-patch -3
Date: Thu, 18 Jan 2007 02:25:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701180221010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 02:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7M2V-00005d-BH
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 02:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbXARBZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 20:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbXARBZu
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 20:25:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:42701 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751864AbXARBZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 20:25:49 -0500
Received: (qmail invoked by alias); 18 Jan 2007 01:25:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 18 Jan 2007 02:25:48 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37055>

Hi,

On Wed, 17 Jan 2007, Junio C Hamano wrote:

>  * I think this is incompatible with --ignore-if-upstream, which
>    I haven't bothered to look into yet.

Uhm. What exactly _would_ be upstream?

At the moment, for "--ignore-if-in-upstream" we handle _only_ ranges 
(a..b), where we treat the left part as the upstream, so we first parse 
all the diffs in b..a, and then ignore all commits in a..b which have an 
already-seen diff hash.

However, if we want to do the logical analogue with "-22 HEAD", the 
equivalent to b..a would trivially contain no commits at all.

>    Likes, dislikes?

It sure is supported by the principle of least surprise.

Ciao,
Dscho
