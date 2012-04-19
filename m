From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 15:52:44 +0200
Message-ID: <CABPQNSa7NiK=baYbDBENt-An0mFGn1i+GPnN_=LpqAVScXrG2w@mail.gmail.com>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net> <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
 <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com>
 <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com>
 <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com> <4F9017BF.90702@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 15:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKrne-0001aF-A1
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 15:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab2DSNxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 09:53:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63259 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab2DSNxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 09:53:25 -0400
Received: by pbcun15 with SMTP id un15so10266642pbc.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=CkrbDg1oLo46oUMswPKR/bjqkIU94eViuOv1XU8j+D0=;
        b=DTGT9WeNV8qxUDfoawqk7nh0I3F2546Gr0x/jdoWCPhRbjjCsr+BT+NS5dXtSWiy1S
         JTLGw/qhICrgd+owFXZbNlKi9ulAZlbimM0z4PA0AoHSNGXPREMZgtLaUDBlmX1a1/C9
         sxQhbmztvvPDTgD96UFfyf5xJVRX1llPXDcw1NQVyenrjsaTNLKPLM6MAbni/9I22Cst
         32Nk9XjT8Umc/8WxbUDzXWFPyn0BEXbSw0c6UUtyl8ijXGrMgbCZUPDagj75GF7q4YCa
         w6zfgBIKos4OZ1Bye9YLFDPzJhOk/V+PhOLEp0m08vKZEF4Awnv2rw9Uj/nXgBSrprM2
         Hrdw==
Received: by 10.68.138.196 with SMTP id qs4mr4445572pbb.159.1334843604597;
 Thu, 19 Apr 2012 06:53:24 -0700 (PDT)
Received: by 10.68.236.105 with HTTP; Thu, 19 Apr 2012 06:52:44 -0700 (PDT)
In-Reply-To: <4F9017BF.90702@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195946>

On Thu, Apr 19, 2012 at 3:48 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 4/19/2012 15:31, schrieb Erik Faye-Lund:
>> int main(int argc, const char *argv[])
>> {
>> =A0 =A0 =A0 =A0 int i, fd =3D open(__FILE__, O_RDONLY);
>> =A0 =A0 =A0 =A0 for (i =3D 0; i < 2; ++i) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char buf[11] =3D {0};
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mingw_pread(fd, buf, 10, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("buf =3D '%10s'\n", buf);
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 return 0;
>> }
>
> The test is flawed. It shows only that pread can read twice the same =
file
> location.

Oh, you are of course right. *slaps forehead*

> But it must not update the file pointer, whereas the
> documentation of ReadFile says (quoting the paragraph that is relevan=
t for
> us):
>
> =A0If hFile is not opened with FILE_FLAG_OVERLAPPED and lpOverlapped =
is
> =A0not NULL, the read operation starts at the offset that is specifie=
d in
> =A0the OVERLAPPED structure. ReadFile does not return until the read
> =A0operation is complete, and then the system updates the file pointe=
r.

Indeed. Correcting the test to first do pread and then read reveals
that the file pointer does indeed get updated. Grrr...

> Hence, your mingw_pread() looks like a workable solution for our purp=
oses,
> but is still not a 100% correct emulation of pread(). (Testing all th=
is
> will have to wait for another 18 hours or so.)
>

I don't know our use-cases, but I'd be a lot happier if I could find a
safe way to have it not update the file-pointer. Just reading it and
setting it back again would be racy.

>> Yeah. Other platforms are still an issue. You didn't address those
>> either in your patch, even though it would be possible to modify it =
to
>> deal with them by checking the NO_PREAD and NO_PTHREADS defines.
>>
>> But they would still have the problem with the file-pointer racing f=
or
>> non-pread operations. Perhaps simply disabling threading is the bett=
er
>> choice for these?
>
> I think it is better to keep threading on in general, but only disabl=
e it
> for index-pack. Why should existing users take a performance hit?
>

Good point.
