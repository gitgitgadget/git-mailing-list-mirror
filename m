From: David Kastrup <dak@gnu.org>
Subject: Re: A few contributor's questions
Date: Fri, 31 Jan 2014 18:00:11 +0100
Message-ID: <87mwic2ijo.fsf@fencepost.gnu.org>
References: <8738k44808.fsf@fencepost.gnu.org>
	<20140131161924.GA4332@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 31 18:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9HRz-00016Z-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 18:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbaAaRAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 12:00:14 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:47609 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbaAaRAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 12:00:13 -0500
Received: from localhost ([127.0.0.1]:46650 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W9HRs-00059I-Cd; Fri, 31 Jan 2014 12:00:12 -0500
Received: by lola (Postfix, from userid 1000)
	id DBBEAE0521; Fri, 31 Jan 2014 18:00:11 +0100 (CET)
In-Reply-To: <20140131161924.GA4332@google.com> (Jonathan Nieder's message of
	"Fri, 31 Jan 2014 08:19:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241305>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Also keep in mind that you don't need a copyright notice to own
> copyright, that it would be crazy for someone to claim you've assigned
> copyright on your changes without an explicit reassignment,

Not at all crazy: Documentation/SubmittingPatches states that adding a
"Signed-off-by:" footer to a commit among other things constitutes
agreement to

        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

The only relevant notice to licensing "indicated in the file" currently
is "Copyright (c) 2006 by Junio Hamano".

Also whether or not this implies an assignment of copyright, it is a
reasonable assumption for people working with a copy of Git distributed
by tar file or otherwise that a file with such a copyright notice only
contains material copyrighted by Junio Hamano.  So if I want to assert
my copyright in the case of licensing breaches, the party in breach may
claim estoppel by me "hiding" material copyrighted by myself in a file
with such a notice.

> and that libgit2's git.git-authors file that keeps coming up includes
> a comment with a heuristic for delving into the history to find the
> authors of some code.

Sure.  But that does not mean that this is the only means to "reasonably
infer" the authorship of a file.

> [...]
>> Permissable-Licenses: GPL Version 2 or later
>
> Wouldn't a signed message on your website or some other public place
> (e.g., the mailing list) do the trick?

Legally?  Sure.  The whole point of such a notice in the commit message
(or in some central file in the Git repository) is to save people the
hassle of second-guessing or sleuthing for every single contribution.

> Or a sentence in a commit message saying
>
>  "I'd be happy to have these changes relicensed under the GPL version
>  2 or later."
>
> sounds fine to me, at least.

It's verbose and cumbersome enough that I would not have been surprised
if there'd be an established way of getting this information on record,
preferably per-project rather than per-commit.  If it's going to be
per-commit, a footer line would be less obtrusive than a whole sentence.

But it would seem that there's no rule/standard here.

Thanks

-- 
David Kastrup
