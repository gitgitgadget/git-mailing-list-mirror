From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] t3301: fix confusing test for valid notes ref
Date: Sat, 14 Feb 2009 20:32:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142029420.10279@pacific.mpi-cbg.de>
References: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch> <21cefcfb71849535430c75575a9decf1f9fe9c06.1234638466.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQFu-0005CM-0j
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbZBNTbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZBNTbW
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:31:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:39532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751841AbZBNTbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:31:22 -0500
Received: (qmail invoked by alias); 14 Feb 2009 19:31:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 14 Feb 2009 20:31:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YDxthh9lYV7HQMnhW2BoKQ7DLRZivRBwigUXy8z
	rBgEjATGeanVAh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <21cefcfb71849535430c75575a9decf1f9fe9c06.1234638466.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109906>

Hi,

On Sat, 14 Feb 2009, Thomas Rast wrote:

> The test used single quotes in the test code, but also single quotes
> to wrap the entire test snippet, thus effectively skipping _out_ of
> quoted mode.  Since it doesn't matter here, just drop the quotes to
> cause less confusion.

ACK.

> Also, the test passed a MSG variable to 'git notes show', but that
> never calls an editor.

That was actually what I tried to test by passing MSG=2...  So I'd like to 
keep it.

> As an aside, is there a specific reason why all the negative tests use 
> '! VAR=foo bar' instead of 'VAR=foo test_must_fail bar'?  I thought the 
> latter was preferred to catch segfaults.

I guess that back then when I wrote the first version of notes (which I 
hoped Johan Herland would take custody of), test_must_fail either did not 
exist or was too new for me to have picked up yet.

Ciao,
Dscho
