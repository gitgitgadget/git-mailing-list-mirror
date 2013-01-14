From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 03/31] Add parse_pathspec() that converts cmdline args
 to struct pathspec
Date: Mon, 14 Jan 2013 08:11:59 +0700
Message-ID: <CACsJy8DBcmFDBYXQDuS_8u5sA+1z5GUpBN1kv8KYcwF9gg=mFg@mail.gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
 <1358080539-17436-4-git-send-email-pclouds@gmail.com> <CANiSa6icv7V7hoEzHQT0mgqjCDcSkuLvZ2M=6Q5gp6NcXJ20jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 02:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuYbe-0002BW-Iz
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 02:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab3ANBMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 20:12:31 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47042 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3ANBMa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 20:12:30 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so3408908obb.35
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 17:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SCI9vLavkAke6M3RzA3ukWbIfReL7dq+nKVrcxs2/Ck=;
        b=xSkeGx4IwWXv9jgaB+BSX+FOaNAjXLfhaKPEsC0zip7ZZsVoARA2xKTegLN6OB2GMl
         R67NF193unORvEtreOohlygzE+CnSODsGbOksjDzVOSNaWwUZtTyWLbsr696oNK7APpR
         Yk9MFchomgrdZ5GxFPcQPvFpannJMEhmrDZ3rs0AKJJ7qFCHiMc5g7hiFwtVVoh73vcO
         jnNzL2oA4q8NKX6rgIAAVYTwiOO1OgYEK/JSPZ+jJMvbjizdhp5Uegtq5utJ/QsZ83Rk
         sA9oNZ+yeK7MsGVDsKEWW+XKn0L0YZmdgzfMg6ObJ+NeC+QeFNKZRC89GCLGcU5LTSiK
         HSuA==
Received: by 10.60.29.66 with SMTP id i2mr50206712oeh.2.1358125950322; Sun, 13
 Jan 2013 17:12:30 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 13 Jan 2013 17:11:59 -0800 (PST)
In-Reply-To: <CANiSa6icv7V7hoEzHQT0mgqjCDcSkuLvZ2M=6Q5gp6NcXJ20jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213413>

On Mon, Jan 14, 2013 at 7:05 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Sun, Jan 13, 2013 at 4:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> +static void parse_pathspec(struct pathspec *pathspec,
>> +                          unsigned magic_mask, unsigned flags,
>> +                          const char *prefix, const char **argv)
>> +{
>> +       struct pathspec_item *item;
>> +       const char *entry =3D *argv;
>> ...
>> +       for (i =3D 0; i < n; i++) {
>> +               const char *arg =3D argv[i];
>
> Nit: "*argv" was assigned to "entry" above. Reassign that variable in=
stead?

Yeah. Thanks for catching.
--=20
Duy
