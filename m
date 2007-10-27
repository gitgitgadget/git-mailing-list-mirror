From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor inconsistency: "git tag" requires space after -m.
Date: Sat, 27 Oct 2007 13:48:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710271347510.4362@racer.site>
References: <ffv8ul$5a2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 14:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ill6a-0004Gh-AR
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 14:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbXJ0MtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 08:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbXJ0MtU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 08:49:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:50560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752715AbXJ0MtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 08:49:20 -0400
Received: (qmail invoked by alias); 27 Oct 2007 12:49:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 27 Oct 2007 14:49:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JSKsxhRCJGIdr6TwipmhkdJPrteScLm8duLsFND
	5/1qb7d/J3LrAO
X-X-Sender: gene099@racer.site
In-Reply-To: <ffv8ul$5a2$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62489>

Hi,

On Sat, 27 Oct 2007, Sergei Organov wrote:

> It seems options parsing is somewhat broken in git-tag:
> 
> $ git tag -a -m"Annotated tag" annotated-tag
> usage: git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]
> $ git tag -a -m "Annotated tag" annotated-tag
> $ git --version
> git version 1.5.3.4
> 
> This is inconsistent with, say, "git commit", that groks -m"Message"
> (without space after -m) just fine.

As it happens, we are in the middle of adding our own option parser which 
probably solves the issue.  Can you please retest when we have that, and 
use it in builtin-tag?

Thanks,
Dscho
