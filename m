From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] advice: Document that they all default to true
Date: Mon, 19 Dec 2011 04:37:04 -0500
Message-ID: <20111219093704.GA1736@sigill.intra.peff.net>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
 <20111215073816.GD1327@sigill.intra.peff.net>
 <7vmxatofvr.fsf@alter.siamese.dyndns.org>
 <7vliq9nn0l.fsf@alter.siamese.dyndns.org>
 <7vhb0xnmyi.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 10:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcZem-0005v9-K4
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 10:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab1LSJhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 04:37:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45800
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab1LSJhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 04:37:09 -0500
Received: (qmail 27568 invoked by uid 107); 19 Dec 2011 09:43:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 04:43:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 04:37:04 -0500
Content-Disposition: inline
In-Reply-To: <7vhb0xnmyi.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187442>

On Sun, Dec 18, 2011 at 09:35:01PM -0800, Junio C Hamano wrote:

> By definition, the default value of "advice.*" variables must be true and
> they all control various additional help messages that are designed to aid
> new users. Setting one to false is to tell Git that the user understands
> the nature of the error and does not need the additional verbose help
> message.
> 
> Also fix the asciidoc markup for linkgit:git-checkout[1] in the
> description of the detachedHead advice by removing an excess colon.

Makes sense.

Acked-by: Jeff King <peff@peff.net>

-Peff
