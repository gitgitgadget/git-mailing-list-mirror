From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Our cumbersome mailing list workflow (was: Re: [PATCH 0/6] repack_without_refs():
 convert to string_list)
Date: Tue, 25 Nov 2014 01:28:24 +0100
Message-ID: <5473CD28.5020405@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>	<546F4B5B.2060508@alum.mit.edu> <xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 01:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt3ze-0003tA-5E
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 01:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbaKYA2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 19:28:30 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46387 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772AbaKYA23 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 19:28:29 -0500
X-AuditID: 12074414-f797f6d000004084-20-5473cd2b986b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.4A.16516.B2DC3745; Mon, 24 Nov 2014 19:28:27 -0500 (EST)
Received: from [192.168.69.130] (p4FC967F6.dip0.t-ipconnect.de [79.201.103.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP0SP5V008599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 24 Nov 2014 19:28:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqKt9tjjE4PAVVYuuK91MFg29V5gt
	3t5cwmjxb0KNxebN7SwOrB47Z91l91iwqdTj4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M2Z9
	O8pYcMamYvG/JcwNjFcMuhg5OSQETCT2vz3IBmGLSVy4tx7I5uIQErjMKLH1xikmCOcCk8SB
	zZ1MIFW8AtoS538fB7NZBFQl+i+tBetmE9CVWNTTDBYXFQiSOLnnOjtEvaDEyZlPWEBsEQE1
	iYlth8BsZoGJjBKbN4BdISxQIvG4r4URYtlJRoltj6eAFXEKWEv0bP3FBNGgJ7Hj+i9WCFte
	onnrbOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNK
	NzFCAltkB+ORk3KHGAU4GJV4eBuOFYcIsSaWFVfmHmKU5GBSEuVddRIoxJeUn1KZkVicEV9U
	mpNafIhRgoNZSYQ3ah5QjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJ
	gvfCaaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFC0xhcD4xUkxQO09z1IO29x
	QWIuUBSi9RSjopQ4736QhABIIqM0D24sLF29YhQH+lKY1/YMUBUPMNXBdb8CGswENDhuZiHI
	4JJEhJRUA6Ov6ILrRRriAWWROTb3zYR+KdwKFv8V+NPr5M+bP2fNt/Wv2flO6fzR1pUNh21+
	bA75f7OTJ3jTufbSpK9pfDbagtuEs2L3Phe8vX7qmfzAAxNmMrRfVZ/99iZ3zuO0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260176>

On 11/21/2014 07:00 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I don't think that those iterations changed anything substantial that
>> overlaps with my version, but TBH it's such a pain in the ass working
>> with patches in email that I don't think I'll go to the effort of
>> checking for sure unless somebody shows interest in actually using my
>> version.
>>
>> Sorry for being grumpy today :-(
> 
> Is the above meant as a grumpy rant to be ignored, or as a
> discussion starter to improve the colaboration to allow people to
> work better together instead of stepping on each other's patches?

I think I know the sentiments of the mailing list regulars well enough
that it didn't seem worthwhile to open this topic again, so I was just
letting off steam without any hope of changing anything. But since you
asked...

Let me list the aspects of our mailing list workflow that I find
cumbersome as a contributor and reviewer:

* Submitting patches to the mailing list is an ordeal of configuring
format-patch and send-email and getting everything just right, using
instructions that depend on the local environment. We saw that hardly
any GSoC applicants were able to get it right on their first attempt.
Submitting a patch series should be as simple as "git push".

* Once patches are submitted, there is no assurance that you (Junio)
will apply them to your tree at the same point that the submitter
developed and tested them.

* The branch name that you choose for a patch series is not easily
derivable from the patches as they appeared in the mailing list. Trying
to figure out whether/where the patches exist in your tree is a largely
manual task. The reverse mapping, from in-tree commit to the email where
it was proposed, is even more difficult to infer.

* Your tree has no indication of which version of a patch series (v1,
v2, etc) is currently applied.

The previous three points combine to make it awkward to get patches into
my local repository to review or test. There are two alternatives, both
cumbersome and imprecise:

  * I do "git fetch gitster", then try to figure out whether the branch
I'm interested in is present, what its name is, and whether the version
in your tree is the latest version, then "git checkout xy/foobar".

  * Or I save the emails to a temporary directory (awkward because, Oh
Horror, I use Thunderbird and not mutt as email client), hope that I've
guessed the right place to apply them, run "git am", and later try to
remember to clean up the temporary directory.

* Once I've done that, the "supplemental" comments from the emails (the
cover letter and the text under the "---") are nowhere available in the
Git repository. So if I want to see the changes in context plus the
supplemental comments, I have to jump back and forth between email
client and Git repo. Plus I have to jump around the rest of the email
thread to see what comments other reviewers have already made about the
series.

* Following patch series across iterations is also awkward. To compare
two versions, I have to first get both patch series into my repo, which
involves digging through the ML history to find older versions, followed
by the "git am" steps. Often submitters are nice enough to put links to
previous versions of their patch series in their cover letters, but the
links are to a web-based email archive, from which it is even more
awkward to grab and apply patches. So in practice I then go back to my
email client and search my local archive for my copy of the same email
that was referenced in the archive, and apply the patch from there.
Finding comments about old versions of a patch series is nearly as much
work.

* Because of the indeterminate application point, accumulating
Signed-off-by lines, changed committer metadata, and maintainer tweaks,
the commits that make it to the official tree have different SHA-1s than
the commits in the submitter's tree, and both are different than the
commits in the tree of any reviewer who got the patches using "git am".
This makes it hard to be sure that everybody is on the same page. It
also makes it awkward for people to exchange ideas for further changes
via Git protocols in the form of patches.

* Because of the crude serialization of patches through email, it is
only possible to submit linear patch series, not merge commits.

Hmmm, I think that covers most of the problems of handling patches and
review via a mailing list.


What are some alternatives?

I did enjoy the variety of reviewing some patch series using Gerrit. It
is nice that it tracks the evolution of a patch from version to version,
and that the comments made on all versions of a patch are summarized in
a single place. This makes it easier to avoid commenting on issues that
other reviewers have already noted and easier to check that your own
comments have been addressed by later versions of the patch. On the
other hand, Gerrit seems strongly focused on individual patches rather
than on patch series (which might not match our workflow so well), the
UI is overwhelming (though I think one could get quite productive with
it if one used it every day), and the notification emails come in blizzards.

GitHub is another obvious alternative [1], free for open-source projects
albeit not open-source itself. It is very easy to use and easy to
interact with from a Git client, and also has a good API. It is super
easy to submit patches to a project using GitHub. But the GitHub user
interface (ISTM) is optimized for getting the net result of an entire
feature branch perfect, as opposed to iterating a series of patches
until each one is individually perfect (e.g., it works best when adding
patches on top of a feature branch as opposed to rebasing existing
patches). Since Git development is oriented towards perfecting each
patch, GitHub would be a bit of an impedance mismatch.

I don't think either of those systems is ideally matched to the Git
project's workflow, but in my opinion either one of them would be more
convenient for contributors and reviewers than serializing everything
through the mailing list.

Of course what is most convenient for the maintainer is of huge
importance, but I can't say much about that.

> FWIW, I liked your rationale for "many smaller steps".

Thanks.

> One small uncomfort in that approach is that it often is not very
> obvious by reading "log -p master.." alone how well the end result
> fits together.  Each individual step may make sense, or at least it
> may not make it any worse than the original, but until you apply the
> whole series and read "diff master..." in a sitting, it is somewhat
> hard to tell where you are going.  But this is not "risk" or "bad
> thing"; just something that may make readers feel uncomfortable---we
> are not losing anything by splitting a series into small logical
> chunks.

Ideally, the cover letter should provide the "big picture" rationale for
a patch series, and the individual commit messages should provide clues
about why that step is useful.

It might be a nice convention to ask people to write the "big picture"
rationale in their cover letter, separated by a "---" from non-permanent
discussion. Then the part above the "---" could be copied into the
commit message for the *merge commit* that brings the feature branch
into master. That would preserve it for posterity in a place where it is
relatively easy to find. But I am reluctant to make the process of
submitting patches even more difficult :-)

Michael

[1] Disclaimer: I work for GitHub.

-- 
Michael Haggerty
mhagger@alum.mit.edu
