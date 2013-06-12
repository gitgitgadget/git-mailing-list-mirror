From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 14:50:44 +0200
Message-ID: <7a0e5a6d3251dff96d4cc8b3ffb9957e@ensibm.imag.fr>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
 <20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr>
 <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
 <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
 <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
 <51B857B0.5030603@ensimag.fr>
 <3cafe99fe3b868e6fc025110d324b9c8@ensibm.imag.fr>
 <CALWbr2xhhUNTo54u7K5iFr+wSMSiX6JrgTX=QJsDQ6E30uwDzQ@mail.gmail.com>
 <CAH_OBifOeSSWB-LPT=Zv2AGEf5+nTh7yxE-1ijD0snFp3RS8Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmkVp-0007HH-TB
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab3FLMuu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 08:50:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36072 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab3FLMut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:50:49 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CCohkb006995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 14:50:45 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CCoi5E012937;
	Wed, 12 Jun 2013 14:50:44 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5CCoi4N020441;
	Wed, 12 Jun 2013 14:50:44 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5CCoifm020440;
	Wed, 12 Jun 2013 14:50:44 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <CAH_OBifOeSSWB-LPT=Zv2AGEf5+nTh7yxE-1ijD0snFp3RS8Dw@mail.gmail.com>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 14:50:45 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227610>

Le 2013-06-12 14:44, shawn wilson a =C3=A9crit=C2=A0:
> Either leave it or just show the next, last, and current commit. Not
> a whole --continue, --amend, etc stuff. The first time I had to=20
> rebase
> (about a month ago) it took me a minute to Google and figure the rest
> out.

Well, the current output looks like:

$ git status
# HEAD detached from ecb9f3e
# You are currently editing a commit while rebasing.
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your=20
changes)
# .....

so I don't think removing those pieces of advice would be a good idea,
especially since you can deactivate it with advice.statusHints.

> On Jun 12, 2013 8:29 AM, "Antoine Pelisse" <apelisse@gmail.com>=20
> wrote:
>
>> On Wed, Jun 12, 2013 at 1:23 PM, Mathieu Li=C3=A9nard--Mayor
>> <mathieu.lienard--mayor@ensimag.fr> wrote:
>> > Le 2013-06-12 13:12, C=C3=A9lestin Matte a =C3=A9crit :
>> >
>> >> Le 12/06/2013 12:17, Mathieu Li=C3=A9nard--Mayor a =C3=A9crit :
>> >>>
>> >>> Now, I'm not sure if we should always display the list of=20
>> commits
>> >>> already applied and those left to apply. What I mean is that=20
>> maybe it
>> >>> would be better to make status require a flag to display the two=
=20
>> lists.
>> >>> Something like (not sure about the flag's name):
>> >>>
>> >>> $ git status --rebase-state
>> >>> # HEAD detached from ecb9f3e
>> >>> # Already applied 2 patches:
>> >>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> >>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> >>> # You are currently editing a832578... my_commit_message [3/5]=20
>> while
>> >>> rebasing.
>> >>> # 2 patches left to apply:
>> >>> # =C2=A0 =C2=A0b170635... my_commit_message
>> >>> # =C2=A0 =C2=A0b170635... my_commit_message
>> >>> # =C2=A0 (use "git commit --amend" to amend the current commit)
>> >>> # =C2=A0 (use "git rebase --continue" once you are satisfied wit=
h=20
>> your
>> >>> changes)
>> >>> # ......
>> >>> # ......
>> >>>
>> >>> What do you guys think ?
>> >>
>> >>
>> >> I agree. When you're in the process of rebasing a big list of=20
>> commits,
>> >> it would produce a lot of not-so-useful output, when what you=20
>> want to
>> >> see is, most of the time, which commit you are currently editing.
>> >> So, in my opinion, whole lists should not be displayed by=20
>> default.
>>
>> Maybe we can display previous and next commits to provide some
>> context. Like we do for diff.
>> For example:
>>
>> $ git status
>> # HEAD detached from ecb9f3e
>> # Already applied 330 patches (displaying next 3):
>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> # Already applied 119 (displaying last 3)
>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> # =C2=A0 =C2=A0 b170635... my_commit_message
>> # You are currently editing a832578... my_commit_message [120/450]
>> while rebasing.
>>
>> Also, I'm not sure about the "--rebase-state" flag. We should=20
>> probably
>> have some option to disable it (and re-enable if the default is
>> changed through a config variable), but my understanding from=20
>> previous
>> messages was that not having to learn a new option to use that was
>> quite important. As a consequence, I removed it from my example.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml=20
>> [1]
>
>
> Links:
> ------
> [1] http://vger.kernel.org/majordomo-info.html

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
