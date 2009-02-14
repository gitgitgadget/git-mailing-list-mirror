From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Sat, 14 Feb 2009 07:03:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902140658050.10279@pacific.mpi-cbg.de>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu> <20090206161954.GA18956@coredump.intra.peff.net>
 <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu> <20090213222233.GA7424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 07:10:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYDjj-0008Lj-Dr
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 07:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZBNGCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 01:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbZBNGCj
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 01:02:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:45727 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750727AbZBNGCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 01:02:38 -0500
Received: (qmail invoked by alias); 14 Feb 2009 06:02:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 14 Feb 2009 07:02:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EXodbiwVEPlDDH9kZGAV4VrdmhZharzz+ymmGRr
	xBAx+DcZWz/NTW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090213222233.GA7424@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109826>

Hi,

On Fri, 13 Feb 2009, Jeff King wrote:

>   1. an environment variable, GIT_PRIMER. E.g., "GIT_PRIMER=0 git diff".
>      This strikes me as hack-ish and unfriendly, but would work.

FWIW I cannot stop to hate the term "primer" for this thing.

A "primer" has been explained to me as being a short leaflet that 
introduces you to the basic principles of something.  Or as a sequence of 
RNA (or in rare cases, not RNA but something similar) that starts 
replication of DNA.

IOW a primer is something that _has_ to come before something else.  
Without which the latter thing does not work.

Not a set of defaults, which this here patch is all about.

Ciao,
Dscho
