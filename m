From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 7/8] fetch: fetch objects by their exact SHA-1 object
 names
Date: Tue, 5 Feb 2013 06:18:16 -0500
Message-ID: <20130205111816.GA25303@sigill.intra.peff.net>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <1359571542-19852-8-git-send-email-gitster@pobox.com>
 <20130205091938.GB24973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 12:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2gY8-0007C2-3I
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 12:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab3BELSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 06:18:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33104 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab3BELSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 06:18:20 -0500
Received: (qmail 28143 invoked by uid 107); 5 Feb 2013 11:19:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Feb 2013 06:19:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2013 06:18:16 -0500
Content-Disposition: inline
In-Reply-To: <20130205091938.GB24973@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215479>

On Tue, Feb 05, 2013 at 04:19:38AM -0500, Jeff King wrote:

> But taking a step back, this really seems quite inferior to an
> extension that would allow the client to share its refspecs with the
> server.  That would solve the bandwidth efficiency problem for normal
> fetchers who are

I should have read your cover letter more closely, as I see you make the
point there that this is no longer about the efficiency, but about
uncluttering.

I'm not sure I like it as an uncluttering tool, though; for the reasons
I stated in my previous mail, it makes it much more awkward for the
moments when you actually do want to fetch some of the "clutter".

-Peff
