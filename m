From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] branch -v: align even when the first column is in UTF-8
Date: Sat, 25 Aug 2012 18:19:13 +0700
Message-ID: <CACsJy8BZ77JY=7UhOU_irWm0e4p2incbEpgU5=_oq_WNXGzj7w@mail.gmail.com>
References: <1345817872-7943-1-git-send-email-pclouds@gmail.com> <CABPQNSYabHGzmEfukt1PzT=j3qa99fScDHRZqLZvLNv9cJKXag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 25 13:19:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5EPC-00025m-6I
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 13:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab2HYLTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Aug 2012 07:19:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37471 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab2HYLTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 07:19:45 -0400
Received: by ialo24 with SMTP id o24so5079076ial.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PNTzbg05QAS9zjISjBL17WcFZuu4cu/garnpVV9S8XA=;
        b=oFMiy6kuqw91sON+bFhJokqm7KHln2QYWZ8N+MaJTPRZe+ibG9erCm0DAeJ7y1FGht
         a9KjYyI8KsqfyOGdDEK7mX24+J/X0/AYPYYRKNwR8fnANCWA6sao0ehPxGcjWvjQAJd0
         yQvnyG1enlP8sZC774Lw6ropQ6Fi5bCY1ebjmQl2z9KVmBN2O3U2d2r6WRVO8kpsDXfF
         qveZpwlA0msMWHdlYhNm8Kbhwpk+85PmylaSVurOiYP1X5/m2T2ZdwQNCgmKBk89jgw6
         8szNANaeSbEtWenGWVOdFZtuSJ/uaCnTehtTLTrzjhHyfXx2R/trxnz05THprsqtCa3t
         NsPA==
Received: by 10.50.220.194 with SMTP id py2mr4994586igc.15.1345893584553; Sat,
 25 Aug 2012 04:19:44 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Sat, 25 Aug 2012 04:19:13 -0700 (PDT)
In-Reply-To: <CABPQNSYabHGzmEfukt1PzT=j3qa99fScDHRZqLZvLNv9cJKXag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204272>

2012/8/25 Erik Faye-Lund <kusmabite@gmail.com>:
> On Fri, Aug 24, 2012 at 4:17 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>  1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 5 =
=C4=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 3 b=E1=BB=8B x=C3=B3a(-)
>
> Huh?

Oh, that's something we should fix soon, too. I suggested a "project
language" config key some time ago, where commands like format-patch
should follow. It's hard because only part of the format-patch will be
in this language while error messages for example are still in $LANG.
I've been thinking, but I haven't found anything worth mentioning yet.
--=20
Duy
