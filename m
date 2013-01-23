From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever the whole system
 is referred to #2
Date: Tue, 22 Jan 2013 16:53:40 -0800
Message-ID: <7va9s0lnxn.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 01:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxobR-0004VY-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 01:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab3AWAxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 19:53:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab3AWAxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 19:53:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56426B103;
	Tue, 22 Jan 2013 19:53:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p7bVt8uyhwEBaImJckB88S89kYM=; b=aZ9fwE
	8QYoLrUhkD9sBpWUwyCbvTfeRnkKnbm1BKxO+e+M7QSZc6jVrv5Dt+NBo5lJYOms
	EuuVeksgqeK9OpKe+minTiSg1dEMQRdGwpEqwjId18TlGuUqUMKfCsVYY5jzsqaq
	IbxaBfSSX0JUNftDK41RmgMkRvEP8ZPuYZJy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r1K4RNFNgzbCzyeDZvQM43H7e7LD02Dm
	7Vkb/N7E9n9UX3Sp1ymVUUxvvW0btNkwENHJ2CTI0Ii/9ZjcFptAH9BgcwaL1UQY
	ACFoXnATnIJaW71fro/vCelVQLJzt63b9TVaDs3MrGy3ARIorX7/2LN4USE7XTkD
	Q+kHgMe2cuM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A773B101;
	Tue, 22 Jan 2013 19:53:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84E1DB100; Tue, 22 Jan 2013
 19:53:41 -0500 (EST)
In-Reply-To: <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 21 Jan 2013 20:19:40 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54B711C0-64F7-11E2-B6C5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214268>

Thomas Ackermann <th.acker@arcor.de> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b87f744..5a831ad2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1,14 +1,14 @@
>  CONFIGURATION FILE
>  ------------------
>  
> -The git configuration file contains a number of variables that affect
> +The Git configuration file contains a number of variables that affect
>  the git command's behavior. The `.git/config` file in each repository

I am torn on this one, in the sense that there are configuration
variables that changes the behaviour of 'git' wrapper itself, but
this explanation is talking more about all the 161 subcommands (no,
I am just kidding and didn't count) in the Git suite in general, so
I think s/git/Git/ is probably more appropriate.

> @@ -1039,7 +1039,7 @@ format.subjectprefix::
>  
>  format.signature::
>  	The default for format-patch is to output a signature containing
> -	the git version number. Use this variable to change that default.
> +	the Git version number. Use this variable to change that default.
>  	Set this variable to the empty string ("") to suppress
>  	signature generation.

Before this hunk, fetch.unpackLimit has this:

	If the number of objects fetched over the git native
	transfer is below...

s/git/Git/ is needed, I think.


> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> index 6d696e0..e18c3b0 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -45,9 +45,9 @@ argument specifies a URL; it is usually of the form
>  '<transport>://<address>', but any arbitrary string is possible.
>  The 'GIT_DIR' environment variable is set up for the remote helper
>  and can be used to determine where to store additional data or from
> -which directory to invoke auxiliary git commands.
> +which directory to invoke auxiliary Git commands.

The paragraph begins with this:

 Remote helper programs are invoked with one or (optionally) two
 arguments. The first argument specifies a remote repository as in git;

s/git/Git/ is needed, I think.


> diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
> index cd23076..d4ae05b 100644
> --- a/Documentation/git-verify-pack.txt
> +++ b/Documentation/git-verify-pack.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Reads given idx file for packed git archive created with the
> +Reads given idx file for packed Git archive created with the
>  'git pack-objects' command and verifies idx file and the
>  corresponding pack file.

The NAME section lists it as "Validate packed git archive files",
which wants a s/git/Git/, I think.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 2698f63..b9c0eec 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -417,11 +417,11 @@ Generating diff text
>  `diff`
>  ^^^^^^
>  
> -The attribute `diff` affects how 'git' generates diffs for particular
> -files. It can tell git whether to generate a textual patch for the path
> +The attribute `diff` affects how Git generates diffs for particular
> +files. It can tell Git whether to generate a textual patch for the path
>  or to treat the path as a binary file.  It can also affect what line is
> -shown on the hunk header `@@ -k,l +n,m @@` line, tell git to use an
> -external command to generate the diff, or ask git to convert binary
> +shown on the hunk header `@@ -k,l +n,m @@` line, tell Git to use an
> +external command to generate the diff, or ask Git to convert binary
>  files to a text format before generating the diff.
>  
>  Set::

After this hunk, the description of "String" type says this:

	... are defined by the configuration variables in the
        "diff.foo" section of the git config file.

s/git/Git/ is needed, I think.


> @@ -650,7 +650,7 @@ advantages to choosing this method:
>     odt2txt).
>  
>  2. Git diff features. By performing only the transformation step
> -   yourself, you can still utilize many of git's diff features,
> +   yourself, you can still utilize many of Git's diff features,
>     including colorization, word-diff, and combined diffs for merges.
>  
>  3. Caching. Textconv caching can speed up repeated diffs, such as those

After this hunk, in "Marking file as binary" section, you have

	This will cause git to generate `Binary files differ`...

s/git/Git/ is needed, I think.

As before, I'll locally create a fixup commit based on the above.

After I am done with these patches, somebody (not Thomas or I, as
our eyes are too used to staring at git and Git to notice mistakes)
has to run "git grep -C3 -e '\<Git\>' Documentation/" and eyeball
the output to spot mistakes that should have been "git" but was
converted to "Git", as I am mostly concentrating on finding "git"
that should have been converted in Thomas's series.

Thanks.
