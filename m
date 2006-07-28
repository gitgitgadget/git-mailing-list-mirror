From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Slow fetches of tags
Date: Fri, 28 Jul 2006 12:42:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281233120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org> <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
 <20060525131241.GA8443@linux-mips.org> <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Baechle <ralf@linux-mips.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 28 12:42:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6PnY-0004go-9m
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 12:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWG1KmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWG1KmZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 06:42:25 -0400
Received: from mail.gmx.net ([213.165.64.21]:19107 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932487AbWG1KmY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 06:42:24 -0400
Received: (qmail invoked by alias); 28 Jul 2006 10:42:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 28 Jul 2006 12:42:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24382>

Hi,

On Wed, 26 Jul 2006, Junio C Hamano wrote:

> I think the attached patch is safe in general, but somebody may
> want to give an extra set of eyeballs to double check the logic
> is sane.

The only gripe I have with it is that reachable() is relatively expensive, 
and it might be misused by a nasty client, making the server go down the 
whole history. I have no idea, though, how to prevent that.

Ciao,
Dscho
