From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] send-email: auth plain/login fix
Date: Mon, 26 Sep 2011 09:59:03 -0700
Message-ID: <1317056343.14197.2.camel@Joe-Laptop>
References: <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
	 <1316879367-1182-1-git-send-email-zbyszek@in.waw.pl>
	 <7v8vpb5kea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Graham Barr <gbarr@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8EWW-0004eC-SY
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab1IZQ7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 12:59:12 -0400
Received: from perches-mx.perches.com ([206.117.179.246]:37854 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751765Ab1IZQ7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 12:59:05 -0400
Received: from [173.60.85.8] (account joe@perches.com HELO [192.168.1.151])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 18193753; Mon, 26 Sep 2011 09:59:04 -0700
In-Reply-To: <7v8vpb5kea.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.1.92- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182134>

On Mon, 2011-09-26 at 09:38 -0700, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
> > git send-email was not authenticating properly when communicating o=
ver
> > TLS with a server supporting only AUTH PLAIN and AUTH LOGIN. This i=
s
> > e.g. the standard server setup under debian with exim4 and probably
> > everywhere where system accounts are used.
>=20
> Now that's a solution that makes me feel less dirty than
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/178818/focus=
=3D178824

Dirty is dirty.  I don't see this as better or worse really,
but thanks Zbigniew for bringing it up again.

It'd be best if Graham Barr, the module author (cc'd),
could respond to the issue.

cheers, Joe

> even though, by forcing Authen::SASL::Perl to be used bypassing XS an=
d
> Cyrus variants, this _might_ be introducing regression for others. We=
'll
> find out soon enough if anybody screams ;-)
>=20
> I see you already researched previous discussion and have Joe Perches=
 in
> the loop; Thanks.
