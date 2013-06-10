From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 13:25:21 +0530
Message-ID: <CALkWK0n+yF-kRahgsQQuT-+QiT5gy=J_Bdati=uooiW0djQrgw@mail.gmail.com>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <1370680434-2709-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <CALkWK0==9aN1wVoSXENvTJHOT8bd2SYrEFxrmTdhzMxB3mHPCQ@mail.gmail.com> <19969d9996306bf0e7ac6351d4ad435d@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:56:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlwxU-0003LL-GV
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab3FJH4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 03:56:03 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:61240 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab3FJH4B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 03:56:01 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so954582iec.27
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NnzTOdIVWsvTVqZOTDVYRdNmamPytRpCD5n1PcPFNr8=;
        b=A45kyhhImzNAMBU7KpcAxeS2k0u2Ufi0NCffxut8uOFHdcVgqFjei4BVu8mfRp2Seo
         h8wp1nZ9gX2+8vDHfU/599bbsOpg9MjOmINuNN7kcyqFzIGoRYPRWD+L83qZaiK6xMKI
         zJpsCTnXJpyk+f68T5Fn37vKw28DLafyrk00X+wsYHrUVe3V2cQjy+uAe9vZP8L5eK/4
         untrIbC6XAxgJlyYHElQM9/24VFHaMF9Kpq7Bv1uxGcuMaBhlB8G6uDbWY9NUwV4uD6X
         5JwRaKMZ4B/Zrw7ans2geE30NJg2Z+8u+1fvTAW2PHyz6AERUfiMBwpfmBs4zZNcsC6g
         OHlg==
X-Received: by 10.50.25.194 with SMTP id e2mr3453621igg.111.1370850961516;
 Mon, 10 Jun 2013 00:56:01 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 00:55:21 -0700 (PDT)
In-Reply-To: <19969d9996306bf0e7ac6351d4ad435d@ensibm.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227255>

Mathieu Li=C3=A9nard--Mayor wrote:
> I'm not so sure i understand. Do you mean rmHints should deactivate a=
ddHints
> aswell, or do you mean that since we're introducing rmHints it would =
be
> natural to introduce addHints ?

More the latter, but I'm tilting towards addRmHints (or something)
which affects both add and rm hints.

> Sorry about that, we'll work on it.

Nothing to be sorry about.  You're doing good work, and we're helping
you make it even better :)
