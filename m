From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] import-tars: use Archive::Tar instead of unpack()
Date: Mon, 12 Feb 2007 15:25:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121524172.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1171289831.629.6.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Loeffler <zvpunry@zvpunry.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 15:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGc7U-00043p-DP
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 15:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbXBLOZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 09:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbXBLOZV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 09:25:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:48398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964925AbXBLOZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 09:25:21 -0500
Received: (qmail invoked by alias); 12 Feb 2007 14:25:19 -0000
X-Provags-ID: V01U2FsdGVkX180IcBaOpY0meaxtr2cnTxBh6F8QIA14NmLyy+P7r
	UB0w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1171289831.629.6.camel@ibook.zvpunry.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39404>

Hi,

On Mon, 12 Feb 2007, Michael Loeffler wrote:

> this is less obscure, does not use gzcat (which is often installed as 
> zcat) and it is shorter.

... and it relies on a package which is usually not installed. Whereas you 
can symbolically link zcat to gzcat.

Ciao,
Dscho
