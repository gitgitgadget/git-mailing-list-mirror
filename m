From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [PATCH] Implement safe_strncpy() as strlcpy() and use it more.
Date: Sun, 11 Jun 2006 12:33:58 +0200
Message-ID: <20060611103358.GB10430@bohr.gbar.dtu.dk>
References: <20060611100628.GA10430@bohr.gbar.dtu.dk> <20060611.191540.68073375.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 11 12:34:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpNGe-0004o9-Ta
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 12:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWFKKeA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 06:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFKKeA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 06:34:00 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:59378 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932097AbWFKKeA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 06:34:00 -0400
Received: (qmail 7109 invoked by uid 5842); 11 Jun 2006 12:33:58 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060611.191540.68073375.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21645>

On Sun, Jun 11, 2006 at 07:15:40PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <20060611100628.GA10430@bohr.gbar.dtu.dk> (at Sun, 11 Jun 2006 12:06:28 +0200), "Peter Eriksen" <s022018@student.dtu.dk> says:
> 
> > I've taken strlcpy() from the OpenBSD CVS without attribution.  Is this
> > allowed?  If it is, how should it be stated?
> 
> Please include full copyright information.

Where should this information go?  Just above the function
safe_strncpy(), or at the top of path.c?  I believe path.c is GPL, so
can this be mixed freely with BSD licensed code?  Should I put
safe_strncpy() into a seperate file as with strlcpy()?
This seems to be the copyright information:

/*
 * Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

Peter
