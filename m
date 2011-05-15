From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sun, 15 May 2011 14:51:07 +0200
Message-ID: <BANLkTin+oceG32Xr9J+f3Kmf05P_MdDgeA@mail.gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
	<1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
	<7vtycy7d9z.fsf@alter.siamese.dyndns.org>
	<BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
	<20110514192154.GA17271@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Osamu OKANO <okano.osamu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 14:51:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLamx-0000Fy-RH
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 14:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759964Ab1EOMvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 08:51:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45035 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759955Ab1EOMvJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 08:51:09 -0400
Received: by fxm17 with SMTP id 17so2542145fxm.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yUh8U60/7mUleS4j3moXct/g6KnB1+Oz4zxruPn0Xa8=;
        b=NWFFGZ+yDZZa/GUO2Ln2f8ZH6tLktF6AorV6h+7HwAaBxVWcyXBACKgKp9OzO+pD9C
         2k4TGaXbRRUUakFR9c4cvZn9G7mhezZirKTMqn00TP65QH2Z7Ga+SgMSPlIff2PeRn3a
         Wc8fFVIBgPWp3caCtlPReNtNan4GKi6ba91FU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=shsW+BLjugX5sQ9tQQdYNh3BQuZaAIPTRGP3LDiww5cWMQcHzEnx0u6UCh/wXaKdYI
         Bt1aYYvTXC+QGJz5Ty/C2C1Arh/Y0gwm8srqe/N1r5CUTOoBMTEcoDYk1W+nmZiZCFVN
         WyyZqbVdd5aTkjxLXyrvSdilIrNsG1mCVtgrc=
Received: by 10.223.73.139 with SMTP id q11mr2644567faj.56.1305463868008; Sun,
 15 May 2011 05:51:08 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 15 May 2011 05:51:07 -0700 (PDT)
In-Reply-To: <20110514192154.GA17271@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173630>

On Sat, May 14, 2011 at 21:21, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> Another thought I have had occasionally is that it would be nice if
> the versions committed did not have line numbers while the working
> copy had line numbers, so an ordinary 3-way merge could be more likel=
y
> to work for integrating changes[1]. =C2=A0But this second thought is =
less
> fully cooked. :)

We went over this for the main gettext series. Not commiting the line
numbers is unworkable, because it means that users who check out
git.git can't run msgmerge, because it completely fails without line
numbers.

Having a merge strategy to deal with them would be nice, but that can
be done by using the existing gitattributes config + msgmerge(1) to do
the work.
