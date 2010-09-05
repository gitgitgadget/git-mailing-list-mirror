From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Sun, 05 Sep 2010 14:22:23 -0700 (PDT)
Message-ID: <m3pqwrnay2.fsf@localhost.localdomain>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<20100905174105.GB14020@burratino>
	<20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
	<AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 23:22:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsMfY-0006BX-SP
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab0IEVW2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 17:22:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61618 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab0IEVW1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 17:22:27 -0400
Received: by wwj40 with SMTP id 40so5583551wwj.1
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Kwhbk6ThVjqZEjMDM2hkn6qROrC1dj2CwOAVgukRggY=;
        b=VxH6yyhYMHd6CxnmdUR5Bd/tzRlgBZzs7wSfYn3wUB7evE30L3QT3l9XuKTqOGbLlP
         GFcT/EtgM+6VIy8DLx2r3aGsocA0cghXpSh557z5GCe8rKrUeQP2sixYF5uYrPBThJhh
         fngJawjYx0W1N8Ky+DIq4B8vOezO6H5D14uzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=rFwM7/csAB38QTON4Edqk1xV933KTprsvQkvMSp15WWDkBYI6/nhedoSsucckNU5+b
         25e9vFi6X6NJcgIJ+PgVsPBa22UoozqPeLYh/Erxb2zb3dlc7umEF1dpcFpdv/ncEeda
         2lMHAf1VBcDGhf8EgevTnAlGEg1i9J7QUvGuc=
Received: by 10.227.155.82 with SMTP id r18mr280008wbw.70.1283721745256;
        Sun, 05 Sep 2010 14:22:25 -0700 (PDT)
Received: from localhost.localdomain (abuz71.neoplus.adsl.tpnet.pl [83.8.197.71])
        by mx.google.com with ESMTPS id v16sm2867877weq.8.2010.09.05.14.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 14:22:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o85LLmM2032590;
	Sun, 5 Sep 2010 23:21:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o85LLQn9032586;
	Sun, 5 Sep 2010 23:21:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155491>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
>=20
> > AFAIK, HTTP errors don't have descriptions printed.
>=20
> I don't know if this applies here but HTTP error codes can come with
> any free-form \n-delimited string:
>=20
>     HTTP/1.1 402 You Must Build Additional Pylons

And you can also send more detailed description in the *body* (and not
only HTTP headers) of HTTP response, though I don't know if git does
that.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
