From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: diff --check is stupid about blank lines
Date: Wed, 20 Aug 2008 22:02:01 +0200
Message-ID: <20080820200201.GA3210@atjola.homenet>
References: <20080820140517.GA1304@atjola.homenet> <20080820172825.GC27773@sigill.intra.peff.net> <7v7iabsgfk.fsf@gitster.siamese.dyndns.org> <7vskszr0it.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVttf-0003n0-1x
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbYHTUCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbYHTUCG
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:02:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:39060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756082AbYHTUCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:02:05 -0400
Received: (qmail invoked by alias); 20 Aug 2008 20:02:03 -0000
Received: from i577B97AF.versanet.de (EHLO atjola.local) [87.123.151.175]
  by mail.gmx.net (mp018) with SMTP; 20 Aug 2008 22:02:03 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18PCjlrln0P5qsgXd9XVqhceddTd8YBL7784ykRjN
	YeK/obkEca0LXu
Content-Disposition: inline
In-Reply-To: <7vskszr0it.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93026>

On 2008.08.20 11:42:34 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Instead, data.trailing_blanks_start is supposed to be reset to 0 ev=
ery
> > time we see non-blank newline, a copied context line, or new hunk.
> >
> > So if this triggers with -U0 I'd understand, but otherwise I do not=
 see
> > how.
>=20
> Ahhh, what idiot wrote the logic for checking trailing blank lines in
> checkdiff_consume().
>=20
> It does not ask for any context lines.  Sheesh.
>=20
> This should fix it.

Thanks, works for me :-)

Bj=F6rn
