From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu, 31 May 2012 21:18:20 +0700
Message-ID: <CACsJy8AAnDDGSusfd2EaKW-sj=kM=xE5tET0RprEyszOBYOztg@mail.gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com> <1338469482-30936-3-git-send-email-pclouds@gmail.com>
 <20120531134538.GA10523@burratino> <CACsJy8Bgzkc51N+t=0NyOasJRd2y3U+pyZCGa-qGoDuTQuyOgg@mail.gmail.com>
 <20120531141020.GD10523@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 16:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6DK-00006q-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092Ab2EaOSy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 10:18:54 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48944 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab2EaOSx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 10:18:53 -0400
Received: by weyu7 with SMTP id u7so658160wey.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jf6TWy+PE+WSSTlgkhAf1CJTCtto4sgMN1BBmvw6DFk=;
        b=CM4/5fEs0JzTXmYXgsLxk2T/tOfNkGvC3Ds+iHlwAnpcN4T+jiwokmgs2BLEFwEbuI
         QBD6ZuH60FlCt/r7cOzDqd9eUFTJDatRLOsAn5YRl7GtLXCwpLDUU9SVcwSy4WCgk0t2
         a+kGKBqsU2qL+CMLKrZ0pFU7MJSJYlX8E2zLmKMgZ7QwYGAZPgAvvCztKBg1C5GoIl7O
         xc0kkVT1SvTtS65syDCUnXPmTlqrQKpWaHiYBZUa13fjlnkFe3ypy5PjUC+aF+16wFtP
         tV3H6VU5rqrON2K3+MTgj4Zes6OiGswh++jrzR2GkBQ9n0luIjRoLzl7tPFTJlwQECiE
         HZqA==
Received: by 10.216.216.95 with SMTP id f73mr13262293wep.149.1338473932096;
 Thu, 31 May 2012 07:18:52 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 31 May 2012 07:18:20 -0700 (PDT)
In-Reply-To: <20120531141020.GD10523@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198906>

On Thu, May 31, 2012 at 9:10 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguyen Thai Ngoc Duy wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Maybe adding
>> --plumbing for scripts?
>
> That wouldn't take care of existing scripts, and new scripts should
> use LC_ALL=3DC to defend themselves when they don't want to be impact=
ed
> by i18n.
>
> Do you have some other reason in mind that a script should choose to
> pass --plumbing here? =C2=A0Is it an output format flag specific to '=
git
> reflog expire', in the spirit of status --porcelain, or a more generi=
c
> "I care about output stability" flag that spans multiple commands?

I was thinking (but without checking) that this is the only way a
script can check for expired reflog entries. Maybe something more
script friendly, like ref names only.
--=20
Duy
