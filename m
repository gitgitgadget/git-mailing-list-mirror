From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] sha1-lookup: handle duplicate keys with
 GIT_USE_LOOKUP
Date: Fri, 23 Aug 2013 19:37:53 -0400
Message-ID: <20130823233752.GA19125@sigill.intra.peff.net>
References: <20130822231215.GA16978@sigill.intra.peff.net>
 <20130822231404.GB17060@sigill.intra.peff.net>
 <5217BAF3.2000702@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 24 01:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD0vY-00037e-85
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 01:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab3HWXh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 19:37:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:41311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab3HWXhz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 19:37:55 -0400
Received: (qmail 28772 invoked by uid 102); 23 Aug 2013 23:37:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 18:37:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 19:37:53 -0400
Content-Disposition: inline
In-Reply-To: <5217BAF3.2000702@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232840>

On Fri, Aug 23, 2013 at 09:41:39PM +0200, Johannes Sixt wrote:

> Am 23.08.2013 01:14, schrieb Jeff King:
> >+++ b/t/t5308-pack-detect-duplicates.sh
> >@@ -0,0 +1,73 @@
> >+#!/bin/sh
> >+
> >+test_description='handling of duplicate objects in incoming packfiles'
> >+. ./test-lib.sh
> >+. ../lib-pack.sh
> 
> This should be
> 
> . "$TEST_DIRECTORY"/lib-pack.sh
> 
> to support running tests with --root (also in patch 3/6).

Doh, you would think that I would remember that, as the one who
introduced "--root" in the first place.

Will fix. Thanks for noticing.

-Peff
