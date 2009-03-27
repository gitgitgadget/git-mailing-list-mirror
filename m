From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git
 repository
Date: Fri, 27 Mar 2009 12:26:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903271225380.12753@intel-tinevez-2-302>
References: <49C8B159.2040600@gmail.com>  <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302> <25e057c00903270222v7acad9ebxf2ed4242570f3de5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: roel kluin <roel.kluin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 12:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnAEO-0005Xa-Vy
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 12:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbZC0L0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 07:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755773AbZC0L0k
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 07:26:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:41185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752316AbZC0L0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 07:26:39 -0400
Received: (qmail invoked by alias); 27 Mar 2009 11:26:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 27 Mar 2009 12:26:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PPssLu4EP+l3eQE4pfufw9aF84q8DUiMOm26R18
	hHPihAloylmcfB
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <25e057c00903270222v7acad9ebxf2ed4242570f3de5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114881>

Hi,

On Fri, 27 Mar 2009, roel kluin wrote:

> Hi Johannes,
> 
> > - it misdetects functions: trying
> >
> >        $ ./git-cget -f get_sha1.*
> 
> The .* is not strict enough. What you want to do instead is:
> 
> $ ./git-cget -f "get_sha1[A-Za-z0-9_]*"
> 
> and that will give correct matches.

No, the problem was that it did not show a function _definition_, but 
mistook a function _call_ for a definition.

Ciao,
Dscho
