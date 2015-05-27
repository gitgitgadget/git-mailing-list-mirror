From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] completion: use new 'git config' options to reliably
 list variable names
Date: Wed, 27 May 2015 17:05:40 -0400
Message-ID: <20150527210540.GC22815@peff.net>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
 <1432757240-4445-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 27 23:05:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiWK-0000jk-82
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbbE0VFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 17:05:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:36889 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753287AbbE0VFm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:05:42 -0400
Received: (qmail 14162 invoked by uid 102); 27 May 2015 21:05:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:05:42 -0500
Received: (qmail 10615 invoked by uid 107); 27 May 2015 21:05:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:05:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 17:05:40 -0400
Content-Disposition: inline
In-Reply-To: <1432757240-4445-2-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270096>

On Wed, May 27, 2015 at 10:07:20PM +0200, SZEDER G=C3=A1bor wrote:

> List all set config variable names with 'git config --list-names' ins=
tead
> of '--list' post processing.  Similarly, use 'git config
> --get-name-regexp' instead of '--get-regexp' to get config variables =
in a
> given section.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  contrib/completion/git-completion.bash | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Nice diffstat. The less hacky bash parsing we can do, the better.

-Peff
