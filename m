From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 29 Mar 2010 12:14:27 +0800
Message-ID: <41f08ee11003282114m34aa0f61w536b996dce6cecab@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
	 <201003282120.40536.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 29 06:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw6N1-0000i4-3L
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 06:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab0C2EOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 00:14:30 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:15318 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab0C2EO2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 00:14:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3115735qwh.37
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DmAs8KWAfUoQL3uMh/ezPIAiCRJVU6KlqIhE6T/DCmM=;
        b=xbBmubqNA0M/xiOB+K6QdNmoSFKB9W7TsE5RReEKzba7MCXCqVDJcP0zreMWu4NXfX
         TVkzMNfr3yr+J6GRret9NsT/F0sBvQY2t8OUD3Vi9FjTlzcJq3GCKlX6h4yK0163c++E
         tWCfoidAF7ReVrOtcwwo7yMKcq6W+PQzM+M18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SeHVCX1gNwk2reeqpkfcdEBthkinbgeOdfvkDXh1iN5ryEHmgwRsz6UyiRB5ajYlSJ
         CnZCEy9pLfIaHnuVQ1ZYwNA1Cw6BDaacqkKLQ0XICvOBzc9wSH3Q/QwFajM5s2fQAfFg
         K6wkG1MeVoy7ln7paZGH4EFg+JIhk9+2ZyxkE=
Received: by 10.229.84.72 with HTTP; Sun, 28 Mar 2010 21:14:27 -0700 (PDT)
In-Reply-To: <201003282120.40536.trast@student.ethz.ch>
Received: by 10.229.38.69 with SMTP id a5mr1670863qce.15.1269836067827; Sun, 
	28 Mar 2010 21:14:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143435>

Hi Thomas,
On Mon, Mar 29, 2010 at 3:20 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Hi Bo
>
> I have one specific question about the draft project description:
>
> You wrote:
>> And the timeline will be:
>> April 26 - May 23: =A0 Catch up with Git code base and study the
>> implementation of blame.c and log.c thouroughly.
>>
>> May 24 - June 21 : =A0 Complete a version which supports code
>> modifcation trace but without code movement and code copy support.
>>
>> June 22 - June 29: =A0 Complete a version which supports code moveme=
nt
>> inside one file.
>>
>> June 30 - July 7: =A0 =A0Complete a version which supports code move=
ment
>> between files inside one commit.
>>
>> July 8 - July 15: =A0 =A0Complete a version which supports code copy=
 of
>> modified file in one commit.
>>
>> July 16 - July 23: =A0 Complete a version which supports code copy o=
f
>> any file in one commit tree.
>>
>> July 24 - August 7: =A0Complete fuzzy matching of code movement and =
copy detect.
>
> Where are you taking those numbers from?
>
> (I'm fine if the answer is "I'm making them up from whole cloth" but =
I
> want to know anyway :-P)

You mean the dates? They are made up according on 'GSoC's timeline'
and my estimation about the workload of each milestone.

And this is the draft proposal, after a long thread of discussion, the
timeline and milestone change much.  The fuzzy matching milestone will
become a bonus milestone instead of a primary GSoC milestone. And I
think it may help that I provide a newest version of it, I paste it in
the end of the email.

And I will appreciate any feedback from you. Especially about the
implementation section :)


Regards!
Bo

-----------------------------------------------------------------------=
--
Draft proposal(v3): Line-level History Browser

=3D=3D=3D=3D=3DPurpose of this project=3D=3D=3D=3D=3D
"git blame" can tell us who is responsible for a line of code, but it
can't help if we want to get the detail of how the lines of code have
evolved as what it is now. For example, in Git, commit 93fc05e(Split
off the pretty print stuff into its own file) split out
pretty_print_commit() from commit.c into pretty.c, and it is hard to
verify without much hassle that the code split was really only a code
split, rather than a split with an evil change.

This project will add a new feature for 'git log' to display line
level history. It can trace the history of any line range of certain
file at any revision. And for each history entry, it will provide the
commits, the diff block which contains changes of users' interested
lines.

This utility will trace all the modification history of interested
lines and stop until it finds the root of the lines, which is a point
where all the new code is added from scratch. Also, the users can
specify how deeply he wants this utility to trace. And this tool will
also follow the code movement and copy inside one commit, too.

Note that, the history may not always be a single thread of commits.
If there are more than one commits which produce the specified line
range, or there are more than one source of code move/copy, the thread
of history will split. And this utility may stop and provide all
commits with its code changes to the user, let the user to select
which one to trace next. Or, it may also use 'git log --graph' way to
display the splitted history, we will provide options to control this.

=3D=3D=3D=3D=3DWork and technical issues=3D=3D=3D=3D=3D
=3D=3DScenario=3D=3D
=46or how we use the line level browser and how the utility should act
to us, here is an scenario:
http://article.gmane.org/gmane.comp.version-control.git/143024/match=3D=
line+level+history+browser
It contains code movement between files but not code copy and fuzzy mat=
ching.

=3D=3DFeatures=3D=3D
This new feature should be used for exploring the history of changes
for certain line range of code in one file. Following features will be
supported:
1. Follow history of code modification of any single line range
starting from any revision. The above scenario provide a good example
for what this function used for and how it acts with users.

2. Follow code movement inside one file. And follow code movement
between files optionally for performance reason. With code movement
detect, we can find code refactoring easily just like what the above
scenario do.

3. Provide a configurable context to users, display only the 'user
interested lines' diff block or display the whole diff with the
interested area colorfully displayed.

4. Detect code copy optionally. This may help us to understand why
some code is here and help on code refactoring. For example, we can
always make some 'usually copied code' a function.

5. Simply fuzzy matching for code move/copy. Provide an option to
control whether we start a fuzzy matching for performance reason. This
can help us to find whether some code is really literally moved to
here or with some evil changes. And this may also help in some
situation like if we move some Java class to another file with only
its class name changed. Anyway, fuzzy matching can help much on code
detection. And there can be many fuzzy detect strategies, but we will
only try to support the simplest one in this summer for time reason.
Maybe a strategy like: 90% of the lines between two ranges of code are
identical or 90% of words are identical. This will be discussed again
before coding I think.

6. Provide a configurable way for how to display the history. A 'git
log --graph' way or stop to ask users when we meet history splitting.

7. Reuse 'git log' existing options as many as possible.

=3D=3DDesign and implementation=3D=3D
Git store all the blobs instead of code delta, so we should traverse
the commit history and directly access the tree/blob objects to
compute the code delta and search for the diff which contains the
interesting lines. Since git use libxdiff to format its diff file, we
should iterate through all xdiff's diff blocks and find what the code
looks like before the commit. This will be done using the callback
mechanism. Here, we will find a new line range which is the origin
code before this commit. And then start another search from the
current commit and the new line range. Recursively, we can find all
the modification history. We will stop when we find that the current
interested line range is added from scratch and is not moved from
other place of the file. Here, if the user want to trace code copy,
more work will be done to find the possible code copy. We may also
stop the traverse when we reach the max search depth. Also, if the
thread of change history split into two or more commits, we stop and
provide the users all the related commits and corresponding line
range.

Generally,
1. New callback for xdi_diff to parse the diff hunk and store line
level history info.
2. builtin/line-log.c will be added to complete most of the new feature=
s.
3. builtin/log.c will be changed to add this new utility to the front e=
nd.
4. Documents will be updated to introduce this new tool.

=3D=3D=3D=3D=3DMilestones and Timeline=3D=3D=3D=3D=3D
In this summer, we will add support of line level history browser for
only one file. The multiple ranges support is currently not in this
project.

The milestones of the project are:
1. Simple modification change history.
1a) Have an initial version which does nothing else than parse git-log
options and a single additional -L, requiring exactly one file to be
specified

1b) Implement the xdiff callback and identify the commits touching the
line range

1c) Implement a workable line level log browser

2. Code movement inside one file.
2a) Support the whole section of code literally move.

2b) Support code movement with splitting.

3c) Support code movement with code uniting.

3. Code movement inside one commit between files.

4. Code lines copied from other files that were modified in the same co=
mmit.
4a) Support the whole section of code literally copy.

4b) Support code copy split and unite.

5. Code copy of any place in one commit tree.

6. Fuzzy matching support. Note that there is not a exact strategy for
fuzzy matching and I would like this milestone a bonus one instead of
a primary milestone for GSoC. We will make a good support for this if
time allows.


And the timeline will be:
April 26 - May 23:
1st week, follow the bird's eye view on Git's source code.
2nd week, have a look at the code of merge-base, analyze the rev-listma=
chinery
3rd week, have a look at builtin/log.c,
4th week, understand blame.c

May 24 - June 13 :   Complete a version which supports code
modifcation trace but without code movement and code copy support. For
detail:
1st week, milestone 1a, 1b
2-3 week, milestone 1c

June 14 - July 11:   Complete a version which supports code movement.
1st week, milestone 2a
2nd week, milestone 2b
3rd week, milestone 2c
4th week, milestone 3

July 12 - August 1:   Complete a version which supports code copy.
1st week, milestone 4a
2nd week, milestone 4b
3rd week, milestone 5

August 2 - August 14:  Complete fuzzy matching of code movement and cop=
y detect.


And there is one milestone for each week nearly, so every week, I will
post a stutas update to the list to let the community know the project
progress. And, patches will be sent for feature completion but not
milestone.

=3D=3D=3D=3D=3DAbout me=3D=3D=3D=3D=3D
I am Bo Yang, a Chinese graduate student majoring in Computer Science
of NanKai University. I have touched some open source software since 5
years ago and began to contribute code to open source community from
three years ago. I have contributed to Mozilla/Mingw/Netsurf.
Technically, I am experienced in C/Bash Shell. I have attended last
year's GSoC with Netsurf project. In that project, I have completed
most of a DOM library in C.
I begin to use git for source code revision from about two years ago.
I use Git for track my Mozilla trunk source code. Because updating
Mozilla code by CVS in my school is very slow. So, I write one script
to automatically updating the trunk with CVS at mid-night, when the
network flow is fast, on the server, and then use Git to maintain the
code. Then I use Git in my PC to clone/update the source code from my
local server and that is very fast. I use Git to track my changes to
the code and some bug fixes. It is an excellent tool for
branch/history, I think.
Git is my lovely daily tool for revision control. I have much
experience with it and have read "Git Internals" and also get some
basic knowledge about Git's code base. And I think the line-level
history explorer is really suitable for me and I can make a good start
with this project in Git community.
