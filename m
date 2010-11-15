From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] get_sha1: support relative path ":path" syntax
Date: Mon, 15 Nov 2010 15:56:20 +0100
Message-ID: <AANLkTi=aVyOiRkE-+y8DDwcBQK36bVFrAX5PFw3TjCey@mail.gmail.com>
References: <AANLkTimJKQ=xc7az+FEM+18aTxQ5zQ24q7pfChnSwt6f@mail.gmail.com> <1289793369-10653-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tfransosi@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 15:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI0UD-000454-48
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 15:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab0KOO4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 09:56:44 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43045 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab0KOO4n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 09:56:43 -0500
Received: by gwj17 with SMTP id 17so1001044gwj.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 06:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RWPmgwheEjivgsa7bATBMcufXqW3iilA4uVyrXFqf1M=;
        b=geBfUasxwPG4pCv5kp8HEc0cawOcU7BJocMvq3igwIsz0E2h4w1k77Fr+SAHOitGNO
         kSQdYelAF0+X+0uj4N1p8x2rpTkojBoGAEo/84hXkppZ0mj0ndno7PpxXIqY1BORPnBb
         iWr52j+H4cVSmKTIBLFMG7Tw7bgiyNNZ+wXx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vECCXbroSZ+MJqUOgBnSajuFnoxZqiA1gINn6OlmC48Xtm0YNueb67ii6tBIjdo3c9
         wEUMKBhFZkhLcEtyMkEstd1GMdc1VgU/VIl4YE7WcUJw6NSvwXJKDYRcIdHNrjdszfyt
         49uPzRISPq5yDokSddi2M0G3Gf8FKxqXWIIcc=
Received: by 10.151.111.17 with SMTP id o17mr3547539ybm.356.1289833002775;
 Mon, 15 Nov 2010 06:56:42 -0800 (PST)
Received: by 10.151.100.3 with HTTP; Mon, 15 Nov 2010 06:56:20 -0800 (PST)
In-Reply-To: <1289793369-10653-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161490>

Heya,

2010/11/15 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Relative path=
 syntax is not supported in this command.\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Ple=
ase report to git@vger.kernel.org.");

Might it save us a lot of debugging hassle later if we report what
"this command" is? E.g., if the user is using some internal tool that
happens to dispatch to a command that doesn't support this, it could
help us to know what command is being used?

--=20
Cheers,

Sverre Rabbelier
