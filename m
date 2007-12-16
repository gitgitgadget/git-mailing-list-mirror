From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add an "-i" option to git-reset, to confirm a reset.
Date: Sun, 16 Dec 2007 03:35:09 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712160332140.27959@racer.site>
References: <1197775596-14329-1-git-send-email-kelvie@ieee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kelvie Wong <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kI6-00017h-8S
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831AbXLPDfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756256AbXLPDfW
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:35:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:45093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752539AbXLPDfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:35:21 -0500
Received: (qmail invoked by alias); 16 Dec 2007 03:35:19 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp018) with SMTP; 16 Dec 2007 04:35:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HbUM7goYHKVXzZcXDIcj0cj4u16SU7L8RlnjlZA
	fvwnRiZm+udSFo
X-X-Sender: gene099@racer.site
In-Reply-To: <1197775596-14329-1-git-send-email-kelvie@ieee.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68428>

Hi,

On Sat, 15 Dec 2007, Kelvie Wong wrote:

> It shows a diffstat, and asks the user if they would like to continue, 
> or show a full diff of the things getting reset.
> 
> I know that many times, I do a reset --hard thinking I had commited a 
> file already, but it turns out that I hadn't; and so this makes sure I 
> don't lose any work when the caffeine wears off.
> 
> Maybe it should also be made that only hard resets take this option, as 
> I cannot see this being useful in other places.

I am slightly negative on this patch.  Not only do I think that it is both 
easier and more natural to run diff/status/an-alias to see what a reset 
would do, but the patch only handles the index_file part (missing the -- 
<file> part AFAICT).

Besides, the code style is incompatible with the surrounding code.

Ciao,
Dscho
