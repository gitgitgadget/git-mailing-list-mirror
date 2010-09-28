From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH] repack: add -F option that passes --no-reuse-delta to
 pack-objects
Date: Tue, 28 Sep 2010 08:44:51 +0200
Message-ID: <20100928084451.78c13d17@jk.gs>
References: <20100927133104.25ce5285@jk.gs>
	<7vbp7j2krn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 08:44:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Tvu-0007Sb-NP
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 08:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab0I1Goy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 02:44:54 -0400
Received: from zoidberg.org ([88.198.6.61]:49923 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254Ab0I1Gox (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 02:44:53 -0400
Received: from jk.gs ([::ffff:137.120.115.117])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 28 Sep 2010 08:44:53 +0200
  id 00400158.4CA18EE5.00000227
In-Reply-To: <7vbp7j2krn.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157392>

--- Junio C Hamano <gitster@pobox.com> wrote:

> Jan Kr=C3=BCger <jk@jk.gs> writes:
>=20
> > Discussion point: it might make more sense to switch the meanings
> > around, making -F do the 'bigger' routine and reverting -f to what
> > it used to be. I don't feel strongly about that, however.
>=20
> That sounds sensible.  reuse_object is used only to z-recompress and
> is not involved in precomputed delta selection, and under normal
> circumstances it should not have much effect on the outcome.
>=20
> Please make it so.

Already done. See the alternative patch (in a 2-series) at
20100927141936.590d71b3@jk.gs
<http://mid.gmane.org/20100927141936.590d71b3@jk.gs>. I Cc'd you and
Nicolas acked it. Just saying. ;-)

-Jan
