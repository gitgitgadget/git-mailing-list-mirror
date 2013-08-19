From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Mon, 19 Aug 2013 11:56:17 -0700
Message-ID: <7vzjsdldbi.fsf@alter.siamese.dyndns.org>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
	<520DCB4B.6090309@web.de>
	<20130816130957.GB20138@sigill.intra.peff.net>
	<20130816131406.GC20138@sigill.intra.peff.net>
	<AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
	<0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
	<20130816205246.GA6487@sigill.intra.peff.net>
	<B692A7F2-C5C2-4B5A-8FFC-6CF5C9DB72D8@eyesopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jharrod LaFon <jlafon@eyesopen.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 20:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBUcz-0005LU-NM
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 20:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab3HSS43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 14:56:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122Ab3HSS42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 14:56:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5061C3A422;
	Mon, 19 Aug 2013 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VonpEgV7MYzS5KIn5VsMMa0BG7o=; b=qbSgpG
	EhaqlPp19F/ExkmPIB9n+L/WZOzDU+yRVF69OCyG0+W3NlBFsV+rdUeyIFX+gdGJ
	pr4SV8ybOnu8Rk/fOc7IFpr7bsmB8GKgW3oHKjVqkM9TGD7ojmIC51eZLKxj29wF
	DE8OBpz3yBCL2v8NlEHOCrKnmGRweY0YzumU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sCMilDIw/RiuOScaXuuvT6Exnw3+YbTZ
	B5t4vnNmbl+os0cVVcIEIJhWl22czJQJAUAF+zTMxxGqjodQORF7wNKujuwo0ztr
	qgl3DEpqIxADLlKjtOHrd0cBl3AuYhHNywQCZACVeZClHbu1CBA/RZRUt5K7KDf9
	j5w4qLKDmq0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 588E23A420;
	Mon, 19 Aug 2013 18:56:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EEB03A41B;
	Mon, 19 Aug 2013 18:56:25 +0000 (UTC)
In-Reply-To: <B692A7F2-C5C2-4B5A-8FFC-6CF5C9DB72D8@eyesopen.com> (Jharrod
	LaFon's message of "Mon, 19 Aug 2013 09:26:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C1163A4-0901-11E3-A795-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232558>

Jharrod LaFon <jlafon@eyesopen.com> writes:

> Updated the patch and the patch submission.
>

Getting a lot warmer ;-).

>  -- >8 --
>
> Git segmentation faults if submodule path is empty.

If this is meant to replace the MUA's Subject: line, then please add
"Subject: " prefix, like the example at the end of this message.

Our commit titles by convention omit the final full-stop.

>     Git fails due to a segmentation fault if a submodule path is empty.

Please do not indent the body of the commit log message.  Flush them
to the left.

>     Here is an example .gitmodules that will cause a segmentation fault:

Please have a blank line before an example added for illustration in
the log message.

>     [submodule "foo-module"]
>       path
>       url = http://host/repo.git
>     $ git status
>     Segmentation fault (core dumped)

Indenting such an illustration, and having a blank line after it,
are good things. Please continue doing so.

>     This occurs because in the function parse_submodule_config_option, the

Again, please do not indent the body text of the log message.

>     variable 'value' is assumed to be null, and when passed as an argument
>     to xstrdup a segmentation fault occurs if it is indeed null.
>     This is the case when using the .gitmodules example above.

It is not "assumed to be null", is it?

>     This patch addresses the issue by checking to make sure 'value' is not
>     null before using it as an argument to xstrdup.  For some configuration
>     options, such as fetchRecurseSubmodules, an empty value is valid.  If
>     the option being read is 'path', an empty value is not valid, and so
>     an error message is printed.

We like to write the log message in the imperative mood, as if we
are ordering the codebase to "make it so".

> Signed-off-by: Jharrod LaFon <jlafon <at> eyesopen.com>

Please do not do cute " <at> " here.  With a "Signed-off-by", you
are already agreeing to Developer's Certificate of Origin 1.1,
cluase (d):

	(d) I understand and agree that this project and the contribution
	    are public and that a record of the contribution (including all
	    personal information I submit with it, including my sign-off) is
	    maintained indefinitely and may be redistributed consistent with
	    this project or the open source license(s) involved.

> ---
>  submodule.c                    |    6 ++++++
>  t/t1307-null-submodule-path.sh |   14 ++++++++++++++

Can we have the test not in a brand new test script file, but at the
end of an existing one?

> diff --git a/t/t1307-null-submodule-path.sh b/t/t1307-null-submodule-path.sh
> new file mode 100755
> index 0000000..a4470a8
> --- /dev/null
> +++ b/t/t1307-null-submodule-path.sh
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +
> +test_description='test empty submodule path'
> +. ./test-lib.sh
> +
> +setup() {
> +    echo '[submodule "test"] path' > .gitmodules
> +}

No SP after redirection operator, i.e.

	echo '[submodule "test"] path' >.gitmodules

Also it does not make much sense to have a helper script that is
used only once (for that matter, it does not make much sense to add
a new script file to add a single two-liner test).

Here is to illustrate all the points mentioned above.

-- >8 --
From: Jharrod LaFon <jlafon@eyesopen.com>
Subject: avoid segfault on submodule.*.path set to an empty "true"
Date: Mon, 19 Aug 2013 09:26:56 -0700

Git fails due to a segmentation fault if a submodule path is empty.
Here is an example .gitmodules that will cause a segmentation fault:

    [submodule "foo-module"]
      path
      url = http://host/repo.git
    $ git status
    Segmentation fault (core dumped)

This is because the parsing of "submodule.*.path" is not prepared to
see a value-less "true" and assumes that the value is always
non-NULL (parsing of "ignore" has the same problem).

Fix it by checking the NULL-ness of value and complain with
config_error_nonbool().

Signed-off-by: Jharrod LaFon <jlafon@eyesopen.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c                |  6 ++++++
 t/t7400-submodule-basic.sh | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/submodule.c b/submodule.c
index 3f0a3f9..c0f93c2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 		return 0;
 
 	if (!strcmp(key, "path")) {
+		if (!value)
+			return config_error_nonbool(var);
+
 		config = unsorted_string_list_lookup(&config_name_for_path, value);
 		if (config)
 			free(config->util);
@@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 	} else if (!strcmp(key, "ignore")) {
 		char *name_cstr;
 
+		if (!value)
+			return config_error_nonbool(var);
+
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5ee97b0..a39d074 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -18,6 +18,16 @@ test_expect_success 'setup - initial commit' '
 	git branch initial
 '
 
+test_expect_success 'configuration parsing' '
+	test_when_finished "rm -f .gitmodules" &&
+	cat >.gitmodules <<-\EOF &&
+	[submodule "s"]
+		path
+		ignore
+	EOF
+	test_must_fail git status
+'
+
 test_expect_success 'setup - repository in init subdirectory' '
 	mkdir init &&
 	(
