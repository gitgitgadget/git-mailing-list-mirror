From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead
 Of Pull Requests
Date: Thu, 01 Mar 2012 22:03:37 -0600
Message-ID: <4F504699.3070406@gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com> <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino> <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Jia-00014Y-5u
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 05:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab2CBEDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 23:03:37 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35661 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab2CBEDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 23:03:36 -0500
Received: by ggnh1 with SMTP id h1so632799ggn.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 20:03:35 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.186.1 as permitted sender) client-ip=10.236.186.1;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.186.1 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.186.1])
        by 10.236.186.1 with SMTP id v1mr11544264yhm.4.1330661015748 (num_hops = 1);
        Thu, 01 Mar 2012 20:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cgVhqBhipAHbJL2rjY28XJK+rfu7hgjc57+PMNcEzjE=;
        b=gH0rNdm8z4J+k72FdiqbmGuU0nPWd2zPb8mzFlkGySxJZzKx7pzucorubmccmSMOyv
         8VQIArcbBLI95mU9p5wMx1ez9IOO1ClkOkkCufHQx+2aa3jZ4sEMrsbFTGUrNJoibAqR
         HjppiE+/OgYCnsk0PIS/fHnBYisdZRZRYsdOcZZqCDvhE4dDikUH+WlWYJ0Y5UQipffo
         TXG3KOk8YmzKXcqSo/vdkLTGP8oWTelk8ST6a598r15nqpzzG4cU9Ap124XmZSRj/S4w
         MGy1yV1L0S4wof1ewTfxP/VGFtOJ60owyy9uvSanQrWP983k0gHOodOanz2uDZOaKYCX
         D1gg==
Received: by 10.236.186.1 with SMTP id v1mr9147464yhm.4.1330661015677;
        Thu, 01 Mar 2012 20:03:35 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p41sm10507603yhj.14.2012.03.01.20.03.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 20:03:34 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vmx80nt68.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191996>

On 3/1/2012 11:10 AM, Junio C Hamano wrote:
>
> Something based on the idea mentioned in =C3=86var's message (downstr=
eam in
> this thread) to seamlessly integrate with the e-mail traffic might ha=
ve a
> chance to succeed.  I also think the integration must be two-way for =
it to
> be useful.  A summary of "new issues untouched for N weeks" and anoth=
er
> "older issues unclosed for N weeks" periodically sent here, or someth=
ing.
>
> Perhaps collecting messages based on a handful of simple heuristics l=
ike
> "A message mentioned the keyword 'bug', but no In-Reply-To for it fro=
m any
> list regulars came in two weeks" might be a good place to start.
>
Why don't you just use git for your bug-tracking?  With commit-messages=
,=20
annotated-tags, signed-tags, branches, branch-descriptions, git-notes,=20
submodules, sha-1's, send-email, patches, hooks, etc., not to mention=20
all-kinds-of-files you can commit (screen-shots, bug-reports, etc.) it=20
seems you have more than enough pieces to build a bug-tracker with git.=
=20
  For example:

Some Ideas:

(Setup)
   - The bug tracker repo could be a one-way mirror of git.git.  That=20
way the bug-reports are literally tied to the source but don't clutter=20
git.git.
   - Create a bug tracking branch parallel to each release branch.
   - Create a bug-branch off-of the buggy-commit and do the fix and mak=
e=20
the bug-tracking-admin updates around the bug branch.

(Submitting Bugs)
   - Post-receive hook to assess new commits and send formatted email t=
o=20
mailing list, ie. new-bug push sends bug email to mailing list.
   - The mailing list creates "bug-report-commits" kind-of-like Junio=20
mentioned above so the mailing list also feeding into it.
   - Bugs can be submitted directly to the bug repo and replicated to=20
the mailing list via post-receive hook, and bugs can be submitted via=20
the mailing list and automatically "forwarded" to the bug repo as "bug=20
report" refs.
   - Screenshots could be a submodule for "large file" optimization.

(Issue-Numbers)
   - The sha-1 of the originating bug-report could be its issue-id.
   - Tag the commit with a "bug tag".  The sha-1 of the bug-tag could b=
e=20
the issue-id.
   - Calculate issue number from commit-counting to assign unique numbe=
rs.
   - The sha-1 of the buggy-commit could be the issue-id.

(Status Updates)
   - Use git-notes to update issue status.
   - Use annotated-tags to update issue status.
   - Use commit-messages to update issue status (or a file in the commi=
t).

(Reporting)
   - Interrogate bug-formatted refnames with wildcards to generate=20
queries of whats going on.
   - Use gitk for ad hoc or pre-defined gui queries of what-you-want-to=
-see.
   - Use git time-machine commands to see how old stuff is or whats new=
=2E
   - have a bug-report-id.txt file that people just modify and commit=20
and use git-annotate to see the history of that bug-report.

(Signoff)
   - Signed tags for authenticity.

(Standardization)
   - Git-commands or git-aliases or git-contrib-scripts to make sure=20
people do-it-right (format names/messages/files correctly), ie. templat=
es.
   - Commit hook snippet that detects bug branch format and brings up=20
bug commit template.
   - Rebase hook snippet that doesn't allow bug branches to be rebased.

(Integration)
   - The bug tracking system becomes part of the release workflow, ie.,=
=20
bugs are only considered fixed when they graduate to an official releas=
e=20
or something close.
   - The "bug" tracking system also tracks "enhancements" and they are=20
integrated into new releases using that workflow.

(Concurrency control)
   - Concurrent bug-report updates merge-conflict.
   - If someone beat-you-to-it then you cherry-pick or rebase on top of=
=20
them.

(Interfaces)
   - works from commandline
   - works with gitk, git-gui
   - works with gitweb

(Quality)
   - Do you really need the greatest commercial-bug-tracker "x" or=20
opensource-bug-tracker "y" to meet your needs?  If you've done well wit=
h=20
nothing then you probably don't need all the bells an whistles.=20
Management-by-report is mainly for clueless managers who want to feel=20
like they know whats going on, and to supervise people who=20
don't-really-care.  Since git people are on-the-ground and know whats=20
going on, and are highly motivated individuals you probably don't reall=
y=20
need all that fluff.  I suspect you would already be using=20
opensource-bug-tracker "y" if there was one you actually liked using.
   - There's probably someone on this list who thinks they can create a=
=20
bug-tracker with git that's better-than-anything-else-out-there, and=20
they're probably right.

(Intuitive)
   - If you know how to use git then you know how to use git bug-tracke=
r.
   - If you don't know how to use git then you probably shouldn't be=20
submitting bug reports.

(Open Source Reusability)
   - The git bug repo system can then be used by others internally as=20
they apply that system to their own project's canonical repository to=20
track their bugs internally.

Some-Stuff-You-Already-Know:

(Distributed)
   - clone, push, pull -- your using git.

(Reliability)
   - you're using git so you know its uncorrupted, and if it does go=20
down just clone from someone else and verify the checksum.

(Support)
   - git@vger.kernel.org
   - If git.git is down there is not much point in bug-tracking it.

I've been wanting to do this internally for a whle, but I'm still=20
learning the git scm part.  Some of the git technologies I listed above=
=20
I haven't used yet so they may sound a bit off, but I think you can get=
=20
the gist of it.

I think git people in general would be enthusiastic about this, and if=20
so, that would be the one thing that truly distinguishes this proposal=20
from the others ;-)  You could call the repo or system bug-git,=20
git-err-done, or something like that.

v/r,
neal
