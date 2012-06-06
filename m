From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Wed, 06 Jun 2012 14:11:06 -0700
Message-ID: <7vfwa8kuxh.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120511103122.GA19573@burratino> <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
 <20120606202703.GA13641@burratino> <20120606204659.GA13858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:11:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScNVa-00073C-SV
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 23:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370Ab2FFVLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 17:11:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757630Ab2FFVLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 17:11:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A0C8691;
	Wed,  6 Jun 2012 17:11:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IBGo8toYsObpwjRZNgX7yZ619Kk=; b=EX1QDl
	M7NfvW8d/ua9JUolndg7wbtiHKNVxjM6gE6mf/nRMDAgT/kTM47kxtXT1Bcy2wjs
	P48Ttpgnhyfz2tFzij8v/VWS/Q33KcSXeqPGKhvP/PlSXD+UesmzrxDxB7z5y+Zh
	dUBie62dHAu7/R7anTP78VAvK3ySIBp9Cmag8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VIc1RJ97KPen1p6QeFdsrAJVheO8GpEX
	AnChe4afGVgz/NVY0of3x/Xehr+gpJaBFISG+pVpHzST2zYG1nsFcP5WvEhXQqpq
	rxEgUiU760IoRchkz59XA38ESvrQUuBlEHppbqsJlnrsfoz70L1ShblqFk4r3QGl
	X6X0R1zGV44=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C93208690;
	Wed,  6 Jun 2012 17:11:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D3CB868F; Wed,  6 Jun 2012
 17:11:08 -0400 (EDT)
In-Reply-To: <20120606204659.GA13858@burratino> (Jonathan Nieder's message of
 "Wed, 6 Jun 2012 15:46:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 229A35FE-B01C-11E1-B5B5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199356>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, I think the objection given to the patch upthread was
> a real one, but that a more appropriate fix than using strange spacing
> would be to combine statistics from all branches being merged.

It may be real for _you_ but not for everybody.  Especially, the
current spacing is a lot more logically consistent than your Fred
the Clown example, which *does* use much more strange spacing.

I do not deeply care either way, so let's do this sometime when the
tree is calm (but not today).

 builtin/fmt-merge-msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bf93b04..2c4d435 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -286,10 +286,10 @@ static void credit_people(struct strbuf *out,
 	const char *me;
 
 	if (kind == 'a') {
-		label = "\nBy ";
+		label = "\n# By ";
 		me = git_author_info(IDENT_NO_DATE);
 	} else {
-		label = "\nvia ";
+		label = "\n# Via ";
 		me = git_committer_info(IDENT_NO_DATE);
 	}
 
