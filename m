From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to merge FETCH_HEAD?
Date: Tue, 16 Jan 2007 22:36:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162235200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070116195914.GA29100@spearce.org> <20070116213340.GB4329@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 22:36:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6vyc-0001h5-BD
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 22:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXAPVgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 16:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXAPVgQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 16:36:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:46207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419AbXAPVgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 16:36:15 -0500
Received: (qmail invoked by alias); 16 Jan 2007 21:36:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 16 Jan 2007 22:36:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070116213340.GB4329@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36970>

Hi,

On Tue, 16 Jan 2007, Michael S. Tsirkin wrote:

> Would it be useful to have git-pull . FETCH_HEAD work?

No. FETCH_HEAD is local. And for local merges, you should use git-merge, 
not git-pull.

Ciao,
Dscho
