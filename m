From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: do not report the resulting tree object
 name
Date: Sat, 13 Jan 2007 12:01:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701131159510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
 <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
 <20070112184839.9431ddff.vsu@altlinux.ru> <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
 <7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701130034000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbql3pxz8.fsf@assigned-by-dhcp.cox.net> <eo9apg$sqo$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 12:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5gdl-0007R1-7k
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 12:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbXAMLBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 06:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbXAMLBa
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 06:01:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:33842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161204AbXAMLB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 06:01:29 -0500
Received: (qmail invoked by alias); 13 Jan 2007 11:01:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 13 Jan 2007 12:01:28 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eo9apg$sqo$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36747>

Hi,

On Sat, 13 Jan 2007, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > I do not think we need to show 1..15 at all, perhaps without
> > "export GIT_MERGE_BASE_DEBUG=YesPlease".
> 
> Or a -v/--verbose (or even -v -v -v) flag set.

... and you'd pass them from git-pull to git-merge to git-merge-recursive? 
Three different programs parse the same option? And worse, the other 
strategies ignore the setting? What about strategies people implemented 
on _their_ side, which do not know about the "-v" flag? I don't think so.

Ciao,
Dscho
