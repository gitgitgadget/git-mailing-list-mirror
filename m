From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] [trivial] Fix comment typo
Date: Tue, 12 Nov 2013 09:41:18 -0800
Message-ID: <xmqq61rxikld.fsf@gitster.dls.corp.google.com>
References: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
	<xmqqob5pilmj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 18:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgHxy-0003CN-E8
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264Ab3KLRl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:41:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36121 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932182Ab3KLRlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:41:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F99550DF0;
	Tue, 12 Nov 2013 12:41:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4lS9y1BpIfqgJb4v2EWPI2MqrwM=; b=wAn4Cg
	YCIUoWjvK4gPjCEQ86u/Tzsxb3ewbWf+xG7Z6BFA4aeNiKgDwlsneH3wrIGJ+GD3
	0y4vBpKpGylICfJEUnEUYoS5LtdCZErjGFvZfo/X4ktlBzLUlDIc+i8u1JIaQlyr
	rbEbBdmv/bM3BkCjCtu8u/zSEf1bNSe3lCkS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e0h2wHrB4eVe1j1h57xGH7w9IxeuG5TT
	YOsgIc8NcuRuZ20spWGMp7AzJYD3TF5x/kRYiTPoEB+uBu2BI1+H9TRnx6VnRcsb
	9sGj9hPj97mkVWalcL79+b86KBE0/UUj+1LRjBIO+lz8wkoaTdKcPYFY9MZFJ+nh
	tD3Bml1PDKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D7A750DEF;
	Tue, 12 Nov 2013 12:41:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A2D550DEE;
	Tue, 12 Nov 2013 12:41:20 -0500 (EST)
In-Reply-To: <xmqqob5pilmj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Nov 2013 09:19:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A3F07CCA-4BC1-11E3-B885-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237722>

Junio C Hamano <gitster@pobox.com> writes:

> Masanari Iida <standby24x7@gmail.com> writes:
>
>> Correct spelling typo
>>
>> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
>> ---
>>  git-bisect.sh | 2 +-
>>  pathspec.c    | 4 ++--
>>  wrapper.c     | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 9f064b6..ebac284 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -137,7 +137,7 @@ bisect_start() {
>>  			# cogito usage, and cogito users should understand
>>  			# it relates to cg-seek.
>>  			[ -s "$GIT_DIR/head-name" ] &&
>> -				die "$(gettext "won't bisect on seeked tree")"
>> +				die "$(gettext "won't bisect on sought tree")"
>
> The phrasing before your "fix" comes from Cogito which called the
> state cg-seek left in a "seeked tree", I think, so this change is
> probably a wrong thing to do.

As Cogito is long dead, I do not think this error message will be
shown to normal users at all, and the only people who will see it
would be the ones who know what Cogito is/was.

I'll rephrase this part and queue the attached, at least for now.
All other patches looked good (except for 3/4, which I'll forward to
Pat after tweaking the paths to match his tree) and I will queue
them.

Thanks.

-- >8 --
From: Masanari Iida <standby24x7@gmail.com>
Date: Wed, 13 Nov 2013 00:17:42 +0900
Subject: [PATCH] typofixes: fix misspelt comments

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh | 2 +-
 pathspec.c    | 4 ++--
 wrapper.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 9f064b6..73b4c14 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -137,7 +137,7 @@ bisect_start() {
 			# cogito usage, and cogito users should understand
 			# it relates to cg-seek.
 			[ -s "$GIT_DIR/head-name" ] &&
-				die "$(gettext "won't bisect on seeked tree")"
+				die "$(gettext "won't bisect on cg-seek'ed tree")"
 			start_head="${head#refs/heads/}"
 			;;
 		*)
diff --git a/pathspec.c b/pathspec.c
index ad1a9f5..be962d4 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -193,11 +193,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	magic |= short_magic;
 	*p_short_magic = short_magic;
 
-	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specifed */
+	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
 	if (noglob_global && !(magic & PATHSPEC_GLOB))
 		global_magic |= PATHSPEC_LITERAL;
 
-	/* --glob-pathspec is overriden by :(literal) */
+	/* --glob-pathspec is overridden by :(literal) */
 	if ((global_magic & PATHSPEC_GLOB) && (magic & PATHSPEC_LITERAL))
 		global_magic &= ~PATHSPEC_GLOB;
 
diff --git a/wrapper.c b/wrapper.c
index 9a6aaaf..0cc5636 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -133,7 +133,7 @@ void *xcalloc(size_t nmemb, size_t size)
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
- * the absense of bugs, large chunks can result in bad latencies when
+ * the absence of bugs, large chunks can result in bad latencies when
  * you decide to kill the process.
  */
 #define MAX_IO_SIZE (8*1024*1024)
-- 
1.8.5-rc1-310-g1febc12
