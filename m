From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] daemon: plug memory leak
Date: Sat, 31 Oct 2015 09:53:05 -0400
Message-ID: <20151031135304.GA28310@sigill.intra.peff.net>
References: <56348709.9080207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 31 14:53:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsWam-000777-TG
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 14:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbbJaNxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2015 09:53:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:50873 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752124AbbJaNxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 09:53:08 -0400
Received: (qmail 29352 invoked by uid 102); 31 Oct 2015 13:53:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Oct 2015 08:53:07 -0500
Received: (qmail 30561 invoked by uid 107); 31 Oct 2015 13:53:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Oct 2015 09:53:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Oct 2015 09:53:05 -0400
Content-Disposition: inline
In-Reply-To: <56348709.9080207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280579>

On Sat, Oct 31, 2015 at 10:16:57AM +0100, Ren=C3=A9 Scharfe wrote:

> Changes since v1:
> - Rebased on next, which already has a cleanup function.
> - Added first patch for renaming it.
>=20
> Rene Scharfe (3):
>   run-command: name the cleanup function child_process_clear()
>   run-command: export child_process_clear()
>   daemon: plug memory leak

This round looks good to me. Thanks.

-Peff
