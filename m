From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Thu, 25 Jul 2013 22:53:25 -0700
Message-ID: <7v8v0t50kq.fsf@alter.siamese.dyndns.org>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
	<ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79>
	<20130726043748.GA20286@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 07:53:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2ay6-00050J-6L
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 07:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab3GZFx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 01:53:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab3GZFx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 01:53:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F6922AFF8;
	Fri, 26 Jul 2013 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u99l2ne2insu9dbaZVZOjo5LLA4=; b=dt/rbi
	U9yuuF34Wwmi5q70NlEKwkCOD0RFXklJoCMr6dxNISbWqm9oyBH08AhyH1MeLydk
	Bry4UaGsVmiVsvmhdaNx1WsEdBm8wJrKtd10wXeNk+QNLN6EbgUg1n0V8Ff3NikV
	0gv7pVkQiMkINGDVCZftEMXeT2WVpVo1xmbDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C/mS7pkrLBBWHUnOaXIBXV0mFmHxL6SM
	H9Aq30vTy6+x5KGUcfz4UB92j0fUyOvgOKyvdF7qTMxczy1UZinWNJLeXg45RXFO
	FlJ8/PPtHwuPn7W1XAVFRMHbUoXuyE4AosI/KZpjoSu7H7q8l//0/t2yqGkwzfdc
	A4SBuBZnYCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A152AFF7;
	Fri, 26 Jul 2013 05:53:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAAD92AFF5;
	Fri, 26 Jul 2013 05:53:26 +0000 (UTC)
In-Reply-To: <20130726043748.GA20286@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 26 Jul 2013 00:37:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0B68D6A-F5B7-11E2-82C3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231165>

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
>
> You should add your S-O-B, too, for your bits.
> ...
> So this patch looks pretty good to me; the two points I raised above are
> how I would have done it, but they are relatively minor if you do not
> agree.

Will queue the attached, unless you spot glaring errors made by me,
coding while drunk ;-)

-- >8 --
From: "Kyle J. McKay" <mackyle@gmail.com>
Date: Thu, 25 Jul 2013 15:39:13 -0700
Subject: [PATCH] docs: update http.<url>.* options documentation

Overhaul the text of the http.<url>.* options documentation
providing a hopefully easier to understand itemized list of matching
behavior as suggested by and including text from Jeff King.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b135be..ec852ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1515,30 +1515,44 @@ http.useragent::
 
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some urls.
-	For example "http.https://example.com.useragent" would set the user
-	agent only for https connections to example.com.  The <url> value
-	matches a url if it refers to the same scheme, host and port and the
-	path portion is an exact match or a prefix that matches at a "/"
-	boundary.  If <url> does not include a user name, it will match a url
-	with any username otherwise the user name must match as well (the
-	password part, if present in the url, is always ignored).  A <url>
-	with longer path matches takes precedence over shorter matches no matter
-	what order they occur in the configuration file.
+	For a config key to match a URL, each element of the config key is
+	compared to that of the URL, in the following order:
 +
-For example, if both "https://user@example.com/path" and
-"https://example.com/path/name" are used as a config <url> value and
-then "https://user@example.com/path/name/here" is passed to a git
-command, the settings in the "https://example.com/path/name" section
-will be preferred because that <url> has a longer path length match than
-"https://user@example.com/path" even though the latter did match the
-user.  For same length matches, the last one wins except that a same
-length <url> match that includes a user name will be preferred over a
-same length <url> match that does not.  The urls are normalized before
-matching so that equivalent urls that are simply spelled differently
-will match properly.  Environment variable settings always override any
-matches.  The urls that are matched against are those given directly to
-git commands.  This means any urls visited as a result of a redirection
-do not participate in matching.
+--
+. Scheme (e.g., `https` in `https://example.com/`). This field
+  must match exactly between the config key and the URL.
+. Host/domain name (e.g., `example.com` in `https://example.com/`).
+  This field must match exactly between the config key and the URL.
+. Port number (e.g., `8080` in `http://example.com:8080/`).
+  This field must match exactly between the config key and the URL.
+  Omitted port numbers are automatically converted to the correct
+  default for the scheme before matching.
+. Path (e.g., `repo.git` in `https://example.com/repo.git`). The
+  path field of the config key must match the path field of the URL
+  either exactly or as a prefix of slash-delimited path elements.  This means
+  a config key with path `foo/` matches URL path `foo/bar`.  A prefix can only
+  match on a slash (`/`) boundary.  Longer matches take precedence (so a config
+  key with path `foo/bar` is a better match to URL path `foo/bar` than a config
+  key with just path `foo/`).
+. Exact user name match (e.g., `user` in `https://user@example.com/repo.git`).
+  If the config key has a user name it must match the user name in the URL
+  exactly.
+. Any user name match.  If a config key does not have a user name, that config
+  key will match a URL with any user name (including none).
+--
++
+The list above is ordered by decreasing precedence; a URL that matches
+a config key's path is preferred to one that matches its user name. For example,
+if the URL is `https://user@example.com/foo/bar` a config key match of
+`https://example.com/foo` will be preferred over a config key match of
+`https://user@example.com`.
++
+All URLs are normalized before attempting any matching (the password part,
+if embedded in the URL, is always ignored for matching purposes) so that
+equivalent urls that are simply spelled differently will match properly.
+Environment variable settings always override any matches.  The urls that are
+matched against are those given directly to Git commands.  This means any URLs
+visited as a result of a redirection do not participate in matching.
 
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
-- 
1.8.4-rc0-117-gda13126
