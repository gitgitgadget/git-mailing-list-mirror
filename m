From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-index man page
Date: Sun, 19 May 2013 22:01:20 -0700
Message-ID: <7vr4h2w8gv.fsf@alter.siamese.dyndns.org>
References: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
	<7vhahzza2v.fsf@alter.siamese.dyndns.org>
	<CAKEGsXRry_=BuPRPK_syW7_W+_Bh+A1bB9U5YC02=a+Z+SHv1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Albert Netymk <albertnetymk@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 07:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeIE0-0005fj-D6
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 07:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab3ETFB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 01:01:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3ETFBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 01:01:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 514A516791;
	Mon, 20 May 2013 05:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4bAgfjfyYjwUoLICuxZrhHOIG0Q=; b=tl7R1p
	Oeel5h9nin+q9QNqjtpAtmPLXdWKWIIFwwdNxL/24vzja3aU7d7fZyJln3Dk90Wh
	wQfOmDk2qPWKzvK3UorUgqvTmBHYB7uwaCZXsymeucV+iZJJfZ15rasK3Zc7Q1JZ
	0lHQVZaW4OTzynOIc8qCnhO9My3WsUuQAr/9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOOiK6XQBFahZF0XGrw3Nv90dYfYl+sl
	dOoyce78kNd8M71zCG1RqFLxiYuAU+9YE80EbiVbWrWPmlYIOiw7uHJn8ljuzjTl
	xk61SS2LGD2zIrcI5cqjZHzSZCWxnPjbLfb/raJkJUfC5hWf9ivaru+lo3pZcwdX
	G3M3rHpGRQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43A1416790;
	Mon, 20 May 2013 05:01:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1591C1678B;
	Mon, 20 May 2013 05:01:22 +0000 (UTC)
In-Reply-To: <CAKEGsXRry_=BuPRPK_syW7_W+_Bh+A1bB9U5YC02=a+Z+SHv1w@mail.gmail.com>
	(Albert Netymk's message of "Sun, 19 May 2013 22:23:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5137AD2E-C10A-11E2-A0BE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224936>

Albert Netymk <albertnetymk@gmail.com> writes:

> On Sun, May 19, 2013 at 9:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Albert Netymk <albertnetymk@gmail.com> writes:
>>
>>> Hello,
>>>
>>> The man page of git-diff-index:
>>> http://git-scm.com/docs/git-diff-index
>>> states that
>>> `git-diff-index - Compares content and mode of blobs between the index
>>> and repository`.
>>> However, in fact this command compares between files on disk and
>>> repository by default. It's explained clearly in here:
>>> http://git-scm.com/docs/gitdiffcore
>>>
>>> Maybe the man page could be updated to reflect this in NAME section:
>>> `git-diff-index - Compares content and mode of blobs between files on
>>> disk and repository or between the index and repository`
>>
>> Surely; we need to keep it fit on a single line, though.
>
> Here's one excerpt from man page of git-diff-index: (this is how one
> line looks like)
> Compares the content and mode of the blobs found via a tree object
> with the content of the current index and, optionally ignoring the
> stat state of
> `git-diff-index - Compares content and mode of blobs between files on
> disk and repository or between the index and repository`
>
> It seems that this one is not longer than one line.

I would say

	git-diff-index - Compare a tree and the working tree or the index

should be sufficiently short and much more accurate than the current
text.

> I don't know how to submit patches. Besides, the only part that is a
> bit misleading is the "NAME" and "DESCRIPTION" section. Could someone
> just update them?

How about something like this?

-- >8 --
Subject: [PATCH] Documentation/diff-index: mention two modes of operation

"diff-index" can be used to compare a tree with the tracked working
tree files (when used without the --index option), or with the index
(when used with the --index option).

The text however did not say anything about the comparision with the
working tree at all.  Fix this.

Reported-by: Albert Netymk <albertnetymk@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-diff-index.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index c0b7c58..58308e1 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -3,7 +3,7 @@ git-diff-index(1)
 
 NAME
 ----
-git-diff-index - Compares content and mode of blobs between the index and repository
+git-diff-index - Compare a tree and the working tree or the index
 
 
 SYNOPSIS
@@ -13,11 +13,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Compares the content and mode of the blobs found via a tree
-object with the content of the current index and, optionally
-ignoring the stat state of the file on disk.  When paths are
-specified, compares only those named paths.  Otherwise all
-entries in the index are compared.
+
+Compare the content and mode of the blobs found in a tree object
+with the corresponding tracked file in the working tree, or with the
+corresponding paths in the index.  When paths are specified,
+compares only those named paths.  Otherwise all entries in the index
+are compared.
 
 OPTIONS
 -------
