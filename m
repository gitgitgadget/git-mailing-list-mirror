From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7510: check %G* pretty-format output
Date: Mon, 16 Jun 2014 19:36:49 -0400
Message-ID: <20140616233649.GA12350@sigill.intra.peff.net>
References: <20140616201311.GA26829@sigill.intra.peff.net>
 <20140616202611.GA29716@sigill.intra.peff.net>
 <CAPig+cSYETVgS0EPzFbBpEywaWg8k1Yh18rX_8JhJq=Cq5n0WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 01:36:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwgSN-0006X7-02
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 01:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbaFPXgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 19:36:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:45608 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751243AbaFPXgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 19:36:50 -0400
Received: (qmail 25472 invoked by uid 102); 16 Jun 2014 23:36:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 18:36:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 19:36:49 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSYETVgS0EPzFbBpEywaWg8k1Yh18rX_8JhJq=Cq5n0WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251830>

On Mon, Jun 16, 2014 at 05:50:14PM -0400, Eric Sunshine wrote:

> > +test_expect_success GPG 'show good signature with custom format' '
> > +       cat >expect <<-\EOF
> 
> Broken &&-chain (and in tests below).

Whoops, thanks. Re-roll coming in a minute. I'm also reorganizing the
two patches a bit and adding a test for an unvalidated key.

-Peff
