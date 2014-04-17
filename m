From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] extract proper comments for l10n translators
Date: Thu, 17 Apr 2014 11:12:00 -0700
Message-ID: <xmqqfvlbesgf.fsf@gitster.dls.corp.google.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
	<cover.1397712142.git.worldhello.net@gmail.com>
	<CANYiYbGUKiOyoBOPHH+jvdZx1hKoUshh7O0KnpWUQEzbvd8TfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:12:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaqnG-00088X-Gu
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 20:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbaDQSMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 14:12:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaDQSMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 14:12:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD457A9F3;
	Thu, 17 Apr 2014 14:12:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=71nsXDdSxUIqt16LztNd+oiYc90=; b=j39Uah
	Bc9kPz66MOG3ac3SJ0vfACFPxLRwtmadtfkAXLivy/65qnd1PcfcA2dg80z+eWJm
	c3jjnjVA4ihnT0Yzu4KUyxSIfmuNo/mIFa4yOIrnmxs2u7qBd1hRb7YQrmRhg9Yh
	2eVWQq2KUwXypBA5jA5TZQSWITnCz1rrQ5okg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZOtHLuLBYkaVzMWVQFdMScT8aVxpdmIV
	af8xX2M2iAP7BtAQWNswWGwlveSrn1wEaSGkstIjiGE2bXv30hJ8mvQuxbeOB8Kp
	UnF1e2jtOZMDVlZfD74rqMj8XFwHXwsMJkuqy8dzy9Zrr6fQB7xoN3xe8m2rbXOi
	oEDeiMpraCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5CDD7A9F2;
	Thu, 17 Apr 2014 14:12:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC53F7A9E3;
	Thu, 17 Apr 2014 14:12:01 -0400 (EDT)
In-Reply-To: <CANYiYbGUKiOyoBOPHH+jvdZx1hKoUshh7O0KnpWUQEzbvd8TfQ@mail.gmail.com>
	(Jiang Xin's message of "Thu, 17 Apr 2014 13:50:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C60121F6-C65B-11E3-96E5-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246432>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2014-04-17 13:37 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
>> When generate git.pot, many irrelevant comments are extracted as references
>> for translators, but one useful comment is lost.  This series patches will
>> fix this issue.
>
> Brief changes of po/git.pot after applied these patches:

This is a very good way to make sure that 2/3 does not lose helpful
comments.

Thanks, but my complaint regarding the multi-line comment format
still stands.

>
> diff --git a/po/git.pot b/po/git.pot
> index f70b46b..9e474f3 100644
> --- a/po/git.pot
> +++ b/po/git.pot
> @@ -23,10 +23,6 @@ msgstr ""
>  msgid "hint: %.*s\n"
>  msgstr ""
>
> -#.
> -#. * Message used both when 'git commit' fails and when
> -#. * other commands doing a merge do.
> -#.
>  #: advice.c:85
>  msgid ""
>  "Fix them up in the work tree,\n"
> @@ -399,6 +395,7 @@ msgid_plural "%lu years"
>  msgstr[0] ""
>  msgstr[1] ""
>
> +#. TRANSLATORS: "%s" is "<n> years"
>  #: date.c:149
>  #, c-format
>  msgid "%s, %lu month ago"
> @@ -582,8 +579,6 @@ msgstr ""
>  msgid "Removing %s to make room for subdirectory\n"
>  msgstr ""
>
> -#. something else exists
> -#. .. but not some other error (who really cares what?)
>  #: merge-recursive.c:700 merge-recursive.c:721
>  msgid ": perhaps a D/F conflict?"
>  msgstr ""
> @@ -899,11 +894,6 @@ msgstr ""
>  msgid "Pathspec '%s' is in submodule '%.*s'"
>  msgstr ""
>
> -#.
> -#. * We may want to substitute "this command" with a command
> -#. * name. E.g. when add--interactive dies when running
> -#. * "checkout -p"
> -#.
>  #: pathspec.c:353
>  #, c-format
>  msgid "%s: pathspec magic not supported by this command: %s"
> @@ -953,11 +943,6 @@ msgstr ""
>  msgid "%s tracks both %s and %s"
>  msgstr ""
>
> -#.
> -#. * This last possibility doesn't occur because
> -#. * FETCH_HEAD_IGNORE entries always appear at
> -#. * the end of the list.
> -#.
>  #: remote.c:774
>  msgid "Internal error"
>  msgstr ""
> @@ -1306,13 +1291,11 @@ msgstr ""
>  msgid "Could not find section in .gitmodules where path=%s"
>  msgstr ""
>
> -#. Maybe the user already did that, don't error out here
>  #: submodule.c:76
>  #, c-format
>  msgid "Could not update .gitmodules entry %s"
>  msgstr ""
>
> -#. Maybe the user already did that, don't error out here
>  #: submodule.c:109
>  #, c-format
>  msgid "Could not remove .gitmodules entry for %s"
> @@ -1884,7 +1867,6 @@ msgstr ""
>  msgid "add changes from all tracked and untracked files"
>  msgstr ""
>
> -#. takes no arguments
>  #: builtin/add.c:260
>  msgid "ignore paths removed in the working tree (same as --no-all)"
>  msgstr ""
> @@ -2044,7 +2026,6 @@ msgstr ""
>  msgid "corrupt binary patch at line %d: %.*s"
>  msgstr ""
>
> -#. there has to be one hunk (forward hunk)
>  #: builtin/apply.c:1900
>  #, c-format
>  msgid "unrecognized binary patch at line %d"
> @@ -2232,7 +2213,6 @@ msgstr ""
>  msgid "internal error"
>  msgstr ""
>
> -#. Say this even without --verbose
>  #: builtin/apply.c:4043
>  #, c-format
>  msgid "Applying patch %%s with %d reject..."
> @@ -3232,7 +3212,6 @@ msgstr ""
>  msgid " ... and %d more.\n"
>  msgstr ""
>
> -#. The singular version
>  #: builtin/checkout.c:711
>  #, c-format
>  msgid ""
> @@ -3280,7 +3259,6 @@ msgstr ""
>  msgid "invalid reference: %s"
>  msgstr ""
>
> -#. case (1): want a tree
>  #: builtin/checkout.c:1002
>  #, c-format
>  msgid "reference is not a tree: %s"
> @@ -4276,7 +4254,6 @@ msgstr ""
>  msgid "GPG sign commit"
>  msgstr ""
>
> -#. end commit message options
>  #: builtin/commit.c:1508
>  msgid "Commit contents options"
>  msgstr ""
> @@ -5140,7 +5117,6 @@ msgstr ""
>  msgid "See \"git help gc\" for manual housekeeping.\n"
>  msgstr ""
>
> -#. be quiet on --auto
>  #: builtin/gc.c:336
>  #, c-format
>  msgid ""
> @@ -5894,12 +5870,10 @@ msgstr ""
>  msgid "unable to move %s to %s"
>  msgstr ""
>
> -#.
> -#. * TRANSLATORS: The first '%s' is either "Reinitialized
> -#. * existing" or "Initialized empty", the second " shared" or
> -#. * "", and the last '%s%s' is the verbatim directory name.
> -#.
> -#: builtin/init-db.c:420
> +#. TRANSLATORS: The first '%s' is either "Reinitialized
> +#. existing" or "Initialized empty", the second " shared" or
> +#. "", and the last '%s%s' is the verbatim directory name.
> +#: builtin/init-db.c:418
>  #, c-format
>  msgid "%s%s Git repository in %s%s\n"
>  msgstr ""
> @@ -6627,7 +6601,6 @@ msgstr ""
>  msgid "Commit %s has a bad GPG signature allegedly by %s."
>  msgstr ""
>
> -#. 'N'
>  #: builtin/merge.c:1279
>  #, c-format
>  msgid "Commit %s does not have a GPG signature."
> @@ -9593,8 +9566,6 @@ msgstr ""
>  msgid "'git bisect bad' can take only one argument."
>  msgstr ""
>
> -#. have bad but not good.  we could bisect although
> -#. this is less optimum.
>  #: git-bisect.sh:273
>  msgid "Warning: bisecting only with a bad commit."
>  msgstr ""
> @@ -9690,10 +9661,6 @@ msgstr ""
>  msgid "updating an unborn branch with changes added to the index"
>  msgstr ""
>
> -#. The fetch involved updating the current branch.
> -#. The working tree and the index file is still based on the
> -#. $orig_head commit, but we are merging into $curr_head.
> -#. First update the working tree to match $curr_head.
>  #: git-pull.sh:271
>  #, sh-format
>  msgid ""
> @@ -9835,7 +9802,6 @@ msgstr ""
>  msgid "Changes from $mb to $onto:"
>  msgstr ""
>
> -#. Detach HEAD and reset the tree
>  #: git-rebase.sh:609
>  msgid "First, rewinding head to replay your work on top of it..."
>  msgstr ""
> @@ -10218,7 +10184,6 @@ msgstr ""
>  msgid "The --cached option cannot be used with the --files option"
>  msgstr ""
>
> -#. unexpected type
>  #: git-submodule.sh:1097
>  #, sh-format
>  msgid "unexpected mode $mod_dst"
