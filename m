From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 15:08:36 -0400
Message-ID: <20080916190836.GA9870@sigill.intra.peff.net>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:10:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kffvq-00041y-KF
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 21:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbYIPTIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 15:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbYIPTIl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 15:08:41 -0400
Received: from peff.net ([208.65.91.99]:3604 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbYIPTIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 15:08:40 -0400
Received: (qmail 24004 invoked by uid 111); 16 Sep 2008 19:08:38 -0000
Received: from lawn-128-61-126-143.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.126.143)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 16 Sep 2008 15:08:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2008 15:08:36 -0400
Content-Disposition: inline
In-Reply-To: <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96026>

On Tue, Sep 16, 2008 at 12:49:20PM -0500, Brandon Casey wrote:

> I wonder if this is the right fix? Right now the GNU regex library is
> necessary for Darwin, FreeBSD and AIX. I can add IRIX6.5 and Solaris 7
> to that list. Have newer Solaris's been tested yet? (Jeff?) I wonder if

I haven't tested; getting tests running under Solaris is on my long-term
todo. I'll try to look later today or tomorrow to see how this
particular one behaves.

-Peff
