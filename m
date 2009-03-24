From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git
 repository
Date: Tue, 24 Mar 2009 15:05:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903241505080.7493@intel-tinevez-2-302>
References: <49C8B159.2040600@gmail.com> <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302> <49C8E074.4030808@gmail.com> <20090324135906.GA10644@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roel Kluin <roel.kluin@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 15:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm7OB-0002GE-Dy
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 15:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403AbZCXOF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 10:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757087AbZCXOF4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 10:05:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:46087 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756569AbZCXOFu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 10:05:50 -0400
Received: (qmail invoked by alias); 24 Mar 2009 14:05:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 24 Mar 2009 15:05:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JaG5RFghJgAMqsqMlWnToF2lF5tswtXMd1B9G6Z
	xEA/AqScoI0gy7
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090324135906.GA10644@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114462>

Hi,

On Tue, 24 Mar 2009, Jeff King wrote:

>   git ls-files | xargs ctags

Or 'git ls-files -z | xargs -0r ctags', which fails with Solaris' default 
xargs, though.

Ciao,
Dscho
