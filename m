From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with
 gettext
Date: Fri, 4 Jun 2010 22:38:49 -0500
Message-ID: <20100605033849.GB2252@progeny.tock>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
 <20100605030059.GB2019@progeny.tock>
 <AANLkTilSJ_1STKGvat0llqYVZRI8_tQriE-hIBJPEldn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 05:39:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKkDr-0001Ue-Rh
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 05:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411Ab0FEDiz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 23:38:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64167 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab0FEDiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 23:38:54 -0400
Received: by iwn37 with SMTP id 37so1713358iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TUssmxd6XO+wFJx0Q+AfVbKJjM/bowpDudpKK595XsU=;
        b=MSNeFq8iQQ3KQvki7TrzhCQYC+pkfwEoEKrIO0Dvz8F16AWuRGeWeUeSJOsbN7Z04c
         jL2OGbq8nEbk4WsTe+IfFUmAQB/ScFCcx4xJs4T9BJINZquKY+kGK0d7ccEuiLp1i+lR
         JJ3FKEQTJu109ExWGDwr8DauI+IEf/C57gMuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ajNE37P2Nn+B2oa8M4xsRQbGzwYz5TZwY2fWnm0zmgRWmkHSD+jDOXZTOwfCddwv6H
         cdNC9gDOfwB0LzxRehtJESLHy3JGutf0jnGhOd9CDpjCEmpdJZ0LA/Gev7MavEy+c/Aj
         oL8KYWW42Nt/a3+NMRyGS5dBg9Ix1/nObrb78=
Received: by 10.231.130.162 with SMTP id t34mr1746911ibs.157.1275709133577;
        Fri, 04 Jun 2010 20:38:53 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm8374377ibg.12.2010.06.04.20.38.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 20:38:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilSJ_1STKGvat0llqYVZRI8_tQriE-hIBJPEldn@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148456>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Jun 5, 2010 at 03:01, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> =C2=A0#ifdef NO_GETTEXT
>> =C2=A0static inline void git_setup_gettext(void) {}
>> =C2=A0#endif
>>
>> and
>>
>> =C2=A0ifndef NO_GETTEXT
>> =C2=A0LIB_OBJS +=3D gettext.o
>> =C2=A0endif
>
> Sure, but that would be putting code in a header file, which is
> usually taboo. It looks like there's some prior art on that though.
> Like strbuf.h.
>=20
> I don't care either way, what do you think?

This is what =E2=80=98inline=E2=80=99 is for.  I think using it for stu=
bs like this
is perfectly acceptable and improves readability.

Jonathan
