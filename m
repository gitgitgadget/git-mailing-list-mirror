From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option
 parsing
Date: Sat, 28 Dec 2013 04:54:40 -0500
Message-ID: <20131228095440.GA24166@sigill.intra.peff.net>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
 <1387378437-20646-3-git-send-email-pclouds@gmail.com>
 <52B3E8D4.1030805@viscovery.net>
 <20131220070449.GA29717@sigill.intra.peff.net>
 <xmqq38lndxae.fsf@gitster.dls.corp.google.com>
 <CACsJy8A0TAyBoTdyrRDb54j9uoZ0=cOuxgTfFavRiUOpHTV_ag@mail.gmail.com>
 <xmqqha9vct0x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 10:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwqbX-0002Oc-8l
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 10:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab3L1Jyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 04:54:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:51514 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752892Ab3L1Jym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 04:54:42 -0500
Received: (qmail 2124 invoked by uid 102); 28 Dec 2013 09:54:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Dec 2013 03:54:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Dec 2013 04:54:40 -0500
Content-Disposition: inline
In-Reply-To: <xmqqha9vct0x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239766>

On Thu, Dec 26, 2013 at 11:27:10AM -0800, Junio C Hamano wrote:

> > I still need consensus on the name here guys, parse_prefix.
> > remove_prefix or strip_prefix? If no other opinions i'll go with
> > strip_prefix (Jeff's comment before parse_prefix() also uses "strip")
> 
> Yup, that comment is where I took "strip" from.  When you name your
> thing as "X", using too generic a word "X", and then need to explain
> what "X" does using a bit more specific word "Y", you are often
> better off naming it after "Y".

FWIW, the reason I shied away from "strip" is that I did not want to
imply that the function mutates the string. But since nobody else seems
concerned with that, I think "strip" is fine.

-Peff
