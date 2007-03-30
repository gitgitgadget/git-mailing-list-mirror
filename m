From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 20:24:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0703302022020.4757@poirot.grange>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
 <20070330180211.GI16087@alberich.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Andreas Herrmann <andreas.herrmann3@amd.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 20:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXLm2-0000zP-9v
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 20:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXC3SY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 14:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbXC3SY0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 14:24:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:51310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbXC3SYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 14:24:25 -0400
Received: (qmail invoked by alias); 30 Mar 2007 18:24:21 -0000
Received: from dynamic-unidsl-85-197-31-110.westend.de (EHLO poirot.grange) [85.197.31.110]
  by mail.gmx.net (mp051) with SMTP; 30 Mar 2007 20:24:21 +0200
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX197Ai85eEN7YrSb2T+bJmJzsMRIfBrEkRAuTjZ92q
	VaNEdFbzknVWqb
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HXLlp-0002m0-00; Fri, 30 Mar 2007 20:24:17 +0200
In-Reply-To: <20070330180211.GI16087@alberich.amd.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Mar 2007, Andreas Herrmann wrote:

> Seems to be trivial but:
> Why don't you use "make O=/foo/bar/arch<x>-config<y>" to put output
> files into separate directories? So you can have one source tree and
> put each different kernel config and arch into a separate output
> directory.
> 
> And if you have different sources for you trees put them into branches.
> 
> When switching between branches, atime of files are updated accordingly.
> So even make should be happy with that.
> 
> Just one drawback:
> Switching back and forth between two branches will cause
> recompilation of sources that differ between that branches -
> although nothing might have changed within a branch in the meantime.

Exactly, and since I have not only different configs, but also different 
versions, and I don't commit all modifications, so... It would be 
difficult. I think, the setup with "clone -l -s" should be the best.

Thanks to all for ideas
Guennadi
---
Guennadi Liakhovetski
