From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Mon, 12 Nov 2012 19:06:37 -0500
Message-ID: <20121113000637.GI10531@sigill.intra.peff.net>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
 <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY41n-0004dw-VN
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 01:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564Ab2KMAGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 19:06:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45250 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab2KMAGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 19:06:41 -0500
Received: (qmail 16219 invoked by uid 107); 13 Nov 2012 00:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 19:07:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 19:06:37 -0500
Content-Disposition: inline
In-Reply-To: <20121113000217.GH10531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209551>

On Mon, Nov 12, 2012 at 07:02:17PM -0500, Jeff King wrote:

> The one distinction that would make sense to me is pausing to ask when
> we use "implicit" methods to look up the ident, like concatenating the
> username with the hostname to get the email.

By the way, I suspect this is the answer to "what do people type for
this prompt". It is probably more about a safety on bad ident than it is
about people routinely updating the information. I actually think it
would make more sense to drop the prompt entirely and just die when the
user has not given us a usable ident. But maybe people who do one-off
format-patches would rather type their name in a prompt than set an
environment variable and re-run the program.

-Peff
