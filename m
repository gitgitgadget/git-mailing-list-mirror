From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 29 Oct 2012 04:50:46 -0400
Message-ID: <20121029085045.GA5023@sigill.intra.peff.net>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 09:51:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSl3p-0003r5-7X
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 09:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099Ab2J2Iux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 04:50:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41944 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757817Ab2J2Iuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 04:50:52 -0400
Received: (qmail 17036 invoked by uid 107); 29 Oct 2012 08:51:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 04:51:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 04:50:46 -0400
Content-Disposition: inline
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208604>

On Sun, Oct 28, 2012 at 04:54:00AM +0100, Felipe Contreras wrote:

> I've ported the tests from hg-git and made sure that the output from remote-hg
> matches the output of hg-git. With these extensive tests I would consider this
> one ready for wide use. Not only do the tests pass, I've compared the generated
> repos of a few projects, and the SHA-1's are exactly the same :)

Sounds cool. Unfortunately, the test script hangs for me, after starting
up xxdiff (!).

pstree reveals that it is "hg" that starts it, but I didn't investigate
beyond that.

-Peff
