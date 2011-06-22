From: Jeff King <peff@github.com>
Subject: [PATCHv2 0/9] configurable tar compressors
Date: Tue, 21 Jun 2011 21:19:23 -0400
Message-ID: <20110622011923.GA30370@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <4DF7B90B.9050802@lsrfire.ath.cx>
 <20110614201433.GB1567@sigill.intra.peff.net>
 <20110614204521.GA12776@sigill.intra.peff.net>
 <20110615223030.GA16110@sigill.intra.peff.net>
 <4DFCBB92.5040308@lsrfire.ath.cx>
 <7vsjr4cx5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:19:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZC6Q-0003Ik-QK
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752Ab1FVBT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:19:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56441
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757729Ab1FVBT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:19:28 -0400
Received: (qmail 7202 invoked by uid 107); 22 Jun 2011 01:19:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:19:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:19:23 -0400
Content-Disposition: inline
In-Reply-To: <7vsjr4cx5a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176203>

Here's my re-roll. In addition to integrating comments on the list, I
made the integration with the archive code a little smoother. Filters
now appear as their own "struct archiver" in the list, and don't have to
be special-cased everywhere.

  [1/9]: archive: reorder option parsing and config reading
  [2/9]: archive-tar: don't reload default config options
  [3/9]: archive: refactor list of archive formats
  [4/9]: archive: pass archiver struct to write_archive callback
  [5/9]: archive: move file extension format-guessing lower
  [6/9]: archive: refactor file extension format-guessing
  [7/9]: archive: implement configurable tar filters
  [8/9]: archive: provide builtin .tar.gz filter
  [9/9]: upload-archive: allow user to turn off filters

-Peff
