From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Re: fix french translation
Date: Tue, 28 May 2013 07:57:48 +0800
Message-ID: <CAHtLG6Q-OWKJZVcFateFjgJ4TfovEWrfph9dyuiGi+ophBVh0Q@mail.gmail.com>
References: <CAHtLG6ToiRT-EQMFhrR976=gat+8p0GFFyz+9qpqaq36=gVyGQ@mail.gmail.com>
	<CALWbr2w+ooM04nc79XKyVy48c_eH1AES5XgVDwwk+tFpmitLTw@mail.gmail.com>
	<CAHtLG6SfTi9XiqGDFhjR0DzLwSK0qVm0GL9-7boHEo=d2uCmvA@mail.gmail.com>
	<CALWbr2xU58Ymq3xzAdomi_ND==ByHFfCNuZvEPDcsEcozRgoTg@mail.gmail.com>
	<vpqmwrg23sx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 28 01:58:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh7Ik-0004fB-E9
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 01:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260Ab3E0X5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 19:57:50 -0400
Received: from mail-vb0-f41.google.com ([209.85.212.41]:35711 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758249Ab3E0X5t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 May 2013 19:57:49 -0400
Received: by mail-vb0-f41.google.com with SMTP id p14so5068652vbm.0
        for <git@vger.kernel.org>; Mon, 27 May 2013 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HTKX7GWjacFMaw4PBlKm8JTwsdQuwSxHhfkmDBiEshw=;
        b=xzsK6jdq/QD+NA/Dqnsx5fSM2m0XypHGZbDFXGhbNYityYK9VC0dKY133tED4IvpeN
         g7RaHxFMFE/KYIm+c8J4N/J8FO1ZQ02ku+nNwlxgwZrDRFeN84k3zlA7zq+woHV47YfC
         7kUs2BfkaRD9LSeHAcS2Gt9wrN3qb7wD99fzmqyzlbVKzT1aMwGoVkqJTz79smR6wjgy
         hjSl2SCliJ7syhCPVl4qtfZWgdPMqsEemgnEoYTPQT3IAqGUkV4u0thwfSTImCUXBK7o
         7WmpI5DpL3D6ODGAxVNa31qQ/0OOc+kSwwUJj7JJGCQQ7qmapdmDx+o8SkWaxWlUufN4
         TQzw==
X-Received: by 10.220.68.13 with SMTP id t13mr16417294vci.24.1369699068761;
 Mon, 27 May 2013 16:57:48 -0700 (PDT)
Received: by 10.220.177.7 with HTTP; Mon, 27 May 2013 16:57:48 -0700 (PDT)
In-Reply-To: <vpqmwrg23sx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225617>

Sorry, I reversed the revisions. This one should be correct.

 git-gui/po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/po/fr.po b/git-gui/po/fr.po
index 40441db..0aff186 100644
--- a/git-gui/po/fr.po
+++ b/git-gui/po/fr.po
@@ -1139,7 +1139,7 @@ msgstr "Standard (rapide, semi-redondant, liens d=
urs)"

 #: lib/choose_repository.tcl:514
 msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"
+msgstr "Copie compl=C3=A8te (plus lent, sauvegarde redondante)"

 #: lib/choose_repository.tcl:520
 msgid "Shared (Fastest, Not Recommended, No Backup)"

2013/5/27 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>>> -msgstr "Copie compl=C4=8Dte (plus lent, sauvegarde redondante)"
>>> +msgstr "Copy compl=C4=8Dte (plus lent, sauvegarde redondante)"
>>
>> I still don't get why "Copie" is replaced by "Copy" ?
>
> Yes, this is clearly wrong. Copie is french, Copy is not.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
