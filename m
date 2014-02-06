From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Fix the shallow deepen bug with no-done
Date: Thu, 6 Feb 2014 14:44:06 -0500
Message-ID: <20140206194405.GA14478@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <xmqq4n4cyr61.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:44:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUru-0004qx-VH
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbaBFToK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:44:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:45938 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751187AbaBFToJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 14:44:09 -0500
Received: (qmail 24466 invoked by uid 102); 6 Feb 2014 19:44:09 -0000
Received: from mobile-032-128-012-224.mycingular.net (HELO sigill.intra.peff.net) (32.128.12.224)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Feb 2014 13:44:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Feb 2014 14:44:06 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4n4cyr61.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241719>

On Thu, Feb 06, 2014 at 11:31:02AM -0800, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > Reported by Jeff [1]. Junio spotted it right but nobody made any mo=
ve
> > since then.
>=20
> Hrm.  Was I supposed to make any move at that point?  The discussion
> ended by me asking a question "what happens if we did X?" and there
> was no discussion.

No, you were rightly waiting on me. I queued it on my todo list but
haven't gotten around to it (and hadn't received any reports since the
original, so didn't consider it high priority). I picked it off my todo
list and stuck it on the bug list under "insanely hard" for fun (becaus=
e
I think the diagnosis probably would have been beyond a first-time git
contributor).

Thanks very much for looking at (and fixing!) this, Duy.

-Peff
