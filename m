From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com refresh
Date: Mon, 07 May 2012 10:06:06 -0700
Message-ID: <7vipg77wg1.fsf@alter.siamese.dyndns.org>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
 <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
 <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
 <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
 <C0239E9A908644EAB06A52AE4A90F401@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Scott Chacon" <schacon@gmail.com>,
	"git list" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon May 07 19:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRRO7-0006dD-RL
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 19:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426Ab2EGRGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 13:06:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756571Ab2EGRGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 13:06:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB9217C26;
	Mon,  7 May 2012 13:06:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ChicCoYpzx/OEJwceKaJGgRxJEw=; b=X+GQMK
	Q9C01ZOvmXALiR6VQ9JMuOTPsLXfeaBOitZCOVV2dp3QYkPbWHH9tunOE0jALRZH
	mqZ7BQRhFsivnEIpCdmUp9JO02oQHvtqBiUtLL3NWPp+jGuVtQ6dlqs3CF0OgHGp
	hnoL1n1mMzTPKZiJFfM+eqh+6rUigHLrEgS/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vmVGyEtIx2FidohX+Mvbk49CJ1gL6gnp
	XS5UOsvt7O+TYHSS8Uj2ZklwnqjXMgtW9NP6Dv6SKmXWdk/ItNQKYBtioUjr24W8
	S9JfcIzYw/+Z2evOc0Sfglz+UglYxrLbC5rfJSJRbXvJDe18MwN3fbbxYOUOT2hc
	yTR9CO0jB40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C248B7C24;
	Mon,  7 May 2012 13:06:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A0987C23; Mon,  7 May 2012
 13:06:08 -0400 (EDT)
In-Reply-To: <C0239E9A908644EAB06A52AE4A90F401@PhilipOakley> (Philip Oakley's
 message of "Sun, 6 May 2012 09:33:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F03DA4BE-9866-11E1-861F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197282>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com> Sent: Sunday, May 06, 2012 2:39
>
>> "diff" pairs with "apply", and "format-patch" pairs with "am".
>>
>> I wouldn't mind adding "git patch" as a built-in synonym/alias for "git
>> apply", if you think that would make the above pairing more obvious.  Many
>> computer users know what "patch" does already even they have never used
>> any SCM.
>
> Part of the problem is that the `git diff` man page [1] doesn't actively
> tell the user that its result will be in a patch format, and that such a
> patch can be `apply`ed. There are only 5 uses of 'apply' buried in the body
> text, never as a command, as if they are special cases. There is a section
> on the -p option, again it feels like it is a special case.

Sounds like you spotted a good set of places in the documentation that
need to be updated.

> The normal case of `git diff` for most users is simply as an extended 'what
> changed' git status.

I think that use of "diff" is listed in "Inspection and Comparison"
section, and I fully agree and is happy to see "diff" there as well.  Of
course, I wouldn't suggest "apply" to go next to that use of "diff".

But what I have been discussing was the use of "diff" in the "Basic
Snapshotting" section.  I actually very often use "diff" paired with
"apply" for my own work, not when working to integrate others' work.  

Also I do not think anybody would use "apply" to accept patches (that is
what "am" is for), so listing it in "Email" section is doubly wrong.  If
for some reason the command Reference does not want to have "apply" next
to "diff" listed in "Basic Snapshotting", I do not think there is any
category on that page for the command to belong to.

The above two were the primary things that triggered my reaction.

When reshaping a multi-commit series, "git diff $rev1 $rev2 >P.diff"
followed by "git apply <P.diff" (either with or without editing P.diff in
between) is sometimes a more versatile and even more natural solution than
repeated use of "rebase -i" is, depending on what kind of reshaping
I want to do.

For example, after an exploratory development session, I often end up
with something like this (time flows from top to bottom):

	update A
        update D
        refactor and modify B
	update E
        refactor and modify C

and then I realize that the refactoring I needed to give to B and C are
the similar kind, and is better done as a single step early in the
series.  This will involve splitting two "refactor and modify" commits
into four, reorder and squash in different combinations.  It often is the
most convenient to

	git checkout ":/update A"
        git diff ":/update D" ":/refactor and modify B" | git apply
        git add -p ;# only keep the 'refactor' bit
        git checkout . ;# and lose the 'modify' part
        git diff ":/update E" ":/refactor and modify C" | git apply
        git add -p ;# only keep the 'refactor' bit
        git checkout . ;# and lose the 'modify' part
	git commit -c ':/refactor and modify C'

when rebuilding 'refactor B and C' on top of 'update A'.  Of course this
does not have to be "rebase" but picking only part of good infrastructure
change from totally unrelated branch.  A concrete example is the recent
index-v4 series started by a commit that borrowed a small part of older
jc/split-blob series to refactor a varint API, and the diff to apply pipe
with editing (because the API needed to be cleaned up for the index-v4
work) was how a part of change was extracted from older branch (later the
jc/split-blob was rewritten to base it on the updated varint API that
was cleaned up for the index-v4 series).

In such a workflow, the use of "diff" is very much "Basic snapshotting"
(which is the category head I was referring to).  It is used as a mechaism
to take a snapshot, and not as a measure for "Inspection and Comparison".

And the way to replay that basic snapshot to the working tree is "git
apply".  Without the matching pair, "git diff" does not serve well as a
"Basic snapshotting" feature.

I do not think Scott is ignorant of or unsympathetic to such a use case
(after all, he mentioned use of GNU patch on "git diff" output, so he must
use "take a diff to stash away some change, then replay it to the working
tree" workflow, even if much less often than I do.  Perhaps he personally
uses it not so often and its usefulness escaped him).

It is a different topic if it makes sense to enhance "rebase -i" to
support "split two, shuffle and squash in a different way".  I do not
think of a good UI for such an operation offhand.
