From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/10] i18n: bundle: mark strings for translation
Date: Thu, 26 Apr 2012 08:24:55 +0700
Message-ID: <CACsJy8CzNx9GP2PSszs2rrkQHr0P6fPVe4+-z4QXJ8k_4hqh9w@mail.gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-11-git-send-email-pclouds@gmail.com> <xmqqipgnbffm.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 03:25:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNDSr-0006Vy-3e
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 03:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab2DZBZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 21:25:28 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45044 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab2DZBZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 21:25:27 -0400
Received: by wibhj6 with SMTP id hj6so5594113wib.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Fz5KAs6wKIVynBzihX69Mw9el08qm6epbcSiIuxXYGQ=;
        b=cYIMFMxaP9EzuBzpn/8nv8ZpqTqdgrltofub99zmwgnFMTpG4Lhcg+Ni+O1Qe7nrv5
         jpetMuw8KiadT35L344FlK+SeSP+v7nZVbjMYESXvoQ+PDkX6tPtX4vS01YFUsmALFDa
         LRuXY/w/piL7MCjGKrq5V7bUaxo7yEgc2jElKnWnpUrNVy2Qtijq8jEq9/6f+gFwii1z
         ShrON/BoqM90YYMHHpLorIHSQE/v7EPwRnSqGDZiWB7tdWYscIDwvTE4H9rJH8yu4XaX
         c1Gy7E/6sIGhlILsgA//d4P6ON1y+4KJucFwG0s32qQX/eueZeexN66biH2HS9qnpyRg
         /sbg==
Received: by 10.180.24.7 with SMTP id q7mr31278664wif.11.1335403525677; Wed,
 25 Apr 2012 18:25:25 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 25 Apr 2012 18:24:55 -0700 (PDT)
In-Reply-To: <xmqqipgnbffm.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196347>

On Thu, Apr 26, 2012 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> @@ -283,13 +287,13 @@ int create_bundle(struct bundle_header *header=
, const char *path,
>> =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
>> =C2=A0 =C2=A0 =C2=A0 fclose(rls_fout);
>> =C2=A0 =C2=A0 =C2=A0 if (finish_command(&rls))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("rev-list d=
ied");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("rev-list=
 died"));
>>
>> =C2=A0 =C2=A0 =C2=A0 /* write references */
>> =C2=A0 =C2=A0 =C2=A0 argc =3D setup_revisions(argc, argv, &revs, NUL=
L);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (argc > 1)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("unrecogniz=
ed argument: %s'", argv[1]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("unrecogn=
ized argument: %s'"), argv[1]);
>
> This is a problem in the original but we see an unmatched sq here.

Yeah. I searched the code and that seems the only place with
unbalanced quotes (both single and double quotes). I'll leave it to
you to either drop it or add another one there.
--=20
Duy
