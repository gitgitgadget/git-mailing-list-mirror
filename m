From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH 0/5] Fix rebase with file move when diff.renames = copies
Date: Fri, 23 Jul 2010 11:47:12 -0700 (PDT)
Message-ID: <624201.94995.qm@web30003.mail.mud.yahoo.com>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org> <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net> <20100722075133.GA9292@burratino> <681325.9577.qm@web30002.mail.mud.yahoo.com> <20100723170103.GA2507@burratino>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 20:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcNHE-0008Ub-GS
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 20:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab0GWSrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 14:47:14 -0400
Received: from web30003.mail.mud.yahoo.com ([209.191.69.20]:35762 "HELO
	web30003.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751715Ab0GWSrN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 14:47:13 -0400
Received: (qmail 96702 invoked by uid 60001); 23 Jul 2010 18:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1279910832; bh=vjHyRqC8Df0kjb9N65mpFqUR8UiAnnpJudpsZVBiIdk=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=cCJarMS3Vs73j5G0suKTSvjsKCK2QZx7KrRvad/27wZxNmDsrLZEJezrn5waJe2Xdq7yzAwH1vo0nnFWWohU+XJL0elyDhL4rnK8KtgTnqMsQ8w23DnugVC79h57Ur4U6rMwmd9P3kUh866DeCBy066HfYIReI/Xd39CNeShR4I=
X-YMail-OSG: pJnjqxwVM1mwjXlrTxSm_vAHX0bzNdQnaXL8avtyjj08z.t
 DGgn449n3HfOdGOI151rWgedSnXR3Z8PFQdlUoLoqC1fkSU0oJ24RGWTZZqO
 _c8RbUGJorZq.vN5uW_DgeZzOVy7fN.ABFrNq3fSxG8LrBYcCczhY7mhhQVT
 OplyEe.dC6nk4DonJ3k9Vqpe5QTLO05gEHa5HFwTgX0gnSAFiWk.TGIZBWHE
 cjSAgFh.hjFca58kcIfc11YGL.T5jRcGTMHT4IPcUY2ch4By8.N.VOIPFtcC
 SyDZ2Pr6gP5xeEf5aF4mEMY_hLfgkIkqFHUphUnSe8PKO4PIvNOdnvUYJu9P
 oId7WwFtmjNHR
Received: from [17.202.32.26] by web30003.mail.mud.yahoo.com via HTTP; Fri, 23 Jul 2010 11:47:12 PDT
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/420.4 YahooMailWebService/0.8.105.277674
In-Reply-To: <20100723170103.GA2507@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151565>

On Fri, July 23, 2010 at 10:01:03 AM, Jonathan Nieder wrote:


> David D. Kilzer wrote:
>=20
> > My original patch in  <http://marc.info/?l=3Dgit&m=3D12263566761409=
9&w=3D2>=20
>addressed=20
>
> > this in  builtin-apply.c, but Junio didn't like this approach as no=
ted in=20
> >  <http://marc.info/?l=3Dgit&m=3D122636097120953&w=3D2>.
>=20
> Got it.  This  patch just treats the symptoms in my opinion, and if
> you read Junio=E2=80=99s message  carefully, I think he was also sugg=
esting
> that git apply should still be  fixed.


Thanks!  At the time I needed to fix the issue and continue working.  I=
 didn't=20
have time to investigate it further (which is why it sat for about 18 m=
onths).

> Something like this series would fix both.  Please feel free to pick
> it up and take it in whatever direction you like.


Is this comment to me or Junio?  As a part-time contributor, I'm not su=
re what=20
my options are here.  :)

> Hope that  helps.

Yes!  Thanks again!

Dave
