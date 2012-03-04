From: Junio C Hamano <gitster@pobox.com>
Subject: [git wiki PATCH] Teaching "--3way" to "git apply"
Date: Sun, 04 Mar 2012 15:35:57 -0800
Message-ID: <7vbooc6isi.fsf@alter.siamese.dyndns.org>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:36:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4KyF-000364-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 00:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab2CDXgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 18:36:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756019Ab2CDXgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 18:36:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8D7664AD;
	Sun,  4 Mar 2012 18:35:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JaYuhfXc/J1u0Y6xhvg54I0NUHs=; b=mzRwzA
	7yiRzJRkxCwXovQdD9uVtgXmJqM9xvQQf4ms8ZtIusyo6ZzIPGEK/D0k8ZMqJ6YA
	BnXoJh+xu4mi9Tfb2kb/rkgwlRh+LHoIL6irP41spPB18uVPgesy4HdqjVERjCtA
	4ym/tbbeOTjXzuiWez943dg1YlM5wd1M1LKCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKSM4yYZFsKiEKLQU5nl5fKnmbxvAFzv
	wXR+dm3avNkRc8Dy2nNPaXMii3AjjKN2Y+SdrHL3Iy2hnXsKG5DyddEZvknKrTYa
	jeGZsBLSUoC9EmA3mUjCQfg0gs80J7XkqVutGcQt9IcNwQfzylkVGyc05Oto+0UH
	wPI47VFYEOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE9CB64AC;
	Sun,  4 Mar 2012 18:35:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F87764AA; Sun,  4 Mar 2012
 18:35:59 -0500 (EST)
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 Mar 2012 04:11:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBF05A98-6652-11E1-986C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192184>

I am a bit reluctant to be the one who suggests this, as I do not want to
be in the mentoring business, given that as the maintainer, I am by
definition a large part of the process to grade the success of student
projects.

But I think I should mention this, as it is a reasonable bite-size task
for a student project that is to be completed inside one release cycle.

---
 SoC-2012-Ideas.md |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 17e07e0..aeaacb1 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -263,3 +263,16 @@ This is not as terribly complicated as it looks, because the existing networking
 
 Programming language: C89
 Possible mentor(s): Vicent Marti, Russell Belfer
+
+Teaching "--3way" to "git apply"
+--------------------------------
+
+The "-3" option "git am" understands is useful only when you are
+applying a full format-patch submission. Teaching the three-way
+fallback to underlying "git apply" would make the feature avialable in
+more use cases, and later can help making the implementation of "git
+am -3" simpler.
+
+Programming language: C89
+Suggested by: Junio C Hamano
+Possible mentors: ???
