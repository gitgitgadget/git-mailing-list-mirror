From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] update "make check-docs"
Date: Wed, 8 Aug 2012 14:31:32 -0400
Message-ID: <20120808183132.GA24550@sigill.intra.peff.net>
References: <1344412707-22356-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vmx25tj5y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 20:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzB3C-0005kQ-6O
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485Ab2HHSbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:31:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab2HHSbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:31:38 -0400
Received: (qmail 9453 invoked by uid 107); 8 Aug 2012 18:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 14:31:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 14:31:32 -0400
Content-Disposition: inline
In-Reply-To: <7vmx25tj5y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203108>

On Wed, Aug 08, 2012 at 09:58:33AM -0700, Junio C Hamano wrote:

> There really should be an easier way for the maintainer to notice
> this kind of glitch without being told (better yet, the submitter of
> a new command to notice it).  Perhaps the check-docs target in the
> Makefile needs some updating?

Hmm. We have a check-docs command? :)

This patch series at least brings that up to date. It goes on top of
Matthieu's patch.

  [1/4]: check-docs: mention gitweb specially
  [2/4]: check-docs: update non-command documentation list
  [3/4]: command-list: add git-sh-i18n
  [4/4]: command-list: mention git-credential-* helpers

-Peff
