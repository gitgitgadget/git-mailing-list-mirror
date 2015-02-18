From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 18 Feb 2015 13:54:37 -0800
Message-ID: <xmqqlhju28de.fsf@gitster.dls.corp.google.com>
References: <20150218191417.GA7767@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:54:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOCZy-0006a1-2R
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 22:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbbBRVyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 16:54:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752090AbbBRVyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 16:54:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A142538A2B;
	Wed, 18 Feb 2015 16:54:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z0JGi+UYKLEVs1AM05BHFh0SQiM=; b=Z9R6dK
	OiMHjFTdBlkciZkTf5segvzEbOguXu8QYpUZ1GJqblVYyyO3o2QGF+787VTD5Gdr
	VPvXdBD2pGHVbRYaAiuSsfLg1EnzS8yS8/N5+gx2MxPZuawP4QDRszd2fwFjwkGj
	V7isEfZ3STRW8Xm5lAvUSZYoYG9c0xwmaGNOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x2WRsUhAHnOW+Y/zIYQyfHEspCfUqB7N
	Gb7ALTiNkCuYneK+JUK/uDnKrj+rot38gWraEsYA6ce9HUgn8YdIo+sOAwznKxH4
	WpM2sGTwVYPtGru7sOd5grSh44qLD+8bvLJPsuKranwvqKf9WIUyfRbtO05PAyZg
	qB209yAWbo8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96FBC38A2A;
	Wed, 18 Feb 2015 16:54:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E79B538A27;
	Wed, 18 Feb 2015 16:54:38 -0500 (EST)
In-Reply-To: <20150218191417.GA7767@peff.net> (Jeff King's message of "Wed, 18
	Feb 2015 14:14:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC56645A-B7B8-11E4-A488-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264066>

Jeff King <peff@peff.net> writes:

> and the list of microprojects:
>
>   http://git.github.io/SoC-2015-Microprojects.html

A few for micros.

diff --git a/SoC-2015-Microprojects.md b/SoC-2015-Microprojects.md
index b79a89f..f3b2b55 100644
--- a/SoC-2015-Microprojects.md
+++ b/SoC-2015-Microprojects.md
@@ -107,4 +107,25 @@ suitable.  Just remember to keep the change small!  It is much better
 for you to finish a small but complete change than to try something
 too ambitious and not get it done.
 
-**TODO** add entries
+### Make "git -C '' cmd" not to barf.
+
+Instead, make it just like "cd ''", which is a no-op that silently
+succeeds.  Cf. $gmane/258109
+
+### Allow "-" as a short-hand for "@{-1}" in more places.
+
+Pick one command that operates on branch names.  Teach it the "-"
+shorthand that stands for "the branch we were previously on", like we
+did for "git merge -" sometime after we introduced "git checkout -".
+Cf. $gmane/230828
+
+### Make "git diff --no-index $directory $file" DWIM better.
+
+"git diff --no-index $directory $directory/$file" is obviously what
+the user wanted.
+
+### Forbid "log --graph --no-walk"
+
+Because --graph is about connected history while --no-walk is about
+discrete points.  Cf. $gmane/216083
+
