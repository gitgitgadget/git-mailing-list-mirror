From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/4] git-cvsserver: break from loop after a successful hit
Date: Sat, 3 Jul 2010 22:20:07 +0000
Message-ID: <AANLkTikYBF7TE3i68CcX_76pLGW7M1X6xAecAGvhtb0C@mail.gmail.com>
References: <AANLkTimPJPv0RieGQcXyJULFDcapVM74JCXcM9LU8CEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 00:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVB4K-0002JN-Oi
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 00:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674Ab0GCWUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 18:20:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40942 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab0GCWUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 18:20:08 -0400
Received: by fxm14 with SMTP id 14so3007139fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xMC/pLgpqOpBM5fsGFBSFR2vlvIz7SXlGcXuY5jEII0=;
        b=JLPsMyIdr4s1+HCuawAJqpPjfMNh/F02A31YcGh88yk2Bf8R8oVFx8fUl3SjsA3Y7w
         DfWk4boGlh1xZb26xNit514r6uX9WVJEGx19rjzJl5DMDrHiIx95zCwn42GzTYLKB8/x
         FBLyyrOqlu4ZQEsIqeGom+VDxrSavaIY0I5R4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GgujOiGzpf1dgpBHgkXsTtDIftUoMDdzJmGtcH8uz9n/rh0LqVHI8mzT0nMAmc3buy
         eka1UsyihBF+/PtCywhDRbQw80FqS9mRFYgjwPa50oW/aprp6K3AYKnPF1dmpB/bETXY
         wAWgYJbNs+OPxkF6zjNGhwNqLDZ6x4HpHZCt0=
Received: by 10.86.29.7 with SMTP id c7mr615463fgc.59.1278195607329; Sat, 03 
	Jul 2010 15:20:07 -0700 (PDT)
Received: by 10.223.103.84 with HTTP; Sat, 3 Jul 2010 15:20:07 -0700 (PDT)
In-Reply-To: <AANLkTimPJPv0RieGQcXyJULFDcapVM74JCXcM9LU8CEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150210>

On Sat, Jul 3, 2010 at 21:24, =C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@=
gmail.com> wrote:
> No need to check for more lines of the authentication database after =
found a
> matching line.

Indeed.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
