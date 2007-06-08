From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Remove useless uses of cat, and replace with filename
 arguments or redirection
Date: Fri, 8 Jun 2007 13:52:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706081352260.4059@racer.site>
References: <466639D0.1040306@freedesktop.org>  <7vsl94sego.fsf@assigned-by-dhcp.cox.net>
  <46676C35.60406@freedesktop.org>  <Pine.LNX.4.64.0706070506230.4046@racer.site>
 <46a038f90706080342j3a5bb7abv58c78d7b532e29de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josh Triplett <josh@freedesktop.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 14:56:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwe0i-0002w8-Ep
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 14:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938075AbXFHM4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 08:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938028AbXFHM4H
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 08:56:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:51887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937232AbXFHM4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 08:56:06 -0400
Received: (qmail invoked by alias); 08 Jun 2007 12:56:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 08 Jun 2007 14:56:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yZzpCE37yw0F/KhUYEex2S8smp4gRKhEcYGaInh
	RYYEt6mhhz6NBR
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90706080342j3a5bb7abv58c78d7b532e29de@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49471>

Hi,

On Fri, 8 Jun 2007, Martin Langhoff wrote:

> On 6/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Things like that are known to happen, and that's why "wc -l < file" is a
> > better fix than "wc -l file | tr -dc 0-9". In this case, it might not
> > matter for a long time, but why not stop being sloppy here and now?
> 
> Not sure if I'd call is sloppy, but I also prefer wc -l < file -- it's
> definitely safer.

Okay, so I sounded harsher than intended.

I should have phrased it like that: I consider "wc -l < file" 
substantially more future-proof, and it is in general a good practice 
IMVHO not to generate something you throw away just after that, when there 
is a way to avoid generating the unwanted part consistently.

Sorry,
Dscho
