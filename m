From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] Silence a bunch of format-zero-length warnings
Date: Sun, 04 May 2014 15:13:50 -0500
Message-ID: <53669f7ed2877_61fea2d30c62@nysa.notmuch>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
 <20140504190121.GP75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 22:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh2xh-0002R1-7U
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 22:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbaEDUYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 16:24:33 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:49868 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaEDUYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 16:24:32 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so2758128obc.41
        for <git@vger.kernel.org>; Sun, 04 May 2014 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=lPhqfHk/KEqUF+RFEEvFVPw2JF9KA6VQL/Pc/5xYnok=;
        b=wFHE7pnQzGxcNbf/naB50Cr+IHOsvO3NHThNjE26tcB1Ch3SzA/FxTzAOn9tJI/rFt
         OTTGLSl3B3xIywHZqgb1sWY9kwT6Ip4Zs/QiNAMoAdxiRmFIGJ/59tMAxQCltBjcEfV7
         89oUah0yYoELgoHCIUywZKa8huTDJgTNQRKtQVbpYm2zMND6HljqemYn3o/C70xVvC1b
         UmO2SYUTK0/I0Z/Hins2rE2hjLvVuHy4UOMr+rUpoJpLt2Lha7ER4QeKWvMycsjYBj6O
         vBW9KwpMqQgGcZCuBb5jAXbPkbjsQ/udtgoVB81nAs4KC+W0fzjoPpPIHlVrIjRfCtPh
         nP6A==
X-Received: by 10.182.96.168 with SMTP id dt8mr27785377obb.43.1399235072176;
        Sun, 04 May 2014 13:24:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ub1sm27705392oeb.9.2014.05.04.13.24.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 13:24:30 -0700 (PDT)
In-Reply-To: <20140504190121.GP75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248110>

brian m. carlson wrote:
> On Sun, May 04, 2014 at 01:12:55AM -0500, Felipe Contreras wrote:
> > This is in gcc 4.9.0:
> >=20
> >   wt-status.c: In function =E2=80=98wt_status_print_unmerged_header=
=E2=80=99:
> >   wt-status.c:191:2: warning: zero-length gnu_printf format string =
[-Wformat-zero-length]
> >     status_printf_ln(s, c, "");
> >     ^
> >=20
> > We could pass -Wno-format-zero-length, but it seems compiler-specif=
ic
> > flags are frowned upon, so let's just avoid the warning altogether.
>=20
> I believe these warnings existed before GCC 4.9 as well, but I'm not
> opposed to the change.

Yes, I'm aware of that. I didn't say they started to happen in 4.9, I
said they happen in 4.9.

--=20
=46elipe Contreras