From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Merging/joining two repos (repo2 should be a subdirectory of
 repo1)
Date: Wed, 03 Oct 2012 14:52:03 +0200
Message-ID: <506C34F3.8090709@dirk.my1.cc>
References: <506862A1.8000508@dirk.my1.cc> <1349018675-ner-5178@calvin> <50686605.6020909@dirk.my1.cc> <CAJDDKr4sXp7qqhzHN2_5sJeqaV23Z_uDiFsU_eFJrT5ApuWiTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 14:52:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJOR4-0004m5-5d
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 14:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab2JCMwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 08:52:09 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:39058 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab2JCMwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 08:52:08 -0400
Received: from [84.176.20.199] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1TJOQl-0006jo-Nn; Wed, 03 Oct 2012 14:52:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAJDDKr4sXp7qqhzHN2_5sJeqaV23Z_uDiFsU_eFJrT5ApuWiTQ@mail.gmail.com>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206887>

Am 30.09.2012 22:44 schrieb David Aguilar:
> On Sun, Sep 30, 2012 at 8:32 AM, Dirk S=C3=BCsserott <newsletter@dirk=
=2Emy1.cc> wrote:
>> Am 30.09.2012 17:24 schrieb Tomas Carnecky:
>>> On Sun, 30 Sep 2012 17:17:53 +0200, Dirk S=C3=83=C5=92sserott <news=
letter@dirk.my1.cc> wrote:
>>>> Hi!
>>>>
>>>> I have repo1 with ~4 years of history and another repo2 with ~1 ye=
ar of
>>>> history, both of which I don't want to loose. Now I want to join t=
hem so
>>>> that repo2 becomes a subdirectory whithin repo1, including all the
>>>> history of repo2.
>>>>
>>>> A simple git-merge won't do because both repos have some same file=
s (at
>>>> least e.g. .gitignore) in their root directories. Of course I coul=
d
>>>> resolve the conflicts, but I don't want that.
>>>>
>>>> My naive approach is "move everything in $repo2 one directory belo=
w" and
>>>> then "merge $repo2 into $repo1". Actually I wouldn' call that a "m=
erge"
>>>> but an "import".
>>>>
>>>> I know of "git filter-branch --subdirectory-filter foodir" but tha=
t's
>>>> just the opposite of what I need.
>>>>
>>>> Is there a nifty trick to get this? Or will I have to do "git
>>>> filter-branch --tree-filter 'mkdir subdir && git mv * subdir' --al=
l" on
>>>> $repo2 and then "git merge $repo2" in $repo1?
>>>
>>> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-s=
ubtree.html
>>>
>>>
>>
>> Wow! Thanks for that quick and *very* helpful answer! :-)
>=20
> Hi Dirk,
>=20
> You should also take a look at contrib/subtree/ in the git source tre=
e.
>=20
> "git subtree" does pretty much exactly what you're looking to do,
> and it is a bit more user-friendly than the plumbing commands.
>=20
> https://github.com/git/git/blob/master/contrib/subtree/git-subtree.tx=
t
>=20

Hi David,

thanks for the pointer. I know of subtree and like it. But for my case
I'll stick to the plumbing commands because I really want to *import*
$repo2 into $repo1 and then delete $repo2. One shot.

(Actually I re-wrote a part of our project just for fun and didn't do i=
t
in the main project's repo in a separate branch (as I normally do) but
in a totaly separate repo. And now it turned out that my rewritten part
is really cool and we want to include it in the main $repo1 and drop my
private $repo2.)

Dirk
