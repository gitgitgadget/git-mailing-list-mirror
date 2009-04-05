From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to efficiently
 lookup sha1
Date: Sun, 5 Apr 2009 15:11:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904051510490.10279@pacific.mpi-cbg.de>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 15:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqS7k-0002Hw-QZ
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 15:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbZDENJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 09:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbZDENJX
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 09:09:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:43969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752286AbZDENJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 09:09:23 -0400
Received: (qmail invoked by alias); 05 Apr 2009 13:09:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 05 Apr 2009 15:09:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+j34lVqhajM1qmHdkNpPBmEott+2oY55c0GZWsdd
	HAbk4Z7axSv9Lh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115662>

Hi,

On Sat, 4 Apr 2009, Christian Couder wrote:

> This function has been copied from the "patch_pos" function in
> "patch-ids.c" but an additional parameter has been added.
> 
> The new parameter is a function pointer, that is used to access the
> sha1 of an element in the table.

Frankly, this is hard to follow.

It would have been easier if the first patch added that parameter, and the 
second patch just _moved_ the function.

Ciao,
Dscho
