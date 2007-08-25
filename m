From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Sat, 25 Aug 2007 08:37:36 +0300
Message-ID: <133074BD-C29D-437A-8533-96A601AFC294@pp.inet.fi>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi> <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi> <20070824223338.GA13209@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 07:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOoLu-0008UR-4h
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 07:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbXHYFi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 25 Aug 2007 01:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbXHYFi0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 01:38:26 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:59971 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387AbXHYFi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2007 01:38:26 -0400
Received: from [10.0.1.2] (GYKMMMCCXVII.dsl.saunalahti.fi [85.77.38.118])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 44F2B15155A;
	Sat, 25 Aug 2007 08:38:21 +0300 (EEST)
In-Reply-To: <20070824223338.GA13209@steel.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56620>


On Aug 25, 2007, at 01:33, Alex Riesen wrote:

> V=E4in=F6 J=E4rvel=E4, Fri, Aug 24, 2007 08:35:13 +0200:
>> On Aug 23, 2007, at 23:32, Alex Riesen wrote:
>>
>>> V=E4in=F6 J=E4rvel=E4, Thu, Aug 23, 2007 21:58:31 +0200:
>>>> With this flag, the user can choose to filter untracked files from
>>>> the
>>>> status output. This can be used to either speed up the status
>>>> output, as
>>>> the untracked files are not fetched at all, or to just cleanup the
>>>> output without using gitignore.
>>>
>>> "git diff -r --name-status; git diff --cached -r --name-status" is
>>> not enough?
>>
>> That line will result in duplicate entries, if files are staged, and
>> the output of git-status is neater (but longer) in my opinion.
>
> That is because it _is_ two times different: between working director=
y
> and the index, and between index and HEAD. git-status _will_ show you
> the same for the same reason.
>
> Besides, why do you want to hide this "duplication"? It shows how the
> matters really are.

git status --only-tracked, does not hide the fact that there are =20
files staged for commit, and modified files relative to the index. =20
The difference is, that it shows them in a clean way. Sure you could =20
make a script like:

echo "Changes to be committed:"; git diff --cached -r --name-status; =20
echo "Changed but not updates:"; git diff -r --name-status

But that is quite long, for a quick look at the state, without any =20
untracked files.

>
> Besides, it looks like you are using "friendly" where you actually
> wanted to say "I consider you too dumb to know what happens". Someone
> may feel offended

I don't see where I consider users dumb, but hey, I'm sorry if I made =20
someone feel offended.

--
V=E4in=F6
