From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tar archive frontend for fast-import.
Date: Thu, 8 Feb 2007 21:56:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082155210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070208203845.GB956@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGJM-0000CD-UE
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423336AbXBHU4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423337AbXBHU4F
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:56:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:59565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423336AbXBHU4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:56:04 -0500
Received: (qmail invoked by alias); 08 Feb 2007 20:56:03 -0000
X-Provags-ID: V01U2FsdGVkX1/XnvIJ3ofXglhvUykSK9qGhK0iwvN44f0BGrJcIU
	5yZA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070208203845.GB956@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39090>

Hi,

On Thu, 8 Feb 2007, Shawn O. Pearce wrote:

> Each tar is treated as one commit, with the commit timestamp coming
> from the oldest file modification date found within the tar.

You mean the youngest, i.e. the newest file, right? (I did not read the 
code yet...)

>  Nifty, eh?  :-)

Yes!

Ciao,
Dscho
