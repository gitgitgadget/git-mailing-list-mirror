From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/2] completion: list variable names reliably with 'git
 config --names-only'
Date: Mon, 10 Aug 2015 09:45:34 -0400
Message-ID: <20150810134534.GB6763@sigill.intra.peff.net>
References: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
 <1439199967-9655-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:45:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOnOZ-0007A1-IP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 15:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbbHJNpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 09:45:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:43001 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751678AbbHJNpj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 09:45:39 -0400
Received: (qmail 12519 invoked by uid 102); 10 Aug 2015 13:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 08:45:38 -0500
Received: (qmail 5506 invoked by uid 107); 10 Aug 2015 13:45:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 09:45:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 09:45:34 -0400
Content-Disposition: inline
In-Reply-To: <1439199967-9655-3-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275620>

On Mon, Aug 10, 2015 at 11:46:07AM +0200, SZEDER G=C3=A1bor wrote:

> Use the new '--names-only' option added in the previous commit to lis=
t
> config variable names reliably in both cases, without error-prone pos=
t
> processing.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

This looks like a pretty straight-forward application of part 1, and th=
e
resulting code is much nicer to read.

Both patches:

  Acked-by: Jeff King <peff@peff.net>

though I do not think my "ack" on completion code is worth anything. :)

-Peff
