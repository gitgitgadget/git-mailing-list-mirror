From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 12:24:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705020143460.4010@racer.site>
References: <200705012346.14997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, releases@openoffice.org,
	Jan Holesovsky <kendy@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 12:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjC0Y-0003Q1-Cs
	for gcvg-git@gmane.org; Wed, 02 May 2007 12:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992999AbXEBKYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 06:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993001AbXEBKYV
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 06:24:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:48042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992999AbXEBKYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 06:24:21 -0400
Received: (qmail invoked by alias); 02 May 2007 10:24:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 02 May 2007 12:24:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ufal4Ds9ubY0vVWyoSyUVuyVWoKWIE8LNBv7Z2W
	XJrUh+3Uczsp2l
X-X-Sender: gene099@racer.site
In-Reply-To: <200705012346.14997.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46011>

Hi,

On Tue, 1 May 2007, Jakub Narebski wrote:

> 'Checkout time' (which should be renamed to 'Initial checkout time'),
> in which git also loses with 130 minutes (Linux, 2MBit DSL) [from 
> go-oo.org], 100min (Linux, 2MBit DSL, Wireless, no proxy) [from 
> go-oo.org] versus 117 minutes (Linux, 2MBit DSL), 26 minutes (Linux, 
> 2MBit DSL, with compression (-z 6)) for CVS, and  60 Minutes (Windows, 
> 34Mbit Line) for Subversion, would also be helped by the above.

FWIW I can confirm the number "100min".

Something I realized with pain is that the refs/ directory is 24MB big. 
Yep. Really. They have 3464 heads and 2639 tags. I suspect that this is 
the reason why.

Will play with it.

Ciao,
Dscho
