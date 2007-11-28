From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding push configuration to .git/config
Date: Wed, 28 Nov 2007 23:50:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282348360.27959@racer.site>
References: <20071121105517.GA11875@denkbrett.schottelius.org>
 <7vabp79hjt.fsf@gitster.siamese.dyndns.org> <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
 <7vd4u28z90.fsf@gitster.siamese.dyndns.org> <7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de>
 <Pine.LNX.4.64.0711221120300.27959@racer.site> <20071128221559.GC22395@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWgX-00045p-LA
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866AbXK1Xu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757620AbXK1Xu5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:50:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:45882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757548AbXK1Xu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:50:56 -0500
Received: (qmail invoked by alias); 28 Nov 2007 23:50:54 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp046) with SMTP; 29 Nov 2007 00:50:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6nhpZ1WK6ym/HNjClNx11Cd7XPCtV8AcrtuC73o
	8rIoVktcSf3VB1
X-X-Sender: gene099@racer.site
In-Reply-To: <20071128221559.GC22395@denkbrett.schottelius.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66468>

Hi,

On Wed, 28 Nov 2007, Nico -telmich- Schottelius wrote:

> [branch "master"]
>    merge = myremote
>    push = myremote
>    push = anotherremote

This is not how the current config works.  "merge" specifies the remote 
ref name, "remote" specifies the remote.

So your proposal would imply breaking most existing setups.

Ciao,
Dscho
