From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sun, 10 Jun 2012 12:02:39 -0400
Message-ID: <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com> <7vr4tnab9e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 18:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdkcE-0004T7-G6
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 18:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab2FJQDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 12:03:03 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65013 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab2FJQDB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 12:03:01 -0400
Received: by vcbf11 with SMTP id f11so1721908vcb.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Enn21kxKi8HdJUNAbix+hsvnUkK1B7EW9P2Xb1Djkek=;
        b=w+1mnxj3Ogdq6seGD/Zj9eAdaCwtIlV+L81ore5hnKLEkOJtDfygXeD0Du5Qog2HxA
         XI2Snuy/tGxLnAqVsO1qh5/Eyvd+ESto4M6GiO9NiIghI3yN5fHMtMylsESUcXIo+Jdh
         ppkj0WmY2LSDLSQgPStX9hUHMTkyA4uhxdTKCPI8iUfeJiiFEQZxcvfj2LGVtu4Ampvr
         w8P6S2YZpqJ0GLUIGUvQmul2NFwJtWdtHzPhTF1wuDBmGTL6TYbKVMAow8xFGOmqSryR
         LAn8ZAKLL0cVYIz1Ep67UNJiTPDg3lhD8DdEGCCHPZXWKXIrIUxf/wvF2ct71t3/W6k0
         yxGw==
Received: by 10.52.22.69 with SMTP id b5mr9336497vdf.12.1339344180334; Sun, 10
 Jun 2012 09:03:00 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Sun, 10 Jun 2012 09:02:39 -0700 (PDT)
In-Reply-To: <7vr4tnab9e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199609>

On Sun, Jun 10, 2012 at 3:15 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Leila Muhtasib <muhtasib@gmail.com> writes:
>
>> git-status now lists empty directories under the untracked header. B=
efore this
>> modification, git status did not list empty directories. The header =
changed
>> from 'Untracked files' to instead display 'Untracked files and direc=
tories'.
>> A helpful reminder is also added after empty directories indicating =
they cannot
>> be added/staged if they are empty. git status -u is unchanged, and w=
ill still
>> only show untracked files just as before. As a result, no need for
>> documentation change.
>
> Please do not write a thick wall of text like this. =A0State the
> problem you are trying to solve first, by describing the current
> behaviour you want to highlight, and explain why you think the
> current behaviour is bad. =A0Then describe how you propose to solve
> that issue in a separate paragraph.
>
> For example:
>
>> git-status now lists empty directories under the untracked header. B=
efore this
>> modification, git status did not list empty directories.
>
> The above is backwards.
>
> =A0 =A0 =A0 =A0"git status" lists untracked files and directories ful=
l of
> =A0 =A0 =A0 =A0untracked files, but does not list empty directories. =
=A0This
> =A0 =A0 =A0 =A0is bad for such and such reasons.
>
> Then describe your solution (which should be a short two sentence in
> this case, because in the problem description you would have justifie=
d
> adding "empty directories" section).
>
> =A0 =A0 =A0 =A0Show empty directories to the "Untracked" section as w=
ell.
> =A0 =A0 =A0 =A0Because an empty directory by definition does not have
> =A0 =A0 =A0 =A0anything that the user could add, suggest the user to =
create
> =A0 =A0 =A0 =A0a file to be committed and then add it.

Understood, I'll make sure to do that in the future. I appreciate the e=
xample.

>
> Having said all that, I personally doubt this is a useful change. =A0=
I
> may thought of adding a README file to a relatively new project that
> does not yet have one while in shower but I haven't even created the
> file in the working tree. =A0And I forget about it once I get to the
> office. =A0Should the system remind me to create README and then add?
> Your patch would not give me such a reminder once the top-level
> directory is populated (because it is no longer empty). =A0Even if I
> were planning to add Documentation/README instead, I would get such
> a reminder only if the Documentation directory is empty. Once the
> directory is populated, I wouldn't get "create README and then add".
> Why should an empty directory so special?
>

So there are two separate discussions here:
1) Should empty dirs be tracked

2) Should empty dirs appear under 'untracked' in git status

The question 'why are empty dirs special', is issue no 1, which I'm
also happy to discuss. The rule empty dirs can't be added in git is
unintuitive, as people use git to keep track of things - all things.
So it's not about an empty dir being special, it's about how people
use git to keep track of things. Now why might people want empty dirs
tracked? 1) People often setup dir structure in projects before adding
any code. They often want to save that state for themselves or to
share it with other team members. 2) Taken from link below: "Although
the directories contain no files, just empty directories, they are
used by the test suite, so I need them to exist in the working tree."
3) It's about saving state, all of it, including empty dirs (even if
they are not useful at the time).

This issue is often raised:
https://git.wiki.kernel.org/index.php/GitFaq#Can_I_add_empty_directorie=
s.3F
http://stackoverflow.com/questions/115983/how-do-i-add-an-empty-directo=
ry-to-a-git-repository/8944077#8944077
http://stackoverflow.com/questions/9072022/why-cant-i-track-these-files=
-with-git

I'm aware of the workaround to add a README or .gitignore file to the
empty dir so it can be tracked, but why have a workaround if people
want to add empty dirs. If they want an empty one, they want an empty
one without any files in it. And if they don't want an empty one, they
want to put something real in it (maybe a README, maybe something
else). Thus knowing a dir is empty helps with this point, as the user
can do something about it. Leading our discussion to point 2...

Now, let's put discussion no. 1 aside, and tackle the completely
separate question "should empty dirs appear under 'untracked' in git
status"?

Regardless of whether or not git supports tracking empty dirs, I think
we need this feature. There is confusion among people on this topic
(thus q's on the q&a site). So a helpful message of "empty dirs cannot
be tracked" will abate that. You bring up a good point with having
that message be in the form of a suggestion such as "empty dir: adding
a file to the dir will allow you to track it", "empty dir can't be
tracked: did you forget to add a file?", or something of the sorts.

Why would showing a message about empty dirs in the untracked section h=
elp:
1) Clarifies git's position on the matter, and provides a helpful remin=
der.
2) Abates confusion since ppl may think they've already tracked the
dir (by adding and commit it) and thus it is not appearing under the
untracked list.
3) People use git status to see the state of their working directory.
=46eedback of a dir being empty, because they mistakenly added it and
forgot to remove it, or forgot to add something to it is helpful.

And since untracked means not currently tracked by git, and empty dirs
currently at any given point are untracked, they should appear in this
list. So even if you're not sold on discussion no1, I think we need
this patch to solve a communication issue, and to serve as a helpful
reminder which is what git status is all about.

Thanks,
Leila
