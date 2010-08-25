From: Daniel Pfeiffer <occitan@t-online.de>
Subject: Re: Compiling git with makepp patch
Date: Wed, 25 Aug 2010 23:08:46 +0200
Message-ID: <4C75865E.5050804@t-online.de>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de> <4C71A53F.2020108@t-online.de> <201008230947.06777.trast@student.ethz.ch>
Reply-To: occitan@esperanto.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: occitan@esperanto.org, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:09:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNDQ-0005ez-Mi
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0HYVI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 17:08:56 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:40620 "EHLO
	mailout10.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab0HYVIy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:08:54 -0400
Received: from fwd04.aul.t-online.de (fwd04.aul.t-online.de )
	by mailout10.t-online.de with smtp 
	id 1OoNDI-0002V2-6V; Wed, 25 Aug 2010 23:08:52 +0200
Received: from [192.168.0.10] (bNDycyZ68hI5KS5iyinFoDUWIWRGuXFphF3jv6+v+rsi+ZnGpdZOP75MoOwA7xHZ3y@[84.177.184.117]) by fwd04.aul.t-online.de
	with esmtp id 1OoNDD-1PmAvQ0; Wed, 25 Aug 2010 23:08:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.4) Gecko/20100608 Mnenhy/0.8.3 Thunderbird/3.1
In-Reply-To: <201008230947.06777.trast@student.ethz.ch>
X-ID: bNDycyZ68hI5KS5iyinFoDUWIWRGuXFphF3jv6+v+rsi+ZnGpdZOP75MoOwA7xHZ3y
X-TOI-MSGID: 77c75dce-0c12-428b-8f88-6719f8a067b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154475>

  la 08/23/2010 09:47 AM Thomas Rast skribis:
> Daniel Pfeiffer wrote:
>>   # Shell quote;
>> -bindir_SQ =3D $(subst ','\'',$(bindir))#'
>> -gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))#'
>> -gitwebstaticdir_SQ =3D $(subst ','\'',$(gitwebdir)/static)#'
>> -SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))#'
>> -PERL_PATH_SQ  =3D $(subst ','\'',$(PERL_PATH))#'
>> -DESTDIR_SQ    =3D $(subst ','\'',$(DESTDIR))#'
>> +Q=3D'
>> +# ' This comment is only to appease IDEs like Emacs.
>> +# The comment is on a new line, else makepp would see it as a quote=
d hash.
>> +bindir_SQ =3D $(subst $Q,'\'',$(bindir))
>> +gitwebdir_SQ =3D $(subst $Q,'\'',$(gitwebdir))
>> +gitwebstaticdir_SQ =3D $(subst $Q,'\'',$(gitwebdir)/static)
>> +SHELL_PATH_SQ =3D $(subst $Q,'\'',$(SHELL_PATH))
>> +PERL_PATH_SQ  =3D $(subst $Q,'\'',$(PERL_PATH))
>> +DESTDIR_SQ    =3D $(subst $Q,'\'',$(DESTDIR))
> Confusingly, you talk about comments above, but the real issue is tha=
t
> your makepp apparently gives the ' special meaning.  For once "info
> make" and "man 1p make" on my system agree on the semantics of ': non=
e
> at all.  From the latter:
>
>    Early proposals stated that an "unquoted" number sign  was  treate=
d  as  the
>    start of a comment. The make utility does not pay any attention to=
 quotes. A
>    number sign starts a comment regardless of its surroundings.
If you look at the example I just sent to =C3=86var, that contains exam=
ples of how=20
crazy the situation really is in gmake.  What you cite here is wrong!

> So can you quote chapter and verse to show that there is anything to
> fix?
Well, I pointed you to makepp, which is subtly different from gmake, wh=
ich you=20
could.  If you choose not to use it, please yourself!

coralament / best Gr=C3=B6tens / liebe Gr=C3=BC=C3=9Fe / best regards /=
 elkorajn salutojn
Daniel Pfeiffer

--=20
lerne / learn / apprends / l=C3=A4r dig / ucz si=C4=99    Esperanto:
                     http://lernu.net  /  http://ikurso.net
