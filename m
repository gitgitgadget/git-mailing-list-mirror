From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git status & seg.fault
Date: Tue, 26 Oct 2010 11:47:30 +0200
Message-ID: <AANLkTinpUKP8XaLR6d530BW8DuFqUzettuivin88xwuE@mail.gmail.com>
References: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com>
	<AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
	<AANLkTikhU+hBwsh24JYGmwHoNFGMseAx_+rUMYH4XGkT@mail.gmail.com>
	<AANLkTimRBmJkXh9LjgL51bwFD=AGBJRc2d1R0g=z0v2t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Rado Dr." <radodr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 11:47:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAg84-0001Ct-SI
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 11:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845Ab0JZJrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 05:47:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58134 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab0JZJrf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 05:47:35 -0400
Received: by fxm16 with SMTP id 16so3885369fxm.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EgH8esVeimPwvLEkWtUQaPO1UspqOZNBDCWpLw1mTI8=;
        b=vnF6Av/FcWGJP/T9l+4nNgp3t9RlryP5SLLGs+Hu0486HoHqsIJaHl2pYyXN4ndIPj
         /M6Qvb+G5xOBmUVEIOrACvkU0OAd0xSYgYF2pF7p2ePWdqHC3hHwwvdxdlR6wC6MJ68a
         vRsKKgC6uU58wZI1kDn8lKR9e7ZY5yRiBaqFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WjN9s7mfyTD16cC/CzInptuBG+shhK4DhYBNjxZfdxsfVb0o974w0Kmbp3Wkke6WCF
         9WhvW2nWOUGoHczzRCjWVhgG3B56s+D6zGzNPilibbXOzcZbUD07f4l6fjhFvorWk8sR
         i3pIBLzHRhDJmxeXP2FzH7HJTzgK2cbl+QzXg=
Received: by 10.223.79.7 with SMTP id n7mr590238fak.33.1288086450732; Tue, 26
 Oct 2010 02:47:30 -0700 (PDT)
Received: by 10.223.115.5 with HTTP; Tue, 26 Oct 2010 02:47:30 -0700 (PDT)
In-Reply-To: <AANLkTimRBmJkXh9LjgL51bwFD=AGBJRc2d1R0g=z0v2t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159986>

On Tue, Oct 26, 2010 at 11:45, Rado Dr. <radodr@gmail.com> wrote:
> there is output:
> Reading symbols from /usr/local/bin/git...done.
> (gdb) run
> Starting program: /usr/local/bin/git status
> [Thread debugging using libthread_db enabled]
>
> Program received signal SIGSEGV, Segmentation fault.
> hash_index_entry (istate=3D<value optimized out>, ce=3D0xb7c00c90) at=
 name-hash.c:44
> 44 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hash =3D hash_name=
(ce->name, ce_namelen(ce));
> (gdb) bt full
> #0 =C2=A0hash_index_entry (istate=3D<value optimized out>, ce=3D0xb7c=
00c90) at
> name-hash.c:44
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D <value optimized out>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hash =3D 3198509075
> #1 =C2=A00x080dde47 in lazy_init_name_hash (istate=3D0x8194180,
> name=3D0xbfffb34b "src/FotoPlusServer/build.xml", namelen=3D28, icase=
=3D0)
> =C2=A0 =C2=A0at name-hash.c:59
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nr =3D 16273
> #2 =C2=A0index_name_exists (istate=3D0x8194180, name=3D0xbfffb34b
> "src/FotoPlusServer/build.xml", namelen=3D28, icase=3D0) at
> name-hash.c:108
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hash =3D <value optimized out>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ce =3D <value optimized out>
> #3 =C2=A00x080cf190 in dir_add_name (dir=3D<value optimized out>, bas=
e=3D<value
> optimized out>, baselen=3D<value optimized out>, check_only=3D0,
> =C2=A0 =C2=A0simplify=3D0x0) at dir.c:449
> No locals.

I haven't tried to grok all that, but you'd get a better backtrace if
you compiled git with debug flags, e.g.:

    make CFLAGS=3D"-O0 -ggdb3"

And then did gdb ./git .... Sorry for not mentioning it to begin with.
