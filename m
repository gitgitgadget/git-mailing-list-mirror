From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 04 Nov 2011 14:12:36 -0700
Message-ID: <7vaa8bbni3.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Fri Nov 04 22:12:49 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RMR4C-0006St-C0
	for glk-linux-kernel-3@lo.gmane.org; Fri, 04 Nov 2011 22:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab1KDVMl (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 4 Nov 2011 17:12:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab1KDVMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2011 17:12:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A70F564B6;
	Fri,  4 Nov 2011 17:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=42Kqt+tgckK/57WrDED6kVKB5+8=; b=HdE3ms
	co/+mJkbjjMmAdIt8pbMkskyRmz3mLLCVqcppvsfJkukT3qCKIi+as7jiqC9zZor
	qfWOrDM8ES9/gp72EtZAKclx/VmvreOk4pYKTjCFu9BzUgqrGoRSDGQdq+UBoYbE
	lbAz5Q+U8CcJThQ3e+FDdxkytJUmjNyUIIofo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TyxRyyxvk3POAh64eAPbBajB8ZLyoDBM
	9Ocyxi5gwbEC3lwVjgvezcfbXve4l0y+wf3G+OS4vMFjZSuxTj4L1HnVLAl1kLWu
	6hiCEDkx7CFbCoelJI41jWp2Xh5idQ2YjLIpOxZKEHE1qWpmO5C+tkfkHKEH7DIu
	E8VuYL5RmH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DD7F64B5;
	Fri,  4 Nov 2011 17:12:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 000D164B3; Fri,  4 Nov 2011
 17:12:37 -0400 (EDT)
In-Reply-To: <7v62j1gitn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Nov 2011 11:16:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B939CE94-0729-11E1-A21C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184804>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>>   [torvalds@i5 linux]$ git fetch
>> git://github.com/rustyrussell/linux.git
>> rusty@rustcorp.com.au-v3.1-8068-g5087a50
>>   fatal: Couldn't find remote ref rusty@rustcorp.com.au-v3.1-8068-g5087a50
>>
>> oops. Ok, so his tag naming is *really* akward. Whatever.
>
> It is not "Whatever".
>
>  $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v3.0
>  fatal: Couldn't find remote ref v3.0
>
> I do not think we ever DWIMmed fetch refspecs to prefix refs/tags/, so it
> is not the naming but fetching tags without saying "git fetch tag v3.0"
> (which IIRC was your invention long time ago). 

If we really wanted to go this route, the attached single-liner should be
sufficient for the DWIMmery.

Note that the DWIMmery rules for "git fetch" and local "git rev-parse" are
still different even after this patch.

"git log frotz" can DWIM to "refs/remotes/frotz/HEAD", but in the remote
access context, "git fetch frotz" to fetch what the other side happened to
have fetched from what it calls 'frotz' (which may not have any relation
to what we consider is 'frotz') the last time would not make much sense,
so the fetch rules table does not include "refs/remotes/%.*s/HEAD".

When the user really wants to, "git fetch $there remotes/frotz/HEAD" would
let her do so anyway, so this is not about safety or security; it merely
is about confusion avoidance and discouraging meaningless usage.

Specifically, it is _not_ about ambiguity avoidance. A name that would
become ambiguous if we use the same rules table for both fetch and local
rev-parse would be ambiguous locally at the remote side.

If we really wanted to, we could 

	#define ref_fetch_rules ref_rev_parse_rules
 
in cache.h and remove the array's declaration from cache.h and its
definition from refs.c to really unify the two, but I haven't thought
things through.

-- >8 --
Subject: [PATCH] fetch: allow "git fetch $there v1.0" to fetch a tag

You can already do so with "git fetch $there tags/v1.0" but if it is not
ambiguous there is no reason to force users to type more.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index e69ba26..670a7b3 100644
--- a/refs.c
+++ b/refs.c
@@ -1001,6 +1001,7 @@ const char *ref_rev_parse_rules[] = {
 const char *ref_fetch_rules[] = {
 	"%.*s",
 	"refs/%.*s",
+	"refs/tags/%.*s",
 	"refs/heads/%.*s",
 	NULL
 };
-- 
1.7.8.rc0.108.g71b5ec
