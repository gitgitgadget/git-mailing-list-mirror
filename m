From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] sh-18n: quell "unused variable" warning
Date: Thu, 26 May 2011 01:33:26 +0200
Message-ID: <BANLkTi=Mgd7=eriOsz1phDBJ25Com2Y=mQ@mail.gmail.com>
References: <62c2e1619edcb37c0411f29a34b6bc10e3899a97.1306317312.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 26 01:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNa1-0005qN-G1
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab1EYXd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:33:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61616 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1EYXd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 19:33:27 -0400
Received: by fxm17 with SMTP id 17so268079fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mQ9d6N0jUoA4Q5mmGhjH1Zb5EGvOLhwYafFJEYbAcn8=;
        b=fvbOqvpTDg48vTkmiONzNVGllgL/q5EblA6IIWx1CnRgo3iB0UCzIryeDiheCF/Hyh
         caLK8hll3MKYTyCMLcTxOZd4E7foGNsH+Z0eGEJpvinELTXf1gmfMWNYyNepiW8VNPuU
         ck1/s6Sz7ET6EGNbyolG1M5u04qoqrlA4wCks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z64oABTLhfb94XyqXvoIrKiOsK+ShsNB/+rXpgHuuEYS/i61pYQiih2XN1W6uwcRGf
         c5XVtBaw0dFjFSD6PH0lEVvlDi49qd7DfyIxGLaNU3bEd78T+ZT5SA4eOOpmmF+5dqiI
         6iFKn8VKYh6koBAtd+tkDdA58KR0Lm9XTLZJg=
Received: by 10.223.145.78 with SMTP id c14mr189752fav.75.1306366406524; Wed,
 25 May 2011 16:33:26 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Wed, 25 May 2011 16:33:26 -0700 (PDT)
In-Reply-To: <62c2e1619edcb37c0411f29a34b6bc10e3899a97.1306317312.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174481>

On Wed, May 25, 2011 at 11:55, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

I suppose it was inevitable that we'd end up maintaining this since
upstream only maintains the GPLv3 version now.

> =C2=A0 /* Default values for command line options. =C2=A0*/
> - =C2=A0unsigned short int show_variables =3D 0;
> + =C2=A0/* unsigned short int show_variables =3D 0; */

> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 show_variables =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* show_variables =3D 1; */

Can we just remove these lines instead of commenting them out?
