From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Syntax highlighting for gitweb
Date: Mon, 26 Feb 2007 19:55:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261953420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070226181858.GC11232@hoeg.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ed Schouten <ed@fxq.nl>
X-From: git-owner@vger.kernel.org Mon Feb 26 19:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLl0Z-0004U9-N3
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 19:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbXBZSzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 13:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbXBZSzV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 13:55:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:40751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030434AbXBZSzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 13:55:19 -0500
Received: (qmail invoked by alias); 26 Feb 2007 18:55:18 -0000
X-Provags-ID: V01U2FsdGVkX199UbxnbTB96eZC2zCZZgxg1vcpnGs9+WRs+bFPm/
	ucOA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070226181858.GC11232@hoeg.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40642>

Hi,

On Mon, 26 Feb 2007, Ed Schouten wrote:

> I just wrote a really awful patch to add syntax highlighting to gitweb:
> 
> [...]
>
> +	$pid = open2(\*HLR, \*HLW, "highlight -f --syntax c");

Since this fork()s an external program, which is possibly expensive, or 
can fail because the program is not there, you should at least

- document it, and
- make it optional.

Ciao,
Dscho
