From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-fast-import.txt: improve documentation for
 quoted paths
Date: Thu, 29 Nov 2012 14:19:26 -0500
Message-ID: <20121129191926.GA21439@sigill.intra.peff.net>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
 <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
 <20121129181141.GA17309@sigill.intra.peff.net>
 <7vvccop6dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:19:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9eC-0007Vj-NI
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab2K2TT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:19:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41373 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab2K2TT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:19:28 -0500
Received: (qmail 25418 invoked by uid 107); 29 Nov 2012 19:20:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Nov 2012 14:20:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2012 14:19:26 -0500
Content-Disposition: inline
In-Reply-To: <7vvccop6dv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210870>

On Thu, Nov 29, 2012 at 11:15:56AM -0800, Junio C Hamano wrote:

> >> -If an `LF` or double quote must be encoded into `<path>` shell-style
> >> -quoting should be used, e.g. `"path/with\n and \" in it"`.
> >> +If an `LF`, backslash or double quote must be encoded into `<path>`
> >> +shell-style quoting should be used, and the complete name should be
> >> +surrounded with double quotes e.g. `"path/with\n, \\ and \" in it"`.
> 
> That "shell-style" contradicts with what fast-import.c says, though.
> It claims to grok \octal and described as C-style.

Yeah, I think it was just laziness by the original author to use
"shell-style" to mean "quotes and backslash escaping" without thinking
too hard about which escape sequences are available. Saying C-style is
more accurate (and Matthieu's more recent update does that).

-Peff
