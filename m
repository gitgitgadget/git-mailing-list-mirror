From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, v3] git-tag: introduce --[no-]strip options
Date: Sat, 3 Dec 2011 15:04:28 -0500
Message-ID: <20111203200428.GB6207@sigill.intra.peff.net>
References: <1322932376-15720-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Sat Dec 03 21:08:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWvsO-0000aV-3p
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 21:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab1LCUEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 15:04:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39349
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab1LCUEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 15:04:30 -0500
Received: (qmail 15309 invoked by uid 107); 3 Dec 2011 20:11:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 03 Dec 2011 15:11:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Dec 2011 15:04:28 -0500
Content-Disposition: inline
In-Reply-To: <1322932376-15720-1-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186258>

On Sat, Dec 03, 2011 at 07:12:56PM +0200, Kirill A. Shutemov wrote:

> From: "Kirill A. Shutemov" <kirill@shutemov.name>
> 
> Normally git tag stripes tag message lines starting with '#', trailing
> spaces from every line and empty lines from the beginning and end.
> 
> --no-strip is useful if you want to take a tag message as-is, without
> any stripping.

Perhaps this should mirror the "--clean" option from git-commit, as they
are basically doing the same thing? Besides the name difference, --clean
supports three modes: verbatim, whitespace, and strip. And defaults to
strip or whitespace depending on whether we are actually writing into
the editor.

-Peff
