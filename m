From: Jeff King <peff@peff.net>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 06:07:57 -0500
Message-ID: <20080108110757.GB18087@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <20080107224204.55539c31@jaiman> <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jan 08 12:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCCJn-0005KG-W8
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 12:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbYAHLIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 06:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYAHLIA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 06:08:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2258 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbYAHLIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 06:08:00 -0500
Received: (qmail 16717 invoked by uid 111); 8 Jan 2008 11:07:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 08 Jan 2008 06:07:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2008 06:07:57 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69863>

On Tue, Jan 08, 2008 at 11:56:00AM +0100, Peter Karlsson wrote:

> If I occasionally need to do a
> 
>  git add -kb binary.txt
> 
> to flag a file explicitely, that's a small price to pay for everything
> else to work out of the box.

For you, perhaps, since you apparently infrequently commit binary files
and derive some benefit from CRLF conversion. But please bear in mind
that there are people on the other end of the spectrum who want the
opposite (i.e., who could care less about CRLF, but _do_ have binary
files).

-Peff
