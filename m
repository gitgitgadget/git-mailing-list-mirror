From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/16] git-send-email cleanups
Date: Thu, 30 Sep 2010 12:21:54 -0400
Message-ID: <20100930162153.GB8707@sigill.intra.peff.net>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 18:22:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1LtR-0006jA-4a
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 18:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab0I3QVz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 12:21:55 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:32878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab0I3QVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 12:21:55 -0400
Received: (qmail 23115 invoked by uid 111); 30 Sep 2010 16:21:53 -0000
Received: from 129-79-255-204.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.204)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 30 Sep 2010 16:21:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Sep 2010 12:21:54 -0400
Content-Disposition: inline
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157687>

On Thu, Sep 30, 2010 at 01:42:53PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> As threatened here's a series that cleans up some of the glaring wart=
s
> in git-send-email.
>=20
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (16):
>   send-email: use lexical filehandle for opendir
>   send-email: use lexical filehandles for $compose
>   send-email: use lexical filehandles during sending
>   send-email: get_patch_subject doesn't need a prototype
>   send-email: file_declares_8bit_cte doesn't need a prototype
>   send-email: unique_email_list doesn't need a prototype
>   send-email: cleanup_compose_files doesn't need a prototype
>   send-email: use \E***\Q instead of \*\*\*
>   send-email: sanitize_address use $foo, not "$foo"
>   send-email: sanitize_address use qq["foo"], not "\"foo\""
>   send-email: use (?:) instead of () if no  match variables are neede=
d
>   send-email: is_rfc2047_quoted use qr// regexes
>   send-email: extract_valid_address use qr// regexes and /o
>   send-email: send_message die on $!, not $?
>   send-email: make_message_id use "require" instead of "use"
>   send-email: use Perl idioms in while loop

With the exception of my comments on the "/o" regexes, these all look
sane to me.

-Peff
