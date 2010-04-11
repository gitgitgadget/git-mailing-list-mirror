From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Take it easy on unallowed access to non-existent 
	repository
Date: Sun, 11 Apr 2010 17:45:46 +0200
Message-ID: <l2ifabb9a1e1004110845l7cc89b70y9878dad9e1537e8d@mail.gmail.com>
References: <20100409001322.GB23501@coredump.intra.peff.net> 
	<1270983682-12215-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 17:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0zMW-0007Xo-2k
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 17:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0DKPqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 11:46:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46626 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab0DKPqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 11:46:08 -0400
Received: by gwj19 with SMTP id 19so556049gwj.19
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j1CoNwYPkmYCv7dRlenxlOxZWzDTgR7ssbXr4yvF558=;
        b=NkaeBrw3FG8LkfIBGdy36FMbV6WLL7HKZwuUhYw8el0WywNB6NYNQwj5AybuifuYhz
         fUfxzLtcRTIfi3eKhvx+gX9OcLvqtqwLKQ3ZXwyzQoPMpO3hZfFjPpFSaaqXrLlXsRls
         3dN4JdHz3TXHow40rlmaAGKL/Cf1mhktnKvQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ta5GuCvJBDC18c8RRWPXCwVPGDLm9/QCef8dzUqoW+RnN1bMozGnShdQC2yJPflpsS
         +Bmx6r4t4WvHTM32QoMfsLF3oSmGbd9OzbINHFeyNitC6ptVHLmObfvBpClFiJAxeMlp
         EK1nA6yKEXYrmGxRqksggTK/7SjDQ1x45/NmA=
Received: by 10.100.206.13 with HTTP; Sun, 11 Apr 2010 08:45:46 -0700 (PDT)
In-Reply-To: <1270983682-12215-1-git-send-email-pclouds@gmail.com>
Received: by 10.101.109.20 with SMTP id l20mr5045244anm.37.1271000766214; Sun, 
	11 Apr 2010 08:46:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144651>

Heya,

2010/4/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (startup_info && !startup_info->have_ru=
n_setup_gitdir)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("internal erro=
r: access to .git/config without repo setup");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning("Broken re=
pository setup: early access to $GIT_DIR/config");

This makes it sound like whatever is the problem is caused by the
repository that is being operated on, rather than git's code, is that
correct?

--=20
Cheers,

Sverre Rabbelier
