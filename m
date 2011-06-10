From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Command-line interface thoughts
Date: Sat, 11 Jun 2011 00:45:57 +0200
Message-ID: <4DF29EA5.60502@ira.uka.de>
References: <201106051311.00951.jnareb@gmail.com> <201106101844.16146.jnareb@gmail.com> <4DF25D50.5020107@ira.uka.de> <201106102035.42525.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:46:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVATI-0007Sg-9J
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 00:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab1FJWq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 18:46:26 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34511 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758140Ab1FJWqZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 18:46:25 -0400
Received: from dslb-088-066-005-146.pools.arcor-ip.net ([88.66.5.146] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1QVASr-0000vq-3N; Sat, 11 Jun 2011 00:46:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <201106102035.42525.jnareb@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1307745974.917424000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175632>

Am 10.06.2011 20:35, schrieb Jakub Narebski:
> Dnia pi=B1tek 10. czerwca 2011 20:07, Holger Hellmuth napisa=B3:
>> On 10.06.2011 18:44, Jakub Narebski wrote:
>>> On Thu, 9 Jun 2011, Holger Hellmuth wrote:
>>>> Also there are no good words for what someone wants to see in this=
 case.
>>>> At least I would assume the git project would have found them if t=
hey
>>>> existed. '--cached' is definitely not one of them. But we have fit=
ting
>>>> and widely known names for the targets, i.e 'working tree', 'index=
' and
>>>> 'head'.
>>>
>>> "I want to see if there are any remiaining changes", "I want to see=
 what
>>> 'git commit' would bring", "I want to see what 'git commit -a' woul=
d bring".
>>> Neither of those is about targets for diff.
>>
>> Are you proposing a command "git=20
>> --I-want-to-see-if-there-are-any-remaining-changes" ? ;-). I was loo=
king=20
>> for short command or parameter names that are easy to remember, not =
for=20
>> definitions of the output of cryptic commands.
>>
>> But lets see. If I didn't know much git, where would I look for the=20
>> right command for your three needs? Where would I expect the solutio=
n?=20
>> (note I'm not proposing any of these commands)
>>
>> "I want to see if there are any remaining changes"?
>> git status
>> git status --full
>> git status --detailed
>=20
> "Any differences"?
>=20
> git diff

But difference to what --> User checks man page, again.

>=20
>=20
> "I want to see what I staged"
>=20
> git diff --staged
>=20

User never heard of 'staged'. He asks instead "I want to see what I
added" --> git diff --added --> Error Message --> User checks man page,
again

>=20
> Isn't it simpler than "I want to see the changes between what I alrea=
dy
> staged, which is put in place called index, but must refer to it by N=
EXT,
> and the changes I didn't staged, in my working area, which I refer to=
 by
> WORK... no, it is TREE... oh, wait, it is WTREE" :-)  I am exaggerati=
ng
> much here, but I think you can see what I want to point out.

Sure. I'm not a fan of 'NEXT' either. I would use INDEX. Or even index
if that doesn't clash with anything. WTREE as well is not optimal but i=
t
is something you can get at as soon as you remember the term 'working
tree'. And you know what you will get without consulting the manuals if
you are unsure.

>> Now I'll add a question I would want to ask:
>> "I want to see the changes between what I have in my working tree an=
d=20
>> what I already added to the index"
>=20
> That's not a beginner question.

Ok, I had a different definition of beginner, especially since I and al=
l
the git-user I know at my work place used the index from the beginning.
The index is a wonderful idea but it isn't that hard to understand. If
you look at the gittutorial man page (and any of the other 3 top
tutorials in google) 3 of those 4 tutorials talk about the index and gi=
t
add, only one uses 'git commit -a' instead.

Only one mentions 'git diff --cached' by the way, seems to be an
advanced topic ;-)


>> git diff WTREE INDEX
>            ^^^^^^^^^^^ --- reverse to "git diff"
>=20
> In this direction it is surely suprising... you see, how again and ag=
ain
> having to explicitely state what to compare with which leads to mista=
kes
> such like this one, and the one in few mails earlier.

I'm a sloopy person as you have noticed. Also very forgetful. I usually
don't bother with the order of 'diff' parameters when I can get the
direction from the diff output.

>>
>> Btw. even the 'git diff' man page emphasizes that diff is about a=20
>> comparision between two things. Citation: "Show changes *between* tw=
o=20
>> trees, a tree and the working tree, a tree and the index file,...".
> =20
> That's more about explaining result of command.  Besides manpages are
> reference documentation; new users should start with user's manual, o=
r
> tutorial (or "Pro Git"), not manpages.

Ok, so lets look at 'Pro Git'. Besides using your description it is als=
o
talking about comparision between working area and staging area and
comparing staged changes to last commit.

> Well, that depends by what you mean by beginner.  Beginner to git, bu=
t
> not beginner to version control knows about "<scm> diff" form to chec=
k
> for one's changes, for example.
>=20
> But I don't think that beginner knows that there is such thing like t=
he
> index, and know that he/she has to compare the index to the working a=
rea.
> When he/she starts to use the index, probably he/she isn't a beginner
> anymore.

Learning git is not a role playing game where you have to master level =
1
before you can use all the tricks of level 2 ;-). But any which way we
call them there are a lot of users using git with index and all, but wh=
o
have to search in the docs whenever they want to do something like
unadding something from the index.

Small things like 'git unadd', Jeff Kings 'git put' and git diff with
targets probably would help this casual/intermediate/advanced user (tak=
e
your pick).

Holger.
