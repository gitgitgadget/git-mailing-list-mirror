From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] Add treap implementation
Date: Thu, 12 Aug 2010 17:02:57 -0500
Message-ID: <20100812220257.GI2029@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100809221734.GE4203@burratino>
 <7vhbizu4nq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:04:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjftM-00077x-5k
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab0HLWEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:04:37 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54563 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab0HLWEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 18:04:36 -0400
Received: by qwh6 with SMTP id 6so2014365qwh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=F5g3NKmuQCLRlgy7Ku4gGy+HSYOkLvVXXvhC/VyZcuo=;
        b=Z1F0+saWu1pGO+OlCZzA6JuBTxBTNOtmSR5GJjpgJ4tw7hp/q3dQklXuYSpN7HmJOf
         HYQ3XC9WAwLEP/S8rbfEqOvHmpljxFERLggpkCkscbN9hBU6XM2liaB8vmmDDJ9hdeY1
         KeQsLHAfONyoTwlymsYh8RvQECLaoV1Op2iU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FNBjVq8Ld6PZjMAYZMkDgcBxxT2Cxb78TRggQ1iDaWtqS1DZUpmg8MXp/4CSdQoEhz
         SM/tUM0vl/f1Dj1kDeBn7/aePNEEZAV7y5ASky+zV4EQSc0OqKywXxErgSxawJqZUZVT
         q6gKq0XkCzCkNhFfv5kCodB8bVFa8CUV/ngGY=
Received: by 10.224.28.77 with SMTP id l13mr398710qac.320.1281650675472;
        Thu, 12 Aug 2010 15:04:35 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id e1sm807206vch.20.2010.08.12.15.04.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 15:04:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbizu4nq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153425>

Junio C Hamano wrote:

> Need SP after "while" (there are other occurrences).

Good catch.  checkpatch also notices some long lines, but I think
that=E2=80=99s worth ignoring.

-- 8< --
Subject: treap: style fix

Missing spaces in while (0) and trpn_pointer(a, b).

Remove parentheses around return value.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/trp.h |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
index 1f5f51f..ee35c68 100644
--- a/vcs-svn/trp.h
+++ b/vcs-svn/trp.h
@@ -37,7 +37,7 @@ struct trp_root {
 			*trpn_pointer(a_base, a_offset) =3D \
 				*trpn_pointer(a_base, old_offset); \
 		} \
-	} while (0);
+	} while (0)
=20
 /* Left accessors. */
 #define trp_left_get(a_base, a_field, a_node) \
@@ -46,7 +46,7 @@ struct trp_root {
 	do { \
 		trpn_modify(a_base, a_node); \
 		trp_left_get(a_base, a_field, a_node) =3D (a_left); \
-	} while(0)
+	} while (0)
=20
 /* Right accessors. */
 #define trp_right_get(a_base, a_field, a_node) \
@@ -55,7 +55,7 @@ struct trp_root {
 	do { \
 		trpn_modify(a_base, a_node); \
 		trp_right_get(a_base, a_field, a_node) =3D (a_right); \
-	} while(0)
+	} while (0)
=20
 /*
  * Fibonacci hash function.
@@ -72,7 +72,7 @@ struct trp_root {
 	do { \
 		trp_left_set(a_base, a_field, (a_node), ~0); \
 		trp_right_set(a_base, a_field, (a_node), ~0); \
-	} while(0)
+	} while (0)
=20
 /* Internal utility macros. */
 #define trpn_first(a_base, a_field, a_root, r_node) \
@@ -90,7 +90,7 @@ struct trp_root {
 		trp_right_set(a_base, a_field, (a_node), \
 			trp_left_get(a_base, a_field, (r_node))); \
 		trp_left_set(a_base, a_field, (r_node), (a_node)); \
-	} while(0)
+	} while (0)
=20
 #define trpn_rotate_right(a_base, a_field, a_node, r_node) \
 	do { \
@@ -98,7 +98,7 @@ struct trp_root {
 		trp_left_set(a_base, a_field, (a_node), \
 			trp_right_get(a_base, a_field, (r_node))); \
 		trp_right_set(a_base, a_field, (r_node), (a_node)); \
-	} while(0)
+	} while (0)
=20
 #define trp_gen(a_attr, a_pre, a_type, a_field, a_base, a_cmp) \
 a_attr a_type MAYBE_UNUSED *a_pre##first(struct trp_root *treap) \
@@ -136,7 +136,7 @@ a_attr a_type MAYBE_UNUSED *a_pre##search(struct tr=
p_root *treap, a_type *key) \
 { \
 	int cmp; \
 	uint32_t ret =3D treap->trp_root; \
-	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base,ret)))) { \
+	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base, ret)))) { \
 		if (cmp < 0) { \
 			ret =3D trp_left_get(a_base, a_field, ret); \
 		} else { \
@@ -149,7 +149,7 @@ a_attr a_type MAYBE_UNUSED *a_pre##nsearch(struct t=
rp_root *treap, a_type *key)
 { \
 	int cmp; \
 	uint32_t ret =3D treap->trp_root; \
-	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base,ret)))) { \
+	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base, ret)))) { \
 		if (cmp < 0) { \
 			if (!~trp_left_get(a_base, a_field, ret)) \
 				break; \
@@ -163,7 +163,7 @@ a_attr a_type MAYBE_UNUSED *a_pre##nsearch(struct t=
rp_root *treap, a_type *key)
 a_attr uint32_t MAYBE_UNUSED a_pre##insert_recurse(uint32_t cur_node, =
uint32_t ins_node) \
 { \
 	if (cur_node =3D=3D ~0) { \
-		return (ins_node); \
+		return ins_node; \
 	} else { \
 		uint32_t ret; \
 		int cmp =3D (a_cmp)(trpn_pointer(a_base, ins_node), \
@@ -185,7 +185,7 @@ a_attr uint32_t MAYBE_UNUSED a_pre##insert_recurse(=
uint32_t cur_node, uint32_t i
 			else \
 				ret =3D cur_node; \
 		} \
-		return (ret); \
+		return ret; \
 	} \
 } \
 a_attr void MAYBE_UNUSED a_pre##insert(struct trp_root *treap, a_type =
*node) \
@@ -204,27 +204,27 @@ a_attr uint32_t MAYBE_UNUSED a_pre##remove_recurs=
e(uint32_t cur_node, uint32_t r
 		uint32_t right =3D trp_right_get(a_base, a_field, cur_node); \
 		if (left =3D=3D ~0) { \
 			if (right =3D=3D ~0) \
-				return (~0); \
+				return ~0; \
 		} else if (right =3D=3D ~0 || trp_prio_get(left) < trp_prio_get(righ=
t)) { \
 			trpn_rotate_right(a_base, a_field, cur_node, ret); \
 			right =3D a_pre##remove_recurse(cur_node, rem_node); \
 			trp_right_set(a_base, a_field, ret, right); \
-			return (ret); \
+			return ret; \
 		} \
 		trpn_rotate_left(a_base, a_field, cur_node, ret); \
 		left =3D a_pre##remove_recurse(cur_node, rem_node); \
 		trp_left_set(a_base, a_field, ret, left); \
-		return (ret); \
+		return ret; \
 	} else if (cmp < 0) { \
 		uint32_t left =3D a_pre##remove_recurse( \
 			trp_left_get(a_base, a_field, cur_node), rem_node); \
 		trp_left_set(a_base, a_field, cur_node, left); \
-		return (cur_node); \
+		return cur_node; \
 	} else { \
 		uint32_t right =3D a_pre##remove_recurse( \
 			trp_right_get(a_base, a_field, cur_node), rem_node); \
 		trp_right_set(a_base, a_field, cur_node, right); \
-		return (cur_node); \
+		return cur_node; \
 	} \
 } \
 a_attr void MAYBE_UNUSED a_pre##remove(struct trp_root *treap, a_type =
*node) \
--=20
1.7.2.1.544.ga752d.dirty
