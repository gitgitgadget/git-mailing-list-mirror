From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 1/4] commit: remove global variable head_sha1[]
Date: Sat, 20 Aug 2011 19:03:32 +0700
Message-ID: <CACsJy8DpZoQ1zbArePi_vpLqmQP=vq2ZvGYTX-56_jHwtsJwvg@mail.gmail.com>
References: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-1-git-send-email-pclouds@gmail.com> <7vfwkx2pqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 14:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QukHd-0008Ny-S5
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 14:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab1HTMEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 08:04:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36637 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab1HTMEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 08:04:04 -0400
Received: by bke11 with SMTP id 11so2756592bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pxEFjopOK3VfDKXx87Jha7yjbB5e4LFZRy85pa8QjUw=;
        b=uJYQ1uMD3vsJ1w4UG4vcWTa5oIEtFoajYJ48sydnpLwESXipBpqtPdVdH14lE5rRYw
         rpEqfHDd5dGDCWG5lRnLJ2MhSD8oI2tdFVMiOoQAQL9DMyH00w7uQzeN28+N4SZVMxlH
         SVdYdEr7xsAl4yMi1wHhtnMG8TjLKguRORQnM=
Received: by 10.204.155.81 with SMTP id r17mr158112bkw.19.1313841842678; Sat,
 20 Aug 2011 05:04:02 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Sat, 20 Aug 2011 05:03:32 -0700 (PDT)
In-Reply-To: <7vfwkx2pqw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179758>

2011/8/20 Junio C Hamano <gitster@pobox.com>:
> Also wouldn't these three be equivalents?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0head_commit =3D=3D NULL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is_null_sha1(head_sha1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0initial_commit

Right.

> Perhaps like this instead?

Yup. Looks good.
--=20
Duy
