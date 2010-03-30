From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Tue, 30 Mar 2010 15:25:12 -0500
Message-ID: <20100330202511.GC10977@progeny.tock>
References: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com>
 <20100330183748.GA10647@progeny.tock>
 <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com>
 <20100330201007.GA26121@LK-Perkele-V2.elisa-laajakaista.fi>
 <f3271551003301315i4bee002dm572e179819dbb1cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 22:25:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwhzp-00008l-AA
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 22:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab0C3UZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 16:25:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36774 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab0C3UY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 16:24:59 -0400
Received: by pwi5 with SMTP id 5so8127606pwi.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JCY4pjSXRu06sBValhqHJaR5mT1mva9OfuETCu5aZyk=;
        b=d40w6mPtHSB9padf4uBCOd4rniHUzJeffLjzRiZPqxJLvY7t8/LYHPCRJPDh5b/nOu
         gZLLuiCXiDmF4UrWp7x/rOpU7SXLMWwnIbrlw8gbgfPhhs/amJf0euQcSnXJdjQ+9LEc
         URXN983Ej8OazaYHC8dQDp9t+p1AqzLHdsiZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pa7g8GRVlK0GZLBxZu1ifyV3bVBKt8UmqCZE2Ps8RkMtlXSY/AackQ9uisY/TSoJtm
         zabtLu3OboEVleXoTrYMLUjCS4gQmYxHEWUMAB9yxE43ZsIF2AD9KQYOJG0AdGgqoOLS
         pUYu5xLW5h48HtbBiiNCvYdS7qbJQOw/Zpxr0=
Received: by 10.141.106.16 with SMTP id i16mr5843881rvm.220.1269980699355;
        Tue, 30 Mar 2010 13:24:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 11sm1309739pwi.1.2010.03.30.13.24.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 13:24:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003301315i4bee002dm572e179819dbb1cd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143600>

Ramkumar Ramachandra wrote:
> On Wed, Mar 31, 2010 at 1:40 AM, Ilari Liusvaara wrote:
>> 'tls://srp-Ilari@[1067a6e3af81b5ea76d615280eee2bc3dd2e8079@tcp/ipv6~=
fe80::20e:a6ff:fe6f:2288%2]:7684/gitolite-admin'
>=20
> On Wed, Mar 31, 2010 at 1:29 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> What I meant by "arbitrary string" is that it doesn=E2=80=99t have t=
o have the
>> form schema://path, it=E2=80=99s not restricted to a particular char=
acter set,
>> it doesn=E2=80=99t have to avoid conflicting with meaningful URLs de=
fined by
>> other helpers, and so on. =C2=A0So it=E2=80=99s a resource locator b=
ut not very
>> uniform.
>
> Well, we're trying to document all these "urls" in urls.txt [1]. I
> should perhaps use the term "URL recognized by Git" and include a lin=
k
> to the urls page in the documentation?

Hmm.  urls.txt is not currently its own page; instead, it is included
in git-clone(1) and so on.  I hope to change that this weekend.

More to the point, wouldn=E2=80=99t "URL recognized by Git" mean a stri=
ng
like fd::3,4 rather than the 3,4 that is passed to =E2=80=98git remote-=
fd=E2=80=99?

Also worth keeping in mind: we want to support third-party helpers, too=
=2E
So it is hard to have one centralized document that completely explains
all possible URLs.

Jonathan
