From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 21:05:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272102440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
 <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
 <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
 <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
 <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:05:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8ZS-00013M-Ad
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbXB0UFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbXB0UFG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:05:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:34395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751814AbXB0UFE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:05:04 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:05:03 -0000
X-Provags-ID: V01U2FsdGVkX19HUXcb2rpHNfX1XMlVbkJrcpYLnfcBav6kjmCF0b
	lZWQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40779>

Hi,

On Tue, 27 Feb 2007, Geert Bosch wrote:

> The object-count at the beginning of the pack is a little strange for 
> local on-disk pack files, as it is data that can easily be derived.

The SHA1 is also easily derived. So think of it as a doubly secure way to 
ensure integrity.

Remember, there were some people unable to accept that SHA1 collisions are 
_unlikely_...

Ciao,
Dscho
