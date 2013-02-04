From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Mon, 04 Feb 2013 12:00:34 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <878v74vwst.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<xa1tmwvk9gy1.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>
To: Michal Nazarewicz <mina86@mina86.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:01:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2PPe-0003qB-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 18:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515Ab3BDRAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 12:00:36 -0500
Received: from z.lifelogs.com ([173.255.230.239]:36831 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab3BDRAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 12:00:35 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id DF8B4DE0C5;
	Mon,  4 Feb 2013 17:00:34 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
Gmane-Reply-To-List: yes
In-Reply-To: <xa1tmwvk9gy1.fsf@mina86.com> (Michal Nazarewicz's message of
	"Mon, 04 Feb 2013 17:33:58 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215397>

On Mon, 04 Feb 2013 17:33:58 +0100 Michal Nazarewicz <mina86@mina86.com=
> wrote:=20

MN> As far as I understand, there could be a git-credential helper that
MN> reads ~/.authinfo and than git-send-email would just call =E2=80=9C=
git
MN> credential fill=E2=80=9D, right?

MN> I've noticed though, that git-credential does not support port argu=
ment,
MN> which makes it slightly incompatible with ~/.authinfo.

My proposed netrc credential helper does this :)

The token mapping I use:

port, protocol        =3D> protocol
machine, host         =3D> host
path                  =3D> path
login, username, user =3D> username
password              =3D> password

I think that's sensible.

Ted
