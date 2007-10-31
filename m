From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 16:43:58 +0300
Message-ID: <20071031134358.GD15182@dpotapov.dyndns.org>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org> <20071031055303.GB3326@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 14:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InDrp-0007QZ-TY
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 14:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbXJaNoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 09:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536AbXJaNoE
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 09:44:04 -0400
Received: from smtp03.mtu.ru ([62.5.255.50]:60648 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628AbXJaNoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 09:44:01 -0400
Received: from potapov.private (ppp85-141-239-252.pppoe.mtu-net.ru [85.141.239.252])
	by smtp03.mtu.ru (Postfix) with ESMTP id 214B646ABAF;
	Wed, 31 Oct 2007 16:43:58 +0300 (MSK)
Received: from dpotapov by potapov.private with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1InDrS-0006Oz-T4; Wed, 31 Oct 2007 16:43:58 +0300
Content-Disposition: inline
In-Reply-To: <20071031055303.GB3326@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62829>

On Wed, Oct 31, 2007 at 06:53:03AM +0100, Bj=F6rn Steinbrink wrote:
> On 2007.10.30 22:05:27 -0700, Junio C Hamano wrote:
> > Your MUA seems to mark the UTF-8 message you are sending out as
> > 8859-1, which means your name in the message gets corrupt.
>=20
> Hm, that would be git-send-email then, anything I need to configure?
> (Actually I don't see it marking the message as anything)

I believe that the issue is with Junio's mail client. Indeed, the
context encoding for the mail *body* was specified as 8859-1, but
that should have none effect on fields in the mail header, because
any field is the header should be either printable ASCII or encoded
to contain only ASCII characters as specified in RFC 1522:

encoded-word =3D "=3D?" charset "?" encoding "?" encoded-text "?=3D"

Here is the From field from the mail:

=46rom:	=3D?utf-8?q?Bj=3DC3=3DB6rn=3D20Steinbrink?=3D <B.Steinbrink@gmx=
=2Ede>

So, as far as I can tell, it is encoded properly using utf-8.

Dmitry
