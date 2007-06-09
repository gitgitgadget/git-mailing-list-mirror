From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Sun, 10 Jun 2007 00:56:30 +0200
Message-ID: <20070609225630.GC3008@uranus.ravnborg.org>
References: <4669D2F2.90801@ramsay1.demon.co.uk> <466A5204.6060200@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: linux-sparse-owner@vger.kernel.org Sun Jun 10 00:55:34 2007
Return-path: <linux-sparse-owner@vger.kernel.org>
Envelope-to: gcps-linux-sparse@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx9qG-0002em-B6
	for gcps-linux-sparse@gmane.org; Sun, 10 Jun 2007 00:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbXFIWz3 (ORCPT <rfc822;gcps-linux-sparse@m.gmane.org>);
	Sat, 9 Jun 2007 18:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbXFIWz3
	(ORCPT <rfc822;linux-sparse-outgoing>);
	Sat, 9 Jun 2007 18:55:29 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:48449 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbXFIWz2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2007 18:55:28 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 52CBD80007C;
	Sun, 10 Jun 2007 00:55:27 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id BC167580D2; Sun, 10 Jun 2007 00:56:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <466A5204.6060200@freedesktop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49636>

> 
> Also, you might consider just using cgcc to run both GCC and Sparse.  That
> would handle the issue of target-specific CFLAGS, by ensuring that Sparse and
> GCC always see the same CFLAGS.

Is this the recommended way?
I that case I suggest that someone looks into the linux kernel part
and change it to use this method.

	Sam
