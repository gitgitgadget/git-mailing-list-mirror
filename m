From: demerphq <demerphq@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Wed, 19 May 2010 17:43:50 +0200
Message-ID: <AANLkTinyQnc9VLjRmFOh5c-aeESjvlIKnQ3go4r2xoPG@mail.gmail.com>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
	 <20100516160800.GB22447@efreet.light.src>
	 <AANLkTinGSBRMRyaD0w2p9PQELLA6ThvKFdi6hcNWBTxr@mail.gmail.com>
	 <201005171632.48253.trast@student.ethz.ch>
	 <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Jan Hudec <bulb@ucw.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 17:43:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OElR9-0004V0-Bq
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 17:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab0ESPnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 11:43:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49418 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab0ESPnw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 11:43:52 -0400
Received: by fxm10 with SMTP id 10so2493531fxm.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yyG8FYNvjBTfezOGDFI7fFVIFvlvi5pZ5XQCo1NOH+g=;
        b=svCoczEAsyZ9qcreSHgHq0uP/IP29s6+8XeDXvKJ9BFiYWvoGZJDk59ZhYNXKZbZnO
         kFnPwfUcoxdjyoBVLjWAMQFMBFWJWHw4eb/7k76/7QWcfG6iX5qK8IZsvtAbiDXzOWlw
         g4xxCuFv9h4klLLUOtdZGfmjBwhSDiN/J8ADg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rlZSuaalE4TTV3BzGJKfLpoR8/eLTakawX6Cbd4eEZi8OpvTOHH3aSLLVE2Q63Y/L0
         ww9jH7BtRTyXf6pccjJhAwPkLDycakGv8ehSqhn5KEIZYboYapW/N+pk9zYTthNCzPR6
         A95A5kprfM1jXNSJRzkKs21wo5WeHgSx33X+0=
Received: by 10.239.190.72 with SMTP id w8mr799378hbh.117.1274283830191; Wed, 
	19 May 2010 08:43:50 -0700 (PDT)
Received: by 10.239.169.83 with HTTP; Wed, 19 May 2010 08:43:50 -0700 (PDT)
In-Reply-To: <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147332>

On 17 May 2010 16:53, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> =
wrote:
> On Mon, May 17, 2010 at 14:32, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>> =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>> On Sun, May 16, 2010 at 16:08, Jan Hudec <bulb@ucw.cz> wrote:
>>> > It would definitely not be fine to break *git*. You need to make =
sure no
>>> > part of git itself or anything distributed with it (gitk, git gui=
, gitweb,
>>> > things in contrib) is looking for any string that might be broken=
 by
>>> > translating.
>>>
>>> Of course internal breakage, i.e. git-foo parsing the output from
>>> git-bar breaking under non-English is unacceptable. I meant that
>>> external tools now running under some non-English locale may start
>>> breaking if they're parsing the output and assuming English. The
>>> remedy for that is easy though, just prefix the calls to git with
>>> LC_ALL=3DC.
>>
>> And how exactly do you expect us to go back in history and prefix al=
l
>> invocations of git in all scripts with LC_ALL=3DC?
>
> I don't expect you to. I just don't think it's unreasonable that if
> Git were to be internationalized that it behave like every other *nix
> program. If you have a Chinese locale and rely on the output of some
> program being in English your scripts will break if the OS
> subsequently upgrades to a new version of the program that has been
> translated to Chinese.
>
> The right way to handle that is to call programs like that with
> LC_ALL=3DC.
>
> The alternative would be to do introduce a variable like
> GIT_YES_REALLY_FOLLOW_LC_VARIABLES=3D1.
>
>> Porcelain such as git-status could be changed, but then there's not
>> that much of it anyway. =A0IMHO a set of standard documentation in e=
ach
>> language would be more useful.
>
> The output of the utilities is what people see when using Git, having
> that in your native language is more valuable than some howto being
> translated.

If the language is determined not by the environment, but by the
configuration of the repository, then it seems to me this would be
"opt-in" only, and not have any negative impact on existing
installations or toolsets.

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
