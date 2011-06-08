From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 18:26:25 +0200
Message-ID: <BANLkTinU0Rj_xqwV4CivdrL8r__rU+wZew@mail.gmail.com>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net> <vpqhb8049m3.fsf@bauges.imag.fr>
 <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com> <vpqtyc0wc1j.fsf@bauges.imag.fr>
 <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com> <20110608161816.GA13175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, thomas@xteddy.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULal-000633-9F
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab1FHQ0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 12:26:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61412 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1FHQ0p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 12:26:45 -0400
Received: by pwi15 with SMTP id 15so322222pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=V01CBgHLe+FQZ3yKbCB1dyV9mUEXRN/syEZYx952zpE=;
        b=rWtwmkaECJF7WGoUkg3G9AvFmECguaaEm1BEusQ7TEGm8ELGgkGlK2EJE9XmPHlMF5
         EVEZGY4Ydk1cRBcm/jAhQls/Ck7ZWMhqBAJUIYIbJALoL82+T4VEq/HGjAQrdtNeaaow
         JZ6fx9YNMiNbUZSwSaqhC13TaWmE2RJ9LLaMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=POori7sTOX7PA7KjSyPM5tq7FmlnHOH73JhMSry7kUrmU6oYB/cyV6rIP2BNftiHH6
         0f/zmJXad7ZsJrPHliE1YO+iIvtKqjZ6kYpKXa5szYtUgCA16Pl57MhRzfrF6/1g/4g5
         kNSt84J2JZsWuUDmZ4ncRpodehzE+MFCxpT48=
Received: by 10.142.50.7 with SMTP id x7mr291962wfx.414.1307550405365; Wed, 08
 Jun 2011 09:26:45 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 09:26:25 -0700 (PDT)
In-Reply-To: <20110608161816.GA13175@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175393>

2011/6/8 Jeff King <peff@peff.net>:

> You need to set $/ to undef. Use "local" to prevent it from polluting
> other parts of the code, like:
>
> =A0my $var =3D do { local $/; <$handle> };
>
> -Peff
>

Worked as a charm. Thanks a lot.
--=20
J=E9r=E9mie Nikaes
