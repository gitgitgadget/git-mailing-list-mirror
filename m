From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 00:21:29 +0300
Message-ID: <20100905212129.GA1419@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100905174105.GB14020@burratino>
 <20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
 <AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 23:19:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsMco-0004l2-Le
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab0IEVTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 17:19:25 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:33859 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab0IEVTY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 17:19:24 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 5CBCB13B85B;
	Mon,  6 Sep 2010 00:19:23 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0618F5D4CE; Mon, 06 Sep 2010 00:19:23 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id AAA5BE51A4;
	Mon,  6 Sep 2010 00:19:17 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155489>

On Sun, Sep 05, 2010 at 07:27:30PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
>=20
> > AFAIK, HTTP errors don't have descriptions printed.
>=20
> I don't know if this applies here but HTTP error codes can come with
> any free-form \n-delimited string:
>=20
>     HTTP/1.1 402 You Must Build Additional Pylons

Yes, they can, but remote-curl doesn't print those error explanations
(just tried).

-Ilari
