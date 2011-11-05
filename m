From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 04 Nov 2011 21:37:25 -0700
Message-ID: <7vipmz9oca.fsf@alter.siamese.dyndns.org>
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
 <CA+55aFzstE-+NzfSAWMEokB7-rYsZOcZe9Ez-LxPNOKnciJ3UQ@mail.gmail.com>
 <7vlirvbq47.fsf@alter.siamese.dyndns.org>
 <7v39e3bn1n.fsf@alter.siamese.dyndns.org>
 <CA+55aFzKPPqwGOe5Ov0FHF1DHbKmNhm=ePvcaY5uqR7cwFhQGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Sat Nov 05 05:37:34 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RMY0b-0001h8-QB
	for lnx-linux-ide@lo.gmane.org; Sat, 05 Nov 2011 05:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab1KEEh3 (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Sat, 5 Nov 2011 00:37:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab1KEEh2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Nov 2011 00:37:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B43BA2996;
	Sat,  5 Nov 2011 00:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FhyQxc8IVHW99MQOVBUbt64w5wE=; b=EVKTV+
	bhnRZQOPqhUjH4aD6Z4YJM/7Byx/i4nQ4om/6AR36AV1Fu8ktcAsXXF7XqxadYP3
	ZFpwNQVG+Pl4FkvNxtRtX8v5taRZ8fgix7s2i9CcxXArC4bPwF4Cc9YP4BRMakkN
	RjSIHcmhS+msgzxiIzNm9O3n4GNzgvTnP4BOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KN4+/kiXuoVTiQhIdLef6wOZK65R+rW4
	1+3tpzn7Wlr0kXn456u9dQ21tiiHe8e7VwgPDJ2CIGO4W1YSM/ndIJuwRfb4NTiU
	z12U0EBxIEFK6/iZ34uQWbvnzOBttsgq/Qed2RToOUInUPTr4yotFVl9gVYyu4W7
	2rar5KKuMFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A18682995;
	Sat,  5 Nov 2011 00:37:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DCEB2994; Sat,  5 Nov 2011
 00:37:26 -0400 (EDT)
In-Reply-To: <CA+55aFzKPPqwGOe5Ov0FHF1DHbKmNhm=ePvcaY5uqR7cwFhQGQ@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 4 Nov 2011 16:10:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD2407A0-0767-11E1-B6C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184818>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> However - exactly beause git apparently makes it do that "Merge commit
> " message, I suspect we've peeled things too early and too much. We've
> peeled it so early that once again something thinks it's a commit, not
> a tag.

And you are right.

I am working on a larger series that should sit on top of 89587fa (Split
GPG interface into its own helper library, 2011-09-07), which is the first
commit in jc/signed-commit topic.

-- >8 --
Subject: [PATCH] merge: notice local merging of tags and keep it unwrapped

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f61b367..ce3b4f8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -428,6 +428,11 @@ static void merge_name(const char *remote, struct strbuf *msg)
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
+		if (!prefixcmp(found_ref, "refs/tags/")) {
+			strbuf_addf(msg, "%s\t\ttag '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
 		if (!prefixcmp(found_ref, "refs/remotes/")) {
 			strbuf_addf(msg, "%s\t\tremote-tracking branch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
-- 
1.7.8.rc0.108.g71b5ec

