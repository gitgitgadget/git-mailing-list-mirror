From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git notes"
Date: Sun, 17 Apr 2011 09:20:50 +0200
Message-ID: <BANLkTink3uzx3xz5_pG6FmFctD_2W6HiCg@mail.gmail.com>
References: <4DA7F73B.9050007@gmail.com>
	<7v7have8wo.fsf@alter.siamese.dyndns.org>
	<4DA8862F.5070102@gmail.com>
	<BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
	<BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com>
	<7vk4eub1g9.fsf@alter.siamese.dyndns.org>
	<BANLkTim2=Jg4QcgKwO=J6343zWAoCkyXZQ@mail.gmail.com>
	<7vaafqay9f.fsf@alter.siamese.dyndns.org>
	<7v39lhbnzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 09:21:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBMI7-0000Dw-7M
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 09:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab1DQHUx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2011 03:20:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33773 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab1DQHUv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2011 03:20:51 -0400
Received: by qyg14 with SMTP id 14so2453474qyg.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hfYbHrbr23FiSFishqW9crCkynlPAxUsWJLTz7wmfpQ=;
        b=fJueNggGHC9fq0gG0c+4MkuubUN7rHUpfM8s4ZixsRxy2i9+tpTYDITdaepBH+5TVd
         OSh5FL4292bhKDvHDWL4BsEj/suX9AzDDkB/HSGBpydke0v6lTdMNWyRyZ859BbFVg6R
         k7ySUyaYzT1NfTaw5/odhNunfXn3KDjvPk0BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U9GCpHmHCaWHlYGv+WpHUmOVBjVSe7CeNhreXqUENUqCJ66iGblIn46MblumTMtCb3
         Wz6pKemapF2cnYd2ZfD3pLYpIsLUvEpwnyfq8LXYxpzoaFkIiQDLx22ctQ/AwhB70vhj
         uc5wE1zvB5+cJy+IaVd7OpIE/JJbiGANH9Z9o=
Received: by 10.229.50.193 with SMTP id a1mr2569271qcg.177.1303024850849; Sun,
 17 Apr 2011 00:20:50 -0700 (PDT)
Received: by 10.229.241.17 with HTTP; Sun, 17 Apr 2011 00:20:50 -0700 (PDT)
In-Reply-To: <7v39lhbnzj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171717>

On Sun, Apr 17, 2011 at 04:39, Junio C Hamano <gitster@pobox.com> wrote=
:

> So to conclude,...
>
>>> + =C2=A0 =C2=A0 =C2=A0 cherry-picked from. =C2=A0This is done only =
for cherry
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0picks without conflicts. =C2=A0Do not us=
e this option if
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0you are cherry-picking from your private=
 branch because
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the information is useless to the recipi=
ent. =C2=A0If on the
>
> ... we could just remove the "This is done only for cherry picks with=
out
> conflicts." =C2=A0We could explain that the user may want to remove t=
he line
> depending on the nature of the conflict resolution, but I guess it ca=
n
> be left without saying.

Still, I believe it would be more consistent to do this change as part
of the CHERRY_PICK_HEAD series itself, then.

--=20
Sebastian Schuberth
