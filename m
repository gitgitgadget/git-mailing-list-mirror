From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 17:18:39 +0200
Message-ID: <201010111718.39996.jnareb@gmail.com>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net> <AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com> <4CB2FEB8.3050705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 11 17:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5K9R-0001OB-7i
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 17:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab0JKPSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 11:18:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41917 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353Ab0JKPSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 11:18:49 -0400
Received: by fxm4 with SMTP id 4so480048fxm.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jluE08BfUqgCkV/TKNrZgwH/xBShQD5VVZKumaR26Gg=;
        b=d7uDAJXxKdTsxpbtXiG2FPsjRvpPvxlc/wvpvtOjQhL08JAL572M4bZ24N6QzMxaNI
         ru/Y3tV8Yw5Vn+D4ZHgwZX9lhk4QWisfpLSg/zDydUkVocYzIOPSDHGUTccmwUCvRhtD
         cAroXgn8QtJoQS6e7HWJFT7vkV6ANMNRSBTbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=V3qiBykZN9zg/E1vYSpSn8e+HPgUuK/jHt/Ig167X0btExi0fXYeyKSWREEksQNNKj
         ZIYP59ZNEz9XhyUKvcm47/XQkXYSBLbkuhPPTj4sxkTOdO4ZIW+ICInD6LxcZEN8VwJI
         jP94ntumtEHSoVSBTZ7f0IQo0t5BQXIEoSkr4=
Received: by 10.223.163.80 with SMTP id z16mr1982754fax.62.1286810328360;
        Mon, 11 Oct 2010 08:18:48 -0700 (PDT)
Received: from [192.168.1.13] (abvy23.neoplus.adsl.tpnet.pl [83.8.222.23])
        by mx.google.com with ESMTPS id a6sm3237469faa.44.2010.10.11.08.18.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 08:18:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4CB2FEB8.3050705@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158765>

Dnia poniedzia=C5=82ek 11. pa=C5=BAdziernika 2010 14:10, Michael J Grub=
er napisa=C5=82:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 11.10.2010=
 11:40:
>> On Mon, Oct 11, 2010 at 08:39, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>=20
>>> But thanks to having ./configure optional step, we can build git al=
so
>>> on platforms that doesn't have autoconf installed (though the same =
could
>>> be achieved by bundling ./configure script with release tarballs).
>>=20
>> It already is built as part of the tarballs, at least for
>> http://kernel.org/pub/software/scm/git/git-1.7.3.1.tar.bz2
>=20
> Well, the point of my semi-serious RFC is that every so often, we hav=
e a
> variation on the following theme on the list:
>=20
> - "Newbee" uses make configure && ./configure && make and can't build=
=2E

As =C3=86var writes this happen mostly because "newbee" doesn't have au=
toconf
installed (and is not using released tarball, where ./configure script
is included).  =C3=86var solution is much better.

> - Helpful "oldbees" respond like "Duh! Use the Makefile".

This can happen because A.) "oldbee" doesn't use configure script
himself, so he gives (universal) advice that he can check, or B.)=20
because there is an error in both Makefile guessing and ./configure
script doesn't detect or misdetect thing; then "Use the Makefile"
can be considered workaround for the issue till bug gets fixed.

> configure is a second class citizen in git.git (we even explicitly
> .gitignore it - if you allow that lame joke),

We .gitignore 'configure' script because it is *generated* file, and
generated files should be not, as rule, placed under version control.

> But, really, the typical responses to build problems with configure
> indicate that most long timers don't use configure either, and probab=
ly
> don't feel too comfortable with it. So, I think we should either make
> the status quo clearer (Makefile as primary method) or change the sta=
tus
> quo. I can only do the former ;)

Because ./configure script enhances Makefile rather than generate it,
using configure script can only improve situation (at the cost of extra
cycles spent detecting)... well, with exception of rare cases bugs in
configure.ac making it misdetect.

--=20
Jakub Narebski
Poland
