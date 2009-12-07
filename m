From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-rm doc: Describe how to sync index & work tree
Date: Mon, 07 Dec 2009 13:08:13 -0800
Message-ID: <7vpr6qze4i.fsf@alter.siamese.dyndns.org>
References: <4B1D4AFE.6090708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkor-0003Yl-HW
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 22:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbZLGVIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbZLGVIO
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 16:08:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbZLGVIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 16:08:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDF7786BF8;
	Mon,  7 Dec 2009 16:08:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CnjprZjssMC4JU1wH6CINmqELYo=; b=gm3cwn
	gJIy7QxXOSNmQWcfRHeBu1+MJo6JWSke2ksy7eM7oFjoiKVZx8WRzAsDd4hlKAqz
	KGS+byEQT6uRtlw7KnTUxexQtiBmoT+8ujWrPBR3sjIDwNrcDc3J3JuXuzw6khgV
	WAFnDTqfYb7Yjs4m6siOstFntBF6Q2R64PNAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kcIXVF+n9voBLJvVTX/VwImWTCPZkxgU
	N2KOgHR5FSdWVUqwRyGHkU3trQSZcIxSirCK/5ltZan5YtTVB/587Sp+s5SF9eTh
	d8eYAUTzxHbrnrz383NErb6Bh2uuTjKkh6NW6Wy9M7tE7tqRbQIiSL2oh+tllpnQ
	+yLSECVZBkQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E6686BF7;
	Mon,  7 Dec 2009 16:08:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82D9386BF6; Mon,  7 Dec
 2009 16:08:14 -0500 (EST)
In-Reply-To: <4B1D4AFE.6090708@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Mon\, 07 Dec 2009 19\:35\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A42A2434-E374-11DE-8AC8-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134785>

Looks sensible.

I think mentioning "add -u" in the same section as "commit -a" would be
helpful, as these two are more for user's own development (as opposed to
vendor-code-drop).  I'd perhaps squash something like this in.  Please say
"yes", "don't, it is horrible", or something in between ;-)

--
 Documentation/git-rm.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index c622972..42161d7 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -94,7 +94,8 @@ If you intend that your next commit should record all modifications
 of tracked files in the working tree and record all removals of
 files that have been removed from the working tree with `rm`
 (as opposed to `git rm`), use `git commit -a`, as it will
-automatically notice and record all removals.
+automatically notice and record all removals.  `git add -u`
+can be used for a similar effect without commiting.
 
 Using "git add -A"
 ~~~~~~~~~~~~~~~~~~
