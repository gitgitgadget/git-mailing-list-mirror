From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/4] Rename push.default to push.mode
Date: Tue, 31 Mar 2009 14:55:12 +0200
Message-ID: <49D212B0.8070005@drmicha.warpmail.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net> <1238407903-28020-5-git-send-email-santi@agolina.net> <49D0A1FE.60300@drmicha.warpmail.net> <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com> <49D0C3B8.2050801@drmicha.warpmail.net> <20090330134544.GA31827@coredump.intra.peff.net> <49D0DB78.2010204@drmicha.warpmail.net> <20090330180253.GA7220@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 14:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LodWM-0004bf-Ba
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 14:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbZCaMzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 08:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZCaMzT
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 08:55:19 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42414 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753269AbZCaMzR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 08:55:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 76D6430C054;
	Tue, 31 Mar 2009 08:55:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 31 Mar 2009 08:55:15 -0400
X-Sasl-enc: Bq+o1tGzZiSFeggJIRYtCJLKyBwAGT0+aD6SdbzFDaBX 1238504115
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B2CA226FF;
	Tue, 31 Mar 2009 08:55:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090331 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090330180253.GA7220@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115258>

Jeff King venit, vidit, dixit 30.03.2009 20:02:
> On Mon, Mar 30, 2009 at 04:47:20PM +0200, Michael J Gruber wrote:
>=20
>> Thanks for the explanation! I rechecked, and for sure it also happen=
ed
>> with patches from Tor Arne Vestb=C3=B8 and Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc Duy.
>> Again I feel blessed by my umlautlessness... and challenged by gmane=
=2E
>> About time to ditch it for reading patches also, or at least to be a=
ware
>> of it when saving patches.
>=20
> The message gmane passes out has the content-transfer-encoding set
> properly. Your newsreader should properly un-QP it, or if it has an
> option to save it directly (encoding and all), then "git am" will un-=
QP
> it. If you were to "git apply" it directly, that would break, though
> (and it is user error). If your newsreader saves the QP text without =
the
> matching header, then that would also break (and your newsreader is
> broken).
>=20
> Just curious how you are seeing the breakage (because I want to make
> sure there is no git bug).
>=20
> -Peff

I haven't seen any breakage. I just noticed a different font being used
for Santi's posts (due to different character encoding, with a differen=
t
font preset in TB) and looked at the message source, where I saw =3D20 =
and
such all over the place (message display is fine). When saving from TB
the QP is undone. It just made me feel uneasy because of our recent
discussion regarding format-flowed and patch submission. I know ff \ne
qp, but still I thought git-{send-email,apply} would prefer straight as=
cii.

Michael
