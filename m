From: Paul Franz <thefranz@comcast.net>
Subject: Re: Attributes for commits
Date: Sat, 09 Jun 2007 22:10:53 -0400
Message-ID: <466B5DAD.9060601@comcast.net>
References: <466AA714.4050500@comcast.net> <200706092048.52142.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 04:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxCtf-0007ic-86
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 04:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbXFJCLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Jun 2007 22:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbXFJCLH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 22:11:07 -0400
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:53042 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbXFJCLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 22:11:06 -0400
Received: from paul-franzs-computer.local (c-69-136-89-103.hsd1.pa.comcast.net[69.136.89.103])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20070610021101m1400fnjrje>; Sun, 10 Jun 2007 02:11:01 +0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <200706092048.52142.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49652>

But the question is how many allow you to easily query this info. That=20
is one of the things I like about ClearCase's use of attributes is the=20
ability to query the repository about where it is set. For example, in=20
the case of git an attribute called "Status" on the commit could help=20
communicate to others what the status of a commit or better yet an=20
attribute on a branch. The one thing that I have realized is that chang=
e=20
management is all about communication and the repositories are just one=
=20
more way of communicating especially if the proper information can be=20
extracted and maintained by the repository. A good example of this is=20
CVS and merges. It is not  CVS does merging poorly. It is that:

    1) It has no mechanism in place for itself to know that the merge=20
has been taken place between different branches.
    2) There is no way for people to know that the changes from one=20
branch has been merged to another.

The second is where meta data helps. In the case of ClearCase, they=20
something called a hyper-link that tells that a change to a file has=20
been merged from one branch to another and ClearCase uses this to know=20
how to merge future changes.

Now, I am not trying to turn git into ClearCase. I just see attributes=20
as a great way to help communicate things, from status of a branch to=20
what bug this change is related. Of course, part of adding attributes=20
would be adding a way to query git to find the commits or branches that=
=20
have the associated attributes.

Paul Franz

Robin Rosenberg wrote:
> l=F6rdag 09 juni 2007 skrev Paul Franz:
>  =20
>>     I am a ClearCase administrator and one of the things that I love=
=20
>> about it is the ability to assign attributes to versions of files. I=
s=20
>> there anybody thinking of adding the ability to assign attributes to=
 a=20
>> commit? I ask because I was thinking about how I would move from=20
>> ClearCase to git and part of our process is to assign the BugNum=20
>> attribute to every checkin so that we can see what bugs have been fi=
xed.=20
>> We also track the files checked in the bug tracking software to. Thu=
s=20
>> giving us a two way linkage between repository and the bug tracking=20
>> system. This is VERY useful. And I was wondering if there are any=20
>> thought to this for commits.
>>
>> Now, I will be honest it is possible that this has already been done=
 (I=20
>> have not read all the documentation yet) and I am justing wasting=20
>> bandwidth. In which, please excuse my ignorance and tell me to just =
RTFM.
>>
>> Paul Franz
>>
>>    =20
>
> We use the convention of putting the bug number as the first work on =
the first line of
> the checkin, e.g. "3399 Add attributes for commits". The advantage ov=
er other methods
> is that it is always there, without the need to further investigation=
s of assigned attributes.
>
> This convention has nothing to do with Git though. It works with any =
type of repo.
>
> -- robin
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  =20

--=20

-------------------------------------------

There are seven sins in the world.
     Wealth without work.
     Pleasure without conscience.
     Knowledge without character.
     Commerce without morality.
     Science without humanity.
     Worship without sacrifice.
     Politics without principle.

   -- Mohandas Gandhi

-------------------------------------------
