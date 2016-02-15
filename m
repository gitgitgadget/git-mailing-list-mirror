From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Custom merge driver with no rename detection
Date: Mon, 15 Feb 2016 09:06:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602150858340.2964@virtualbox>
References: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-278220595-1455523610=:2964"
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:06:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVEBM-0003Lr-Ct
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 09:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbcBOIGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 03:06:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:55683 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbcBOIGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 03:06:52 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LzblK-1ZsA5g19SE-014mtA; Mon, 15 Feb 2016 09:06:50
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:tQMFnB5sV3JizEw1FMYSOjkvDKTIhqC8N6KRnQiuUspCzyeXq0v
 qycD6VHcJrxe/DKFNibV+VBUztueq1dV1oAOj37RA7DvpShWgG3/kgqM0Rbku97mZmmuQ4U
 37xhBOn0UOg5kngeb8KpMp/IMo17cqrkiQONkFWOlRg17WYUjWOKdw0l5gwsVJJi/7PhFsI
 9rvAo7q0GFs33sN/1ZKNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EMVfPFS/i4U=:yiVbw3NKWDGfcFyaS1MqEp
 djZXYMS4p1R25q1XKBokAgruWM9YwPkEP71hf8tpSOG9DJuQZTvtLA09MvjH/ClfELntZHJO7
 88cU1Hgh48TQOTlGud087uF4C6p/5I+RSNBKjwdbCvEdduM6V9xSG1mcHl0gTZY6JYmqLG8Al
 VDz0ZCVNYCrZfeU0ZOPnaoizB7QSi+i44UkCQGRGA2KZDo/3s7AoqbD2FRDAsdFNbZKO2rq6q
 BJntkQLxsgQ8/n+G0N/8I8DPaWAg+Y1TCgn8HJANMftfKDdUKMwiFc6tNCaSPj4/wjVSHAvKW
 QLdVytyfZ3LUWt2VjOqfq7m/zud3cbntPu2IsNu8y9Qx7RxYntLHCHYdFo1t1tBZG4lq83FF0
 Bm7TXILW1rX0Z07ZB3gk7OGvT72dTIychSf9ZqKE/hcoz36Iqbu5bwIHCKkeDmLnUV1QUYrZ6
 ckTP1ApimiHGWcP/AZ33SEmaJlZaNNDWPMYIvsYmmkzRsDDsi3xAqg3FtsOVLVxH1ffmFBzbd
 d5XdMKHVuzo71oAhnD6E14POziOaXiyULa47vw10sLr/9SocBz2G8D/s8q4nnZpen1nbPCB2y
 3Ftn4evztTbCNTCy1QAo8RdP6w/ElIcuF84TBhYajNSQmlP3oA4p7ibIhCk7yLDn212ekoghi
 t2cgw/8YsnBu6gN46xmSJy6EKuwimD1Zfvx5qT2aoE20qLYtodVedZwlJ1dIEuZaO4hrVO6Pj
 es8e7MW1oeYyrIcGt1UpfIaW3C3sePLW2Y4qLSiahz2YZSA2BjWlYJG2f2a6KRV4dsOiO4Pa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286180>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-278220595-1455523610=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Felipe,

On Sun, 14 Feb 2016, Felipe Gon=C3=A7alves Assis wrote:

> Attached is a quick and dirty patch that emulates the effect by
> allowing greater than 100% rename thresholds to mean "no-renames".

It is really hard to comment on attached patches.

First comment: the commit message is awfully empty, and lacks a sign-off.

>         /* user says num divided by scale and we say internally that
>          * is MAX_SCORE * num / scale.
>          */
> -       return (int)((num >=3D scale) ? MAX_SCORE : (MAX_SCORE * num / sc=
ale));
> +       return (int)(MAX_SCORE * num / scale);

Uh oh. I suspect this opens the door pretty wide for integer overflows. I
could imagine that something like

=09return (int)(num > scale ? MAX_SCORE + 1 : MAX_SCORE * num / scale);

would work better, but it still would need some careful consideration.

>  static int diff_scoreopt_parse(const char *opt)
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index af1fe08..7cb5a3b 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -497,7 +497,7 @@ void diffcore_rename(struct diff_options *options)
>                         register_rename_src(p);
>                 }
>         }
> -       if (rename_dst_nr =3D=3D 0 || rename_src_nr =3D=3D 0)
> +       if (rename_dst_nr =3D=3D 0 || rename_src_nr =3D=3D 0 || minimum_s=
core > MAX_SCORE)

This line is too long now.

Ciao,
Johannes
--8323329-278220595-1455523610=:2964--
