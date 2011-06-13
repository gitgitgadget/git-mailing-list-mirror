From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 13 Jun 2011 12:15:22 +0200
Message-ID: <201106131215.24343.jnareb@gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <201106102035.42525.jnareb@gmail.com> <4DF29EA5.60502@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 13 12:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW4BL-0002zq-Sj
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 12:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab1FMKPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 06:15:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50760 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1FMKPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 06:15:38 -0400
Received: by bwz15 with SMTP id 15so3577074bwz.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0drTWVuQsqtv+/2WoHYyK06iBMuw4OyF/33cPuDKbB8=;
        b=tpaJC5zqN5J6cpa7DDIhfkKG42n1zj9HSgOoXSABy0j3L6afboqd64CgF5DYv/mj1v
         2Sah91XWYqjgYGzLwIAUttS7y4EtuOGvhGpY6Hm5BUuH8qNUFN7b0SOuIy4ssVBGsNJ9
         Ep9lj5Q5/D+gnFEFGEWVCxAUMpPuSUw5k5ccM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JFDFDoofhtQh8WFxMtfrTnhlRDlEAb9kaX+UWomfZ2Zc2Q8js7Zr3ULWdQn6ivnea9
         jZ0ow9vz2gmqM2gTbiihvkqrDzB8/RkI41jPBf4a6PDa2MSzYDS+J5iVxy9glGkAhQZj
         iaZU0KjExnTFUuhZa+OrjbaTRoetO0kd+IS/M=
Received: by 10.204.81.203 with SMTP id y11mr4407467bkk.124.1307960136939;
        Mon, 13 Jun 2011 03:15:36 -0700 (PDT)
Received: from [192.168.1.15] (abvk127.neoplus.adsl.tpnet.pl [83.8.208.127])
        by mx.google.com with ESMTPS id j7sm5195641bka.8.2011.06.13.03.15.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 03:15:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF29EA5.60502@ira.uka.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175696>

On Sat, 11 June 2011, Holger Hellmuth wrote:
> Am 10.06.2011 20:35, schrieb Jakub Narebski:
>> Dnia pi=B1tek 10. czerwca 2011 20:07, Holger Hellmuth napisa=B3:
>>> On 10.06.2011 18:44, Jakub Narebski wrote:
>>>> On Thu, 9 Jun 2011, Holger Hellmuth wrote:

>>>>> Also there are no good words for what someone wants to see in thi=
s case.
>>>>> At least I would assume the git project would have found them if =
they
>>>>> existed. '--cached' is definitely not one of them. But we have fi=
tting
>>>>> and widely known names for the targets, i.e 'working tree', 'inde=
x' and
>>>>> 'head'.
>>>>
>>>> "I want to see if there are any remaining changes", "I want to see=
 what
>>>> 'git commit' would bring", "I want to see what 'git commit -a' wou=
ld bring".
>>>> Neither of those is about targets for diff.
>>>
>>> Are you proposing a command "git=20
>>> --I-want-to-see-if-there-are-any-remaining-changes" ? ;-). I was lo=
oking=20
>>> for short command or parameter names that are easy to remember, not=
 for=20
>>> definitions of the output of cryptic commands.
>>>
>>> But lets see. If I didn't know much git, where would I look for the=
=20
>>> right command for your three needs? Where would I expect the soluti=
on?=20
>>> (note I'm not proposing any of these commands)
>>>
>>> "I want to see if there are any remaining changes"?
>>> git status
>>> git status --full
>>> git status --detailed
>>=20
>> "Any differences"?
>>=20
>> git diff
>=20
> But difference to what --> User checks man page, again.

User's changes.  User doesn't need to know what are those two places
called.
=20
>>=20
>>=20
>> "I want to see what I staged"
>>=20
>> git diff --staged
>>=20
>=20
> User never heard of 'staged'. He asks instead "I want to see what I
> added" --> git diff --added --> Error Message --> User checks man pag=
e,
> again

User uses "git stage <file>", so he/she uses "git diff --staged".
=20
[...]
>>> git diff WTREE INDEX
>>           ^^^^^^^^^^^ --- reverse to "git diff"
>>=20
>> In this direction it is surely suprising... you see, how again and a=
gain
>> having to explicitely state what to compare with which leads to mist=
akes
>> such like this one, and the one in few mails earlier.
>=20
> I'm a sloopy person as you have noticed. Also very forgetful. I usual=
ly
> don't bother with the order of 'diff' parameters when I can get the
> direction from the diff output.

=46or other people getting the reverse of changes can be certainly
suprising (I though I added this, not deleted...).  When you specify
endpoints manually, there is a chance to get them in wrong direction.
Especially that there is NEXT WTREE but HEAD NEXT.

> Small things like 'git unadd', Jeff Kings 'git put' and git diff with
> targets probably would help this casual/intermediate/advanced user (t=
ake
> your pick).

I agree with 'git unadd'.  Jeff Kings 'git put' and git diff targets ha=
ve
the problems that need to be fully solved before considering for inclus=
ion.

BTW. there is code for 'git put'.  Where is code for git diff targets?

--=20
Jakub Narebski
Poland
