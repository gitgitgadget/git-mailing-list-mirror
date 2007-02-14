From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add install-lib target to install libgit.a library plus
 headers.
Date: Wed, 14 Feb 2007 16:51:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702141650400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070214145725.2827.qmail@0b3a4e2ad592dc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 16:51:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMQ3-00047D-DI
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 16:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbXBNPvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 10:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbXBNPvk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 10:51:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:55800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932338AbXBNPvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 10:51:40 -0500
Received: (qmail invoked by alias); 14 Feb 2007 15:51:38 -0000
X-Provags-ID: V01U2FsdGVkX19+0aJU8XZ+kQkfgY5p6fHa2g7or5my1M0ds2i+JL
	X0+g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070214145725.2827.qmail@0b3a4e2ad592dc.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39659>

Hi,

On Wed, 14 Feb 2007, Gerrit Pape wrote:

> Patch from Luca Falavigna to install git static library and header files
> into $(prefix)/lib/, $(prefix)/include/git/, see

This would make sense, _iff_ libgit.a was libified. As it is, too many 
functions assume that you can die() anytime something goes awry.

Ciao,
Dscho
