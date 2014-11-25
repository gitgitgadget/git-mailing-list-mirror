From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Mon, 24 Nov 2014 22:57:08 -0500
Message-ID: <20141125035707.GB19301@peff.net>
References: <546F5CC7.8060904@drmicha.warpmail.net>
 <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
 <20141121180105.GB26650@peff.net>
 <5470A4C0.3070501@web.de>
 <20141122191932.GA13340@peff.net>
 <xmqqvbm5yehk.fsf@gitster.dls.corp.google.com>
 <20141123194624.GB16605@peff.net>
 <xmqqzjbgwl77.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 04:57:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt7Fa-0006lT-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 04:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbaKYD5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 22:57:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:44614 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751216AbaKYD5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 22:57:08 -0500
Received: (qmail 27638 invoked by uid 102); 25 Nov 2014 03:57:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 21:57:08 -0600
Received: (qmail 26452 invoked by uid 107); 25 Nov 2014 03:57:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 22:57:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 22:57:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjbgwl77.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260189>

On Mon, Nov 24, 2014 at 09:41:00AM -0800, Junio C Hamano wrote:

> We actually do not have a reference to it anywhere.  For now, this
> should suffice.
> 
>  Documentation/SubmittingPatches | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index fa71b5f..a3861a6 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -57,7 +57,8 @@ change, the approach taken by the change, and if relevant how this
>  differs substantially from the prior version, are all good things
>  to have.
>  
> -Make sure that you have tests for the bug you are fixing.
> +Make sure that you have tests for the bug you are fixing.  See
> +t/README for guidance of writing tests.

That looks a good improvement to me.

-Peff
