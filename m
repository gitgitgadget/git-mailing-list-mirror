From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 05/17] gettext: make the simple parts of git-init
 localizable
Date: Tue, 31 Aug 2010 11:09:57 -0500
Message-ID: <20100831160957.GN2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-6-git-send-email-avarab@gmail.com>
 <20100831150301.GE2315@burratino>
 <AANLkTikd7mc4DjTVaKip_WFqVdezE13ZbL+Vmfqd8yCu@mail.gmail.com>
 <20100831154446.GJ2315@burratino>
 <AANLkTimPndcAu7RTnzpB0LZ1bHpFC5-QxNkPPAkoD5Hc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:11:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTRF-0001nP-W5
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab0HaQLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 12:11:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44428 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0HaQLu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 12:11:50 -0400
Received: by fxm13 with SMTP id 13so4030859fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=detdJYdeA4q73wTS7dKcAIL6r2vEcYwg2/FVLFQqKAY=;
        b=du2/Lz5Rr2caQovftcKyFHidq1EV3F1iK6BDaqrkUrypXCYlpSmWnqoVKNPNbPgANr
         lIICBjaz5q4wvn0Rr+ChXK+GHNo/kIQVZJeQ7c8yo9WhVYImeW8GgqvNyKeoFt8wSGtU
         IsjekJLnLHOfrDzdhzRZXf5RvI4WMtkhsuDl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eMz58EOpMkXXq0eT5Mu/w8qDBBkKRXGZD0peYd047eQ0XihEZ+jlMj39FSzqngpNUg
         Fj/MbSy06rc85zXtYMBPNnoWq7jeDEJjdyRn4FUnT+qhDBds1gDhIEjYCnz3M9Pg+sLu
         htho1Q3lvPeDf9mLyEdMH6sfPKUnDbu2E2pXE=
Received: by 10.223.106.132 with SMTP id x4mr5685406fao.15.1283271108285;
        Tue, 31 Aug 2010 09:11:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 2sm4047236faz.38.2010.08.31.09.11.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 09:11:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimPndcAu7RTnzpB0LZ1bHpFC5-QxNkPPAkoD5Hc@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154931>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Aug 31, 2010 at 15:44, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> int main(void)
>> {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_ALL, "");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "C");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENODEV;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0perror("test");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> }
>> $ make foo
>> cc =C2=A0 =C2=A0 foo.c =C2=A0 -o foo
>> $ ./foo
>> test: No such device
>> $ LANG=3Dde_DE.UTF-8 ./foo
>> test: Kein passendes Ger?t gefunden
>
> What about with MESSAGES instead of ALL, like we're doing?
>=20
>     setlocale(LC_MESSAGES, "");
>     setlocale(LC_CTYPE, "C");

Same result, alas.
