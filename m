From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep
 files?
Date: Mon, 12 May 2008 18:13:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805121810501.30431@racer>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon May 12 19:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvbbW-0006w7-2b
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbYELRNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbYELRNU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:13:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:40049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754921AbYELRNT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:13:19 -0400
Received: (qmail invoked by alias); 12 May 2008 17:13:18 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp018) with SMTP; 12 May 2008 19:13:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wfBFz5aywTAF3fc1VcwMGaPHv78FhEVwQkaETNY
	TRbX0GjYiMKAQL
X-X-Sender: gene099@racer
In-Reply-To: <20080512155243.GA3592@mithlond.arda.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81882>

Hi,

On Mon, 12 May 2008, Teemu Likonen wrote:

> Probably a crazy idea: What if "gc --aggressive" first removed *.keep 
> files and after packing and garbage-collecting and whatever it does it 
> would add a .keep file for the newly created pack?

Most .keep files are not meant to be removed by git-gc.  Usually, .keep 
files are only created interactively (if you _want_ to keep a pack, e.g. 
when it has been optimally packed and is big), or by git-index-pack while 
it is writing a pack (IIRC).

So I think it would be wrong for "gc --aggressive" to remove the .keep 
files.

Ciao,
Dscho
