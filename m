From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 1/3] teach config parsing to read from strbuf
Date: Mon, 25 Feb 2013 23:55:53 -0500
Message-ID: <20130226045552.GA31331@sigill.intra.peff.net>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 05:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UACaV-0002rH-HD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 05:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759491Ab3BZEz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 23:55:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60434 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756614Ab3BZEz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 23:55:56 -0500
Received: (qmail 3788 invoked by uid 107); 26 Feb 2013 04:57:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 23:57:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 23:55:53 -0500
Content-Disposition: inline
In-Reply-To: <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217126>

On Mon, Feb 25, 2013 at 02:04:18AM +0100, Heiko Voigt wrote:

> This can be used to read configuration values directly from gits
> database.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

FWIW, I implemented something quite similar as a 2-patch series here:

  http://article.gmane.org/gmane.comp.version-control.git/189142

  http://article.gmane.org/gmane.comp.version-control.git/189143

but they were never merged as we ended up throwing out the feature built
on top (including config from blobs). I didn't look too closely at your
implementation, but it looks like you touched the same spots in the same
way. Which is probably a good thing, and may give another data point for
Junio's "what would it look like to read another source" comment.

-Peff
