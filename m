From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] protocol-capabilities.txt: document no-done
Date: Thu, 6 Feb 2014 14:40:01 -0500
Message-ID: <20140206194000.GC14552@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:40:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUo5-0001VO-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766AbaBFTkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:40:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:45924 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755684AbaBFTkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 14:40:04 -0500
Received: (qmail 24146 invoked by uid 102); 6 Feb 2014 19:40:03 -0000
Received: from mobile-032-128-012-224.mycingular.net (HELO sigill.intra.peff.net) (32.128.12.224)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Feb 2014 13:40:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Feb 2014 14:40:01 -0500
Content-Disposition: inline
In-Reply-To: <1391699439-22781-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241717>

On Thu, Feb 06, 2014 at 10:10:38PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> See 3e63b21 (upload-pack: Implement no-done capability - 2011-03-14)
> and 761ecf0 (fetch-pack: Implement no-done capability - 2011-03-14)
> for more information.

Content looks good. A few minor grammar nits:

> +no-done
> +-------
> +This capability should be only used with smart HTTP protocol. If

split infinitive: s/be only/only be/

I think it would be more customary to say "the smart HTTP protocol",
with the definite article.

> +Without no-done in smart HTTP protocol, the server session would end

Ditto here.

> +and the client has to make another trip to send "done" and the serve=
r
> +can send the pack. no-done removes the last round and thus slightly

s/and the server/before the server/ ?

-Peff
