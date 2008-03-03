From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Header files not mentioned in the makefile
Date: Mon, 3 Mar 2008 11:47:01 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803031146310.22527@racer.site>
References: <20080303072424.GA25623@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 03 12:48:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW99c-0004sV-NV
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 12:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbYCCLrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 06:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYCCLrq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 06:47:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:42454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751175AbYCCLrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 06:47:45 -0500
Received: (qmail invoked by alias); 03 Mar 2008 11:47:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 03 Mar 2008 12:47:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/4kQfv9R/JgoyxXTPQ14K6Bm16oBT2mvBrZcmql
	0xj4CeQN8eD9/6
X-X-Sender: gene099@racer.site
In-Reply-To: <20080303072424.GA25623@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75916>

Hi,

On Mon, 3 Mar 2008, Martin Koegler wrote:

> When I modified fetch-pack.h I was surprised by the fact, that it does 
> not result in rebuilding all object files. In fact, no file was rebuilt. 
> It turned out, that fetch-pack.h was not mentioned in the Makefile.
> 
> A quick search (on next) showed, that other header files are also not
> taking part in dependency checking:
> 
> $for a in `ls *.h`; do grep "$a" Makefile >/dev/null || (echo "missing: $a"; grep "$a" *.c|grep include) ; done
> missing: branch.h

Somehow I miss "wt-status.h" in your list.

Ciao,
Dscho
