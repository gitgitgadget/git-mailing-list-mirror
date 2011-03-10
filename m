From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Thu, 10 Mar 2011 17:37:29 +0100
Message-ID: <201103101737.32237.jnareb@gmail.com>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org> <m3k4gh7r0m.fsf@localhost.localdomain> <AANLkTikD2M=33B9E2mpBEmT5rLsZHPFc-T5Yqp3EMRJx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 17:38:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxish-0002Fz-9I
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 17:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab1CJQi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 11:38:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64845 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1CJQiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 11:38:22 -0500
Received: by fxm17 with SMTP id 17so125202fxm.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=/sEAej/DMys3mEZPI9VSC+tlOoLw5qeSZe2UJrUB2hI=;
        b=sDXl206FEy0wbEOfe5pbExaGsAz9o98d7pI36vFVLIi0ewAeG+uMy0Bb9FI/1JOHFy
         uvg/JakAKV1j++C8ZcHS41fGJ6Lbaal025qf9q6QpaD7iHPLPf3dTsZ1z9Zu93j9RmS9
         loFcptsKSAxvovg0SXZnWZrdrmPtzxHrRRtlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XirlMsYEox+3w1TnjuBG0O5dSBixH303mQ+0AvRwObJDS4SHWNSHGrQIElAeWeAO7N
         c/mZuq+78pHAakLFkgecFKpyG/n971PLHd+AEGdzAlOIb+2ZZHm2qUZX2V576YGbK4MH
         ijRTYrn8dDSezTryv8RCUclwKoZJkfuGDBATw=
Received: by 10.223.151.9 with SMTP id a9mr4266445faw.64.1299775057649;
        Thu, 10 Mar 2011 08:37:37 -0800 (PST)
Received: from [192.168.1.13] (abwi220.neoplus.adsl.tpnet.pl [83.8.232.220])
        by mx.google.com with ESMTPS id n15sm1472141fam.12.2011.03.10.08.37.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 08:37:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikD2M=33B9E2mpBEmT5rLsZHPFc-T5Yqp3EMRJx@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168832>

On Thu, 10 Mar 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Mar 2, 2011 at 11:32, Jakub Narebski <jnareb@gmail.com> wrote=
:
> > Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> > > Don't know how it's handled in shell scripts or perl or whatever =
other
> > > language (which does not use gettext?)
> >
> > Both shell scripts and Perl scripts would use gettext: gettext.sh f=
or
> > shell, Locale::Messages for Perl (we need lower level than Text::Do=
main,
> > and Locale::Maketext is first no longer recommended, and second doe=
s
> > not use gettext at least by default).
>=20
> The i18n series uses Locale::Maketext:
> https://github.com/avar/git/blob/ab%2Fi18n/perl/Git/I18N.pm

If I remember correctly previous version (maybe a few iterations in
the back) used Locale::Messages for Perl i18n, isn't it?

> What do you mean it's not recommended? There are some articles about
> Perl i18n saying you shouldn't use it, effectively because:
>=20
>  * Building GNU gettext is hard, let's go shopping.

Git would use gettext for C and shell anyway, so this doesn't apply.

>  * There were some bugs in it, which do not apply to us.

   * Gettext support for plural forms etc. (ngettext) is better
     and easier to use for translators; Locale::Maketext requires one t=
o
     be a programmer.

> So using it is fine. I might still write some Gettext::XS::Tiny modul=
e
> that works with both GNU gettext and Solaris, stick it on the CPAN an=
d
> make us depend on it. It would more closely align with what we
> need. But that's something for the far future.

The Perl Journal article on using Locale::Maketext is supposedly outdat=
ed,
see http://rassie.org/archives/247 (On the state of i18n in Perl) from =
2009.

<blockquote>
  One basic, but fatal, mistake Maketext does is off-loading a lot of
  linguistic work onto programmer.

    * One particularly important point is the plural forms support ('1 =
apple',
      '2 apples'), which is important for many languages outside of USA=
 and
      Western Europe . Maketext requires you to write a quant function =
that
      gets a string and a number as parameters and does some voodoo to
      produce the right string. Voodoo is undefined. In gettext it is -=
-
      a formula for producing plural forms is defined which selects one=
 of
      provided plural phrases.

    * No translator in his sane mind will ever write a Perl module for =
a
      language (they aren't programmers, remember?), the programmer wil=
l
      have to do it and will also have to understand the implications.

    * The quant notation ("Your search matched [quant,_1,document]!")
      foolishly assumes word order is the same in all languages.
      Implementing a quant method properly would require passing the wh=
ole
      sentence into the function and doing a complete linguistic
      transformation which is highly non-trivial and better done by hum=
an.

    * Most of those linguistic =E2=80=9Cconventions=E2=80=9D like numbe=
r formatting or
      plural forms do not change over time and can be compiled at one p=
lace.
      One such place is Unicode=E2=80=99s CLDR project, which also incl=
udes plural
      form building and number/date formatting among other country- and
      language-dependant data.

    * It can=E2=80=99t even be assumed that the translators actually kn=
ow all of
      these conventions! They might assume they know them, but translat=
or
      is not necessarily doing translations for a living, he might be a
      volunteer, like in most open source projects. Imagine what happen=
s
      when an amateur translator explains the inner workings of his nat=
ive
      language to a programmer?

</blockquote>
--=20
Jakub Narebski
Poland
