From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] t/README: The trash is in 't/trash directory.$name'
Date: Thu, 1 Jul 2010 11:44:29 -0400
Message-ID: <20100701154429.GB15542@sigill.intra.peff.net>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
 <1277997004-29504-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 17:44:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULwQ-0003dQ-CE
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab0GAPoc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:44:32 -0400
Received: from peff.net ([208.65.91.99]:60299 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756729Ab0GAPob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:44:31 -0400
Received: (qmail 6786 invoked by uid 107); 1 Jul 2010 15:45:25 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 01 Jul 2010 11:45:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jul 2010 11:44:29 -0400
Content-Disposition: inline
In-Reply-To: <1277997004-29504-3-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150051>

On Thu, Jul 01, 2010 at 03:09:58PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> diff --git a/t/README b/t/README
> index b378ab1..fd61ec7 100644
> --- a/t/README
> +++ b/t/README
> @@ -221,9 +221,10 @@ This test harness library does the following thi=
ngs:
>   - If the script is invoked with command line argument --help
>     (or -h), it shows the test_description and exits.
> =20
> - - Creates an empty test directory with an empty .git/objects
> -   database and chdir(2) into it.  This directory is 't/trash direct=
ory'
> -   if you must know, but I do not think you care.
> + - Creates an empty test directory with an empty .git/objects databa=
se
> +   and chdir(2) into it.  This directory is 't/trash
> +   directory.$test_name_without_dotsh' if you must know, but I do no=
t
> +   think you care.

You might want to mention the impact of "--root" here. I.e., it is
actually "$root${root:+/}trash directory.$test_name_without_dotsh", and
it is in t/ only if $root is not an absolute path.

-Peff
