From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Wed, 02 Mar 2011 02:32:23 -0800 (PST)
Message-ID: <m3k4gh7r0m.fsf@localhost.localdomain>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
	<AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
	<7v7hckje4n.fsf@alter.siamese.dyndns.org>
	<20110301205424.GA18793@sigill.intra.peff.net>
	<7vwrkiccy6.fsf@alter.siamese.dyndns.org>
	<AANLkTi=+iBR3OBZ=4fi_g=JMQKi=47F47hRsWxK=RbMv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 11:32:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PujMY-000545-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 11:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab1CBKcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 05:32:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35846 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239Ab1CBKcv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 05:32:51 -0500
Received: by fxm17 with SMTP id 17so5739270fxm.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 02:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=O7/tcXtaXMJD2dtK0eFH1mt/7GmBcIGdLqP+WeBP8Z0=;
        b=dAe7W1RI/K7B/GFRSe8ZRrLYlV5CP5tYifiEsbBlBXf4UXjhYy9bBbl3vHU58MI5Vb
         urCpz7CJWD78xa6fIEf4+THG5Q0D1jk8xM4/pQiRE95N4IeWs03q7/liPNKGougdMx0B
         nLjgcZNOFyj0QrRH0fVK7SqCTBlC4Oh+1h/6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=JzFALiUWbLJuVKGYs8teWbDStV5xgquQXjSkvOS5K2GbDfXMbMJhS+zumuhrKv0EOk
         4f/hAf0XeMmNgmq8av02OU2PBti6tWxuscnImVPhokFDl9iLXktwtCW0iW9Mk1Hy7+IT
         HMirf5TfQcx3untw+WUjbX0alwCiigwuKCPHs=
Received: by 10.223.70.141 with SMTP id d13mr9597848faj.111.1299061944352;
        Wed, 02 Mar 2011 02:32:24 -0800 (PST)
Received: from localhost.localdomain (abvi92.neoplus.adsl.tpnet.pl [83.8.206.92])
        by mx.google.com with ESMTPS id n1sm480454fam.40.2011.03.02.02.32.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 02:32:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p22AVi0K001441;
	Wed, 2 Mar 2011 11:31:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p22AVMeb001437;
	Wed, 2 Mar 2011 11:31:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=+iBR3OBZ=4fi_g=JMQKi=47F47hRsWxK=RbMv@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168301>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> On Wed, Mar 2, 2011 at 6:24 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Jeff King <peff@peff.net> writes:

>>> =A0 - Nit: you nicely use "%d commit%s" to handle the single/plural=
 case
>>> =A0 =A0 in the warning message, but then you "them" later on. It ne=
eds
>>> =A0 =A0 (1 < lost) ? "them" : "it".
>>
>> I actually don't like playing games like that, especially when i18n =
topic
>> is in flight. =A0Among the languages I know rules reasonably well, t=
wo has
>> the rule that a countable noun is spelled differently depending on t=
he
>> number of that thing is one or more, and one spells the noun the sam=
e way
>> regardless of the number. =A0Who knows if git needs to be translated=
 into a
>> language whose noun changes its shape three-way, depending on the nu=
mber
>> being one, two, or more?

Well, one of such languages with spelling depending in number of
things is Russian, for which we have translation for git-gui, so
I guess somebody would add one for git itself.
=20
> For gettex this is described at
> http://www.gnu.org/software/gettext/manual/gettext.html#Plural-forms

Which includes example for Polish language:

    1 file       =3D  1 plik
    2,3,4 files  =3D  2,3,4 pliki
    5-21 files   =3D  5-21  plik=F3w
    22-24 files  =3D  22-24 pliki
    25-31 files  =3D  25-31 plik=F3w
    and so on

  [...] =20
 =20
  Three forms, special case for one and some numbers ending in 2, 3, or=
 4
     The header entry would look like this:

          Plural-Forms: nplurals=3D3; \
              plural=3Dn=3D=3D1 ? 0 : \
                     n%10>=3D2 && n%10<=3D4 && (n%100<10 || n%100>=3D20=
) ? 1 : 2;

     Languages with this property include:

     Slavic family
          Polish

=20
> Don't know how it's handled in shell scripts or perl or whatever othe=
r
> language (which does not use gettext?)

Both shell scripts and Perl scripts would use gettext: gettext.sh for
shell, Locale::Messages for Perl (we need lower level than Text::Domain=
,
and Locale::Maketext is first no longer recommended, and second does
not use gettext at least by default).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
