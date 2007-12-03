From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reorder msgfmt command-line arguments.
Date: Mon, 3 Dec 2007 10:35:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031034200.27959@racer.site>
References: <20071203012631.GA22450@crustytoothpaste.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
X-From: git-owner@vger.kernel.org Mon Dec 03 11:36:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8eu-0000Dj-P5
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbXLCKf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXLCKf5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:35:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:44255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751731AbXLCKf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:35:56 -0500
Received: (qmail invoked by alias); 03 Dec 2007 10:35:54 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp042) with SMTP; 03 Dec 2007 11:35:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Iz7dX8RLIGxdg9nykrbOOuD94N+4x9L8SyWXQma
	L6GE2S93sBOjbT
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203012631.GA22450@crustytoothpaste.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66902>

Hi,

On Mon, 3 Dec 2007, brian m. carlson wrote:

> Any program using getopt or getopt_long will stop processing options 
> once a non-option argument has been encountered, if POSIXLY_CORRECT is 
> set.

So have you tested that msgfmt indeed does not work with the present 
command line?

Besides, you probably want to send this as a git-gui patch: based on 
git-gui.git, not git.git, and Cc'ed to Shawn Pearce.

Ciao,
Dscho
