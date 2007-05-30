From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 19:44:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705301944220.4046@racer.site>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
 <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com>
 <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
 <200705302028.15549.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paolo Teti <paolo.teti@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Lederhofer <matled@gmx.net>,
	Junio C Hamano <junkio@cox.net>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 30 20:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtTCF-0005qW-LJ
	for gcvg-git@gmane.org; Wed, 30 May 2007 20:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbXE3Sqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbXE3Sqx
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 14:46:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:34806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753118AbXE3Sqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 14:46:53 -0400
Received: (qmail invoked by alias); 30 May 2007 18:46:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 30 May 2007 20:46:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ahid1dmfavqsMAT0L0+XklO08BcCLAA8NIg9BBv
	51ROfqftSVOPLr
X-X-Sender: gene099@racer.site
In-Reply-To: <200705302028.15549.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48780>

Hi,

On Wed, 30 May 2007, Robin Rosenberg wrote:

> Wasn't because it's better to make .git a link to a repository somewhere 
> else? Just a guess.
> 
> ln -s /somewhere/repo/.git .git
> 
> Works fine for me (yes, in a clearcase dynamic view).

MinGW does not know symbolic links (at least not on the common 
filesystems).

Ciao,
Dscho
