From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Allow building Git with Asciidoctor
Date: Mon, 20 Oct 2014 02:24:25 -0700
Message-ID: <20141020092425.GD12913@peff.net>
References: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:24:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg9Cf-0000mr-7s
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 11:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbaJTJYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 05:24:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:60172 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752854AbaJTJYa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 05:24:30 -0400
Received: (qmail 5451 invoked by uid 102); 20 Oct 2014 09:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 04:24:30 -0500
Received: (qmail 10504 invoked by uid 107); 20 Oct 2014 09:24:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 05:24:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2014 02:24:26 -0700
Content-Disposition: inline
In-Reply-To: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 20, 2014 at 12:20:35AM +0000, brian m. carlson wrote:

> This series is designed to implement the changes necessary to build Git
> using Asciidoctor instead of AsciiDoc.

These all looked sane to me from my cursory read (I haven't played with
AsciiDoctor myself yet, but it looks from your results like you have).

> I've successfully built the documentation with Asciidoctor using the
> following command line:
> 
>   make doc ASCIIDOC=asciidoctor ASCIIDOC_HTML=html5 \
>   ASCIIDOC_DOCBOOK=docbook45 ASCIIDOC_EXTRA="'-alitdd=&#45;&#45;'" \
>   ASCIIDOC_CONF=

That incantation is getting a bit hairy. Is it worth adding a meta-macro
like USE_ASCIIDOCTOR that encompasses it all? That might encourage other
people to play around with it.

-Peff
