From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Sat, 12 Jun 2010 19:53:55 +0200
Message-ID: <6FE00F97-CB7D-49A1-89CA-23C3C7FFD0D6@wincent.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com> <422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com> <AANLkTikYIePjF-ZMKh4fS_Gs6AEcImbCY1X7M4FYaEwy@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 20:26:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONVQ0-0007bG-8E
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 20:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab0FLS0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 14:26:50 -0400
Received: from outmail137171.authsmtp.net ([62.13.137.171]:55803 "EHLO
	outmail137171.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751555Ab0FLS0t convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 14:26:49 -0400
X-Greylist: delayed 1936 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jun 2010 14:26:48 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt7.authsmtp.com (8.14.2/8.14.2) with ESMTP id o5CHs2ST050709;
	Sat, 12 Jun 2010 18:54:02 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o5CHrxxl039509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jun 2010 18:54:00 +0100 (BST)
Received: from [192.168.1.6] (119.Red-88-3-76.dynamicIP.rima-tde.net [88.3.76.119])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o5CHrtYH015385
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 12 Jun 2010 13:53:57 -0400
In-Reply-To: <AANLkTikYIePjF-ZMKh4fS_Gs6AEcImbCY1X7M4FYaEwy@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: 7b82cd47-764b-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH axwdDEdVdwdEHAkR Am4BXlBeUFw/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNEXYQQ1RJ Wh4dWxxyfktEeXZ2 bQhlDHhZDxB+clt6 REoGCGwHMTF9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcQ5nFx4T P0ctZQV5Ei9YNTwd XgEAZV4fT08WGiJ0 SBEeVTUiGVVNQigo NBUpJxYWDQ4NNV0z OjON
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149026>

El 12/06/2010, a las 18:17, Scott Chacon escribi=F3:

> Hey,
>=20
> On Fri, Jun 11, 2010 at 9:26 AM, Wincent Colaiuta <win@wincent.com> w=
rote:
>>=20
>> Nice. I'm sure the output will be a bit less intimidating, but I am =
not sure about some of the grouping choices you've made here.
>>=20
>> "git checkout" is almost certainly a "Basic" command, even though it=
's used for creating and switching branches.
>=20
> I wanted the basic commands to be commands that you had to know to us=
e
> git.  You really don't actually *have* to know 'checkout' - you only
> need to know it if you're using branches, or in a more advanced case,
> want to revert file contents.  To just commit snapshots, 'checkout' i=
s
> not a necessary command.

I think that's an overly restrictive criterion. By that standard, "git =
status" shouldn't be there either because you don't *have* to know that=
 to use Git either.

>> "git tag" doesn't really seem to be a "Branch" command, as it's for =
tagging objects (usually commits), and not branches.
>=20
> This is true - I suppose it probably actually fits better under
> 'history', since that's what you're doing is bookmarking a point in
> history.

In any case, now that you mention it I see that I forgot to include "gi=
t tag" anywhere in the listing. I don't think it belongs clearly in any=
 of the categories mentioned so far, despite the fact that it is still =
a fairly basic command. Perhaps there's a need for a final section call=
ed "Other commands:"...

>> "git reset" is the odd one out in the "History" commands group. The =
other three commands are about _inspecting_ history, whereas "git reset=
" is about changing the current HEAD. I actually think "git reset" fits=
 better with the "Branch" commands.
>=20
> I guess - I suppose I put it there because I mainly use it to rewind
> my history (reset HEAD~) but it could go under branches.  While we're
> at it, I'm not sure 'show' is really necessary in this list at all.  =
I
> rarely use it, which I guess means it's not *terribly* important for
> day to day use.

Well, it's a pretty useful tool IMO as you can point "git show" at just=
 about anything and get something informative back. I use it all the ti=
me with no params to get a quick look at the latest change in a repo, a=
nd point it at tags and such to give me a quick indication of when/what=
 they were applied to.

=46or me "git reset" is a much more advanced command and one of the _la=
st_ things I would show a beginning user, seeing as it actually require=
s them to have a proper grasp of branches and heads in Git (and that ma=
y take a little while for them to sink in).

>> I think I'd be inclined to use more descriptive headings and group t=
he commands like this:
>>=20
>>  Basic operation:
>>    init
>>    add
>>    status
>>    commit
>>    checkout
>>=20
>>  Inspecting repository state and history:
>>    log
>>    diff
>>    show
>>=20
>>  Working with branches:
>>    branch
>>    merge
>>    reset
>>=20
>>  Interacting with other repositories:
>>    clone
>>    fetch
>>    pull
>>    push
>>    remote
>>=20
>=20
> I kind of like the more descriptive headings, but I still think
> 'clone' should be in the 'basics' section, because everyone needs to
> know that

That's not true. You can start learning to use Git in an empty director=
y with "git init", and in fact you could quite happily use Git for week=
s without using "git clone". Some people use Git to track their home di=
rectories or "/etc" or whatever, and never work collaboratively with ot=
her repositories at all. So there's nothing "fundamental" about "git cl=
one" IMO.

> but I had it in the 'remotes' section at first too, so I
> wouldn't be terribly opposed to moving it back down there.

Well it is kind of nice to have those five commands grouped together se=
eing as, unlike some of the other commands under discussion here, they =
are all indisputably about "Interacting with other repositories".

> I really don't want 'checkout' in 'basic' - there is no good reason I=
 can see
> to not have it in 'branches'.

Well, it seems pretty basic to me. Have you ever seen a Git tutorial th=
at didn't teach "git checkout" in the first 5 minutes? And once the use=
r gets started using Git it's a command they'll use literally all the t=
ime. Sticking it in "branches" seems wrong to me seeing as it is a mult=
i-purpose command that does a lot more than just work with branches.

Wincent
