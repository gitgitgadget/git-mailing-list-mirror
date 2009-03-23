From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 3/8] docbook: radical style change
Date: Mon, 23 Mar 2009 02:50:04 -0400
Message-ID: <20090323065004.GC1119@coredump.intra.peff.net>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 07:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lle0c-0006uh-Lw
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 07:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbZCWGuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 02:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbZCWGuK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 02:50:10 -0400
Received: from peff.net ([208.65.91.99]:46928 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbZCWGuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 02:50:09 -0400
Received: (qmail 19106 invoked by uid 107); 23 Mar 2009 06:50:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 02:50:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 02:50:04 -0400
Content-Disposition: inline
In-Reply-To: <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114247>

On Sun, Mar 22, 2009 at 08:05:16PM +0200, Felipe Contreras wrote:

> Use smaller 'sans-serial' font. Sans-Serial fonts are supposed to be
> easier to read in screens. This format is similar to the one of
> Wikipedia.

I started to look up "sans-serial" before I realized it seems to be just
a typo for "sans-serif" (or is there something I'm missing)?

Is there a reason to apply this style change just to docbook-generated
HTML? Most of the HTML documentation is generated directly from
asciidoc.

>  html body {
>    margin: 1em 5% 1em 5%;
> -  line-height: 1.2;
> +  line-height: 1em;
> +  font-family: sans-serif;
> +  font-size: small;

Personally, I think collapsing the line spacing looks worse.

I'm not sure I see the point of putting "small" text for the entire
body. Since it covers the whole page, you are not "small" with respect
to anything else, but are basically just overriding the user's choice
through their browser of what is a reasonable default text size.

-Peff
