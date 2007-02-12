From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 12:21:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121219550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net>
 <Pine.LNX.4.63.0702120028340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <eqodam$r17$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@verizon.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 12:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZFe-0008Vv-2d
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 12:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbXBLLVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 06:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbXBLLVb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 06:21:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:59721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964837AbXBLLVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 06:21:31 -0500
Received: (qmail invoked by alias); 12 Feb 2007 11:21:29 -0000
X-Provags-ID: V01U2FsdGVkX1+zf1h3rPezby2gE7gJ+NPECknDikPAr9aMx1t4d4
	aGtA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eqodam$r17$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39392>

Hi,

[Cc'ing git list, which I sometimes have to do when Jakub replies]

On Mon, 12 Feb 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > On Sun, 11 Feb 2007, Mark Levedahl wrote:
> > 
> >> The major competing solutions git seeks to supplant (cvs, cvsnt, svn, 
> >> hg) have capability to recognize "text" files and transparently replace 
> >> \r\n with \n on input, the reverse on output, and ignore all such 
> >> differences on diff operations.
> > 
> > Agree with transformations on input and output; disagree on diff.
> 
> I wonder if this could/should be solved with adding some option to git-diff,
> similar to --ignore-space-change and --ignore-all-space...

It could be done, but those options were introduced for CRLF breakage in 
the first place.

You need --ignore-crlf-breakage? Just holler.

Ciao,
Dscho
