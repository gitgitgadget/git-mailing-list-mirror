From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 12:36:08 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702271235260.29426@xanadu.home>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org>
 <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
 <20070227003118.GH1639@spearce.org>
 <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
 <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
 <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
 <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
 <20070227161122.GE3230@spearce.org>
 <2BBADC5E-7188-4F77-BF5A-28131B435EF0@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 18:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM6Fb-0005TR-PJ
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 18:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXB0RgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 12:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXB0RgK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 12:36:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51297 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXB0RgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 12:36:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE4002VDU88F0W2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 12:36:08 -0500 (EST)
In-reply-to: <2BBADC5E-7188-4F77-BF5A-28131B435EF0@adacore.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40765>

On Tue, 27 Feb 2007, Geert Bosch wrote:

> For smaller packs, the I/O is all going to be buffered anyway,
> but if we're going to have >4GB pack files, it adds a lot of real
> I/O  and SHA1 computation for no good reason. If we get a rare chance
> to have a new pack format, why not fix this wart at the same time?

Fair enough.


Nicolas
