From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Thu, 25 Jul 2013 23:07:17 -0700
Message-ID: <7vwqod3ld6.fsf@alter.siamese.dyndns.org>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
	<ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79>
	<20130726043748.GA20286@sigill.intra.peff.net>
	<7v8v0t50kq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 08:07:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2bBc-0002sR-R5
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 08:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab3GZGH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 02:07:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265Ab3GZGH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 02:07:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F21072D58D;
	Fri, 26 Jul 2013 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OA+IcYF0dQq0knxJ8kFR9Ew1oV4=; b=w/gJFt
	pczFJVnLL/q2IvPPaH3Mt8nORxnn8XRkR/GYxJl8TCv3VxXWPupHyyAWp4kTsvfl
	qafuETEr1jqKeeHHhc+0rlc4+07I0cbn82nkmAmS3jauB/zz838+1JwCObVdrXur
	8TRw3ncjCsoBQCy0BpE3E/0XUe4NsziMkqDh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hQfqayiEWh3JKYmaJZLXDNbvPv/ZoMxZ
	8wjOKyOoRi4SmyHGnY0brBmluG6ZpyWN+we0G7znttJJ6SIMBfyVLVSFf8GROHYa
	J6fWR6oRvkUdtjRFRDHVyKwASCNsUjgTmtrKQsySABah1bOsO3A8yPoymG+I4Ue+
	3U1O2k2sCO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA9E2D58C;
	Fri, 26 Jul 2013 06:07:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2528D2D579;
	Fri, 26 Jul 2013 06:07:19 +0000 (UTC)
In-Reply-To: <7v8v0t50kq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Jul 2013 22:53:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0E471F2-F5B9-11E2-A9E9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231167>

Junio C Hamano <gitster@pobox.com> writes:

> Will queue the attached, unless you spot glaring errors made by me,
> coding while drunk ;-)

... aaaaaand, it turns out that I screwed up while running "git
commit --amend" (missed "-a").

I should go to bed now.

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
 Documentation/config.txt | 63 ++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b135be..60c140f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1515,30 +1515,47 @@ http.useragent::
 
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
+
+. Host/domain name (e.g., `example.com` in `https://example.com/`).
+  This field must match exactly between the config key and the URL.
+
+. Port number (e.g., `8080` in `http://example.com:8080/`).
+  This field must match exactly between the config key and the URL.
+  Omitted port numbers are automatically converted to the correct
+  default for the scheme before matching.
+
+. Path (e.g., `repo.git` in `https://example.com/repo.git`). The
+  path field of the config key must match the path field of the URL
+  either exactly or as a prefix of slash-delimited path elements.  This means
+  a config key with path `foo/` matches URL path `foo/bar`.  A prefix can only
+  match on a slash (`/`) boundary.  Longer matches take precedence (so a config
+  key with path `foo/bar` is a better match to URL path `foo/bar` than a config
+  key with just path `foo/`).
+
+. User name (e.g., `user` in `https://user@example.com/repo.git`). If
+  the config key has a user name it must match the user name in the
+  URL exactly. If the config key does not have a user name, that
+  config key will match a URL with any user name (including none).
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
