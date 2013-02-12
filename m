From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] parse-options: report uncorrupted multi-byte options
Date: Mon, 11 Feb 2013 20:00:32 -0500
Message-ID: <20130212010032.GA4895@sigill.intra.peff.net>
References: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	matthieu.moy@grenoble-inp.fr, tboegi@web.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 02:00:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U54F0-00047U-CR
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 02:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866Ab3BLBAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 20:00:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44763 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674Ab3BLBAe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 20:00:34 -0500
Received: (qmail 28973 invoked by uid 107); 12 Feb 2013 01:02:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 20:02:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 20:00:32 -0500
Content-Disposition: inline
In-Reply-To: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216108>

On Tue, Feb 12, 2013 at 12:13:48AM +0100, Erik Faye-Lund wrote:

> I decided to change the text from what Jeff suggested; all we know is
> that it's non-ASCII. It might be Latin-1 or some other non-ASCII,
> single byte encoding. And since we're trying not to care, let's also
> try to not be overly specific :)

Yeah, that makes more sense (I did not put too much thought into the
original wording). Thanks.

-Peff
