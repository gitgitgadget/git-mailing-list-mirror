From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] nicer receive-pack errors over http
Date: Fri, 21 Sep 2012 01:30:57 -0400
Message-ID: <20120921053057.GA9768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 07:31:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEvpU-0007bz-SX
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 07:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab2IUFa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 01:30:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52293 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab2IUFa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 01:30:59 -0400
Received: (qmail 29383 invoked by uid 107); 21 Sep 2012 05:31:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 01:31:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 01:30:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206105>

While we are on the subject of http user experience, I thought I'd
mention this patch to route more errors from index-pack back to the
user. We're not doing it yet at GitHub, but I plan to apply it soon.

The first patch is a cleanup and minor bug fix. The second is the
interesting one. The third is purely cosmetic, and doesn't need to be
tied to the others.

  [1/3]: receive-pack: redirect unpack-objects stdout to /dev/null
  [2/3]: receive-pack: send pack-processing stderr over sideband
  [3/3]: receive-pack: drop "n/a" on unpacker errors

-Peff
