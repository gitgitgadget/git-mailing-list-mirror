From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 02 Oct 2012 11:34:39 -0700
Message-ID: <7vbogk90zk.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
 <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7Iy-0005X8-RS
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 20:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab2JBSen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 14:34:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897Ab2JBSem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 14:34:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E916C9727;
	Tue,  2 Oct 2012 14:34:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CKoyICK+WYbmArr0bLA6DFHo6xM=; b=mX3Tlq
	bmuRyOb3CeIWB9xBa98+9VWNDRciBNMcfF7fXGSQN6GJd/dapRVIX5lUGm/9Ibzz
	Ku95K14QRn9Bxj5+GENvx4l8Adhmr2CAJ2Qm1LREZEWXAkw59Fh+WTl61rnTCYC0
	PMZE5KhStRiB5E9NHjYTaLl6ATCXZVP5f3qic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h6/ycdr8cDDIj5rlqsR+01bwrmP5Cfwl
	XrWb5oBsMH49JrrwWW/mghtMG4TKxsMxbbBGgeLkqP6EODpqVlvu/TY6rf4IPbxv
	F4Kk5hJEbfZN6yDiOywlf64yUXW62igBxmJ8F0VNi6Czgb4qpikkZkUdy/sB/Pui
	d1Xx8JmkHBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D73EB9726;
	Tue,  2 Oct 2012 14:34:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15AAF9725; Tue,  2 Oct 2012
 14:34:40 -0400 (EDT)
In-Reply-To: <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 2 Oct 2012 21:08:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D414EED2-0CBF-11E2-AC24-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206830>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> David Glasser wrote:
>> Thanks Rankumar! There's also the reference in the "git push origin"
>> example and the "This is the default operation mode if no explicit
>> refspec is found".
>
> Sorry;  here's a revised patch.
>
> --8<--

FYI: the above is not a scissors line.

> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Tue, 2 Oct 2012 21:06:05 +0530
> Subject: [PATCH] Documentation: mention `push.default` in git-push.txt
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-push.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index cb97cc1..e1e9aca 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -37,7 +37,8 @@ OPTIONS[[OPTIONS]]
>         `+`, followed by the source ref <src>, followed
>         by a colon `:`, followed by the destination ref <dst>.
>         It is used to specify with what <src> object the <dst> ref
> -       in the remote repository is to be updated.
> +       in the remote repository is to be updated.  If not specified,
> +       the configuration variable `push.default` is used.

I think this is way suboptimal; it is begging users to do this

	[push]
		default = frotz:xyzzy

by making it sound as if push.default gives a default for <refs>.

> @@ -65,7 +66,8 @@ directs git to push "matching" branches: for every
> branch that
>  the local side, the remote side is updated if a branch of the same name
>  already exists on the remote side.  This is the default operation mode
>  if no explicit refspec is found (that is neither on the command line
> -nor in any Push line of the corresponding remotes file---see below).
> +nor in any Push line of the corresponding remotes file, or `push.default`
> +---see below).

Likewise.  The added part should not be inside the parentheses,
which is about what the value used for refspec.  `push.default` is
about what happens when there is _no_ refspec.

I'll queue this instead.  Thanks.

-- >8 --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Tue, 2 Oct 2012 21:08:00 +0530
Subject: [PATCH] Documentation: mention `push.default` in git-push.txt

It already is listed in the "git config" documentation, but people
interested in pushing would first look at "git push" documentation.

Noticed-by: David Glasser
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Acked-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Fixed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-push.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cb97cc1..70b18bc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -37,7 +37,9 @@ OPTIONS[[OPTIONS]]
 	`+`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
 	It is used to specify with what <src> object the <dst> ref
-	in the remote repository is to be updated.
+	in the remote repository is to be updated.  If not specified,
+	the behavior of the command is controled by the `push.default`
+	configuration variable.
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
@@ -65,7 +67,8 @@ directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.  This is the default operation mode
 if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below).
+nor in any Push line of the corresponding remotes file---see below) and
+no `push.default` configuration variable is set.
 
 --all::
 	Instead of naming each ref to push, specifies that all
@@ -357,7 +360,8 @@ Examples
 	`git push origin :`.
 +
 The default behavior of this command when no <refspec> is given can be
-configured by setting the `push` option of the remote.
+configured by setting the `push` option of the remote, or the `push.default`
+configuration variable.
 +
 For example, to default to pushing only the current branch to `origin`
 use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
-- 
1.8.0.rc0.45.g7ce8dc5
