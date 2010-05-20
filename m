From: demerphq <demerphq@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 10:57:59 +0200
Message-ID: <AANLkTimKW-eC--JtjOzclfCymhOTizboISDygvTvVbUY@mail.gmail.com>
References: <4BF4E40B.30205@math.tu-dortmund.de>
	 <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
	 <4BF4F7D7.60002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 20 10:58:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1Zv-0005vc-NS
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 10:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab0ETI6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 04:58:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38465 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab0ETI6A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 04:58:00 -0400
Received: by fxm10 with SMTP id 10so3260766fxm.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xvFSZxCUtmzKL53bEBC0Y3S3QY5F6MRpp+XLmRuJMSs=;
        b=LlJQgp5k5p7md7V85sDLTVhyd8bMPdkItbRmc/+hb/ANpKX80uhkgeElyZx7Bl+IYD
         BwULKTFSow+dHc7sWDWX6MH6G6XN2MWVDmvhZ+kKWdd5qA49ZF79i2idkJe5hidPAH/+
         K7UVczLICcCIteSxJHMJkNvyD1Nfm8xovwTsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M4+CciCJ/R0sHh7cBtFlGHUCsVv3QeqiNvOZ+BP3O20rdPwvijzpEL2aIMoqo3iNCt
         nTik5JQc5+K4ENV7ikXINUuN41luyXQf0xp6ip4lySHLmcTBZhvOyhW4xwD4nniPf5GP
         qF4iRXmGDlQxhHJ93bxV0Cqw7Hzl49/XJMX/g=
Received: by 10.239.170.73 with SMTP id r9mr956330hbe.101.1274345879119; Thu, 
	20 May 2010 01:57:59 -0700 (PDT)
Received: by 10.239.169.83 with HTTP; Thu, 20 May 2010 01:57:59 -0700 (PDT)
In-Reply-To: <4BF4F7D7.60002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147366>

On 20 May 2010 10:50, Michael J Gruber <git@drmicha.warpmail.net> wrote=
:
> =C6var Arnfj=F6r=F0 Bjarmason venit, vidit, dixit 20.05.2010 10:34:
>> On Thu, May 20, 2010 at 07:26, Matthias Moeller
>> <matthias.moeller@math.tu-dortmund.de> wrote:
>>> I have been searching the web for help and found lengthy discussion=
s
>>> which state that this is a common problem of the HFS+ filesystem.
>>> What I did not find was a solution to this problem. Is there a solu=
tion
>>> to this problem?
>>
>> Is this problem particular to Git, or do you also get it if you
>> e.g. rsync from the Linux box to the Mac OS X box?
>>
>>> # =A0 =A0 =A0 "U\314\210bersicht.xls"
>>
>> You probably have to configure your shell on OSX to render UTF-8
>> correctly. It's just showing the raw escaped byte sequence instead o=
f
>> a character there.
>>
>> There isn't anything wrong with OSX in this case, filename encoding =
on
>> any POSIX system is only done by convention. You'll find that you ha=
ve
>> similar problems on Linux if you encode filename in Big5 or
>> UTF-32.
>>
>> Linux will happily accept it, but your shell / other applications wi=
ll
>> render it as unknown goo because they expect UTF-8.
>
> No, the problem with git status is not the display. Matthias' problem=
 is
> that git status reports a tracked file as untracked. The reason is th=
at
> on HFS+, you create a file with name A and get a file with name B, wh=
ere
> A and B are different representations of the same name. There seems t=
o
> be no way to reliably detect which one HFS+ uses.

Judging by the example given the problem is that HFS+ decomposes
Unicode file names into latin1+combining characters instead of using
normalized utf8.

This implies that if the utf8 is normalized first using canonical
unicode normalization rules (to eliminate the combining character)
that it can then be compared.

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
