From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libcrypto core dump in 64bit
Date: Mon, 11 Feb 2008 22:42:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802112240280.3870@racer.site>
References: <20080211112822.16b69495@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOhMl-0004v1-JW
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbYBKWmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 17:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbYBKWmK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:42:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:52274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754638AbYBKWmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 17:42:08 -0500
Received: (qmail invoked by alias); 11 Feb 2008 22:42:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp055) with SMTP; 11 Feb 2008 23:42:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+IBVWtTZ+YBBGRf0nrVNkrJwx8JhRGvQNO1jnBg
	R+sH/65lr3I3bU
X-X-Sender: gene099@racer.site
In-Reply-To: <20080211112822.16b69495@pc09.procura.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73601>

Hi,

On Mon, 11 Feb 2008, H.Merijn Brand wrote:

> Any hints?

Yes.

> #0  0xc0000000033c8940:0 in sha1_block_asm_host_order+0x22e0 ()
>    from /usr/local/ssl/lib/libcrypto.so

This seems to be an OpenSSL issue, probably in its Itanium-optimised code 
(since Itanium is not _all_ that common, it is quite likely that no many 
people exercise this part of the code).

Unfortunately, I am not at all an expert in Itanium's assembler, otherwise 
I'd try to help...

Sorry,
Dscho
