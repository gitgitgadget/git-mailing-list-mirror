From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Tue, 13 Mar 2012 20:44:20 -0700
Message-ID: <7vwr6nsv6z.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <4F57D18B.5090506@lsrfire.ath.cx> <7vzkbskr71.fsf@alter.siamese.dyndns.org>
 <4F58F06A.1070108@lsrfire.ath.cx> <7v1up2ew9u.fsf@alter.siamese.dyndns.org>
 <CABURp0oVn3s27Rtq2JQeLBgcXq1-R-=0qawcXVMxZ8qgOeZGkQ@mail.gmail.com>
 <20120313210357.GC27436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 04:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7f8w-0001SV-GM
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 04:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab2CNDoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 23:44:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2CNDoX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 23:44:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC8F7312;
	Tue, 13 Mar 2012 23:44:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CgMKVH2mTg60
	wQfuknQCAHAvsLE=; b=sGxIrL3AtoqUIw2o2H6ACWFP0k57Cpo4tnGSI5J7N/cu
	88fSEz3ZyGz93BTJ/XMVyG8VmmbEHvLNgRBE9AmzouOoO77/MEwlaIxwQqGWRrMs
	G1S4dTRYvw1W7y9mzNt6aV0NQfVkz0IQZg7+N0XzncsO1U30SSVHpILCjXblYvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ph9gLV
	wx30/+Lb5iHG5mDCnkZ2KIiwggSnOSVHif1fyoEG7cptwsSw9PsFmZ56CY6xwryQ
	fu5Ce1Eh7M1/+Ilh81df6qS1dVPRb6W9EMysL+9jNNOlJB4vPBqP++SlhVBkzm3B
	wHMdXIksYfsh2i+7w0KF+k5xHMVJI+yOvqfXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B12907311;
	Tue, 13 Mar 2012 23:44:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 162C07310; Tue, 13 Mar 2012
 23:44:22 -0400 (EDT)
In-Reply-To: <20120313210357.GC27436@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Mar 2012 17:03:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC762224-6D87-11E1-9EF6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193080>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 12, 2012 at 05:37:57PM -0400, Phil Hord wrote:
>
> This feels so hacky.  One of the callsites does:
>
>     elem->util =3D (void*)((intptr_t)(util_as_int(elem) + 1));
>
> which will truncate the value down to an int before replacing it back=
 in
> the void pointer. And that truncation is ultimately what the compiler=
 is
> warning about, and what we are sneaking around with the extra cast
> (because casting between integer sizes of different types is OK, even
> though it can cause truncation).

Yeah, I find it utterly disgusting that Phil's compiler is picky about
(int)(void *) and insists on (intptr_t)(void *), while totally ignoring
the same bit lossage coming from (int)(intptr_t)(void *).

I am again starting to think that the very original was probably the le=
ast
bad among the yuckies.

As the whole point of the helper macro is to cast the .util field as
"some" integral type, I'm tempted to squash this into the v2 patch I
posted earlier today.  Earlier complaint from Ren=C3=A9 was very sensib=
le that
it looked funny to cast xxx_as_int() explicitly to int, but having to c=
ast
"some" integral value explicitly to int is required in the context of
sprintf() like vararg function, so it would no longer apply to this
version.

 builtin/fmt-merge-msg.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4e7196a..1bc6b8b 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -182,7 +182,7 @@ static void add_branch_desc(struct strbuf *out, con=
st char *name)
 	strbuf_release(&desc);
 }
=20
-#define util_as_int(elem) ((int)(intptr_t)((elem)->util))
+#define util_as_integral(elem) ((intptr_t)((elem)->util))
=20
 static void record_person(int which, struct string_list *people,
 			  struct commit *commit)
@@ -210,13 +210,13 @@ static void record_person(int which, struct strin=
g_list *people,
 		elem =3D string_list_insert(people, name_buf);
 		elem->util =3D (void *)0;
 	}
-	elem->util =3D (void*)((intptr_t)(util_as_int(elem) + 1));
+	elem->util =3D (void*)(util_as_integral(elem) + 1);
 }
=20
-static int cmp_string_list_util_as_int(const void *a_, const void *b_)
+static int cmp_string_list_util_as_integral(const void *a_, const void=
 *b_)
 {
 	const struct string_list_item *a =3D a_, *b =3D b_;
-	return util_as_int(b) - util_as_int(a);
+	return util_as_integral(b) - util_as_integral(a);
 }
=20
 static void add_people_count(struct strbuf *out, struct string_list *p=
eople)
@@ -226,13 +226,13 @@ static void add_people_count(struct strbuf *out, =
struct string_list *people)
 	else if (people->nr =3D=3D 2)
 		strbuf_addf(out, "%s (%d) and %s (%d)",
 			    people->items[0].string,
-			    util_as_int(&people->items[0]),
+			    (int)util_as_integral(&people->items[0]),
 			    people->items[1].string,
-			    util_as_int(&people->items[1]));
+			    (int)util_as_integral(&people->items[1]));
 	else if (people->nr)
 		strbuf_addf(out, "%s (%d) and others",
 			    people->items[0].string,
-			    util_as_int(&people->items[0]));
+			    (int)util_as_integral(&people->items[0]));
 }
=20
 static void credit_people(struct strbuf *out,
@@ -267,11 +267,11 @@ static void add_people_info(struct strbuf *out,
 	if (authors->nr)
 		qsort(authors->items,
 		      authors->nr, sizeof(authors->items[0]),
-		      cmp_string_list_util_as_int);
+		      cmp_string_list_util_as_integral);
 	if (committers->nr)
 		qsort(committers->items,
 		      committers->nr, sizeof(committers->items[0]),
-		      cmp_string_list_util_as_int);
+		      cmp_string_list_util_as_integral);
=20
 	credit_people(out, authors, 'a');
 	credit_people(out, committers, 'c');
