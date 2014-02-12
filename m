From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Wed, 12 Feb 2014 18:27:40 -0500
Message-ID: <20140212232740.GA11098@sigill.intra.peff.net>
References: <1392109750-47852-1-git-send-email-sugi1982@gmail.com>
 <20140212205948.GA4453@sigill.intra.peff.net>
 <CA+39Oz5TSPNzYVvFytJwwUhRYjbEp5f_BdBWKT2tcYzpbF1WyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yoshihiro Sugi <sugi1982@gmail.com>, git list <git@vger.kernel.org>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 00:28:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDjDo-0001JZ-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 00:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbaBLX15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 18:27:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:49477 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752878AbaBLX1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 18:27:42 -0500
Received: (qmail 12251 invoked by uid 102); 12 Feb 2014 23:27:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Feb 2014 17:27:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Feb 2014 18:27:40 -0500
Content-Disposition: inline
In-Reply-To: <CA+39Oz5TSPNzYVvFytJwwUhRYjbEp5f_BdBWKT2tcYzpbF1WyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242035>

On Wed, Feb 12, 2014 at 11:10:49PM +0000, Thomas Adam wrote:

> On 12 February 2014 20:59, Jeff King <peff@peff.net> wrote:
> > +sub decode {
> > +       my $orig = shift;
> > +       my $decoded = eval { decode_utf8($orig, Encode::FB_CROAK) };
> > +       return defined $decoded ?
> 
> I'd still advocate checking $@ here, rather than the defined $decoded check.

I don't mind changing it, but for my edification, what is the advantage?

-Peff
