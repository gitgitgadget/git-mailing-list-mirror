From: Jeff King <peff@peff.net>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 5 Feb 2012 23:01:45 -0500
Message-ID: <20120206040145.GA29214@sigill.intra.peff.net>
References: <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
 <7vipjlezas.fsf@alter.siamese.dyndns.org>
 <20120205234750.GA28735@sigill.intra.peff.net>
 <7vehu8dcc8.fsf@alter.siamese.dyndns.org>
 <20120206030339.GA29123@sigill.intra.peff.net>
 <7vy5sgaby1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 05:02:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuFmG-0000cr-AN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 05:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab2BFEBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 23:01:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58528
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266Ab2BFEBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 23:01:47 -0500
Received: (qmail 22454 invoked by uid 107); 6 Feb 2012 04:08:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 23:08:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 23:01:45 -0500
Content-Disposition: inline
In-Reply-To: <7vy5sgaby1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190004>

On Sun, Feb 05, 2012 at 07:16:22PM -0800, Junio C Hamano wrote:

> In any case, here is what I queued for tonight.
> 
> -- >8 --
> Subject: [PATCH] mailmap: do not leave '>' in the output when answering "we did something"

Looks good to me.

> The callers of map_user() give email and name to it, and expect to get an
> up-to-date versions of email and/or name to be used in their output. The

Minor grammar error.

-Peff
