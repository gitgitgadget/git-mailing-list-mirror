From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Docs: Clarify the --tags option of `git fetch'
Date: Thu, 22 Sep 2011 10:10:54 -0700
Message-ID: <7v1uv8zen5.fsf@alter.siamese.dyndns.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
 <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
 <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
 <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
 <7vfwjpyzds.fsf@alter.siamese.dyndns.org>
 <686c38876d5a4ad6bfac67ca77fe9bb3-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:11:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6mnf-0003Xk-I6
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684Ab1IVRK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 13:10:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab1IVRK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 13:10:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A411764E0;
	Thu, 22 Sep 2011 13:10:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jaTOu/hPuo7m/qmxzup41lIq7YE=; b=NZ5WM0
	jEDNbpSRSaMw43XYoP5iWSVjR2p7E/IA1CfXTi6pGTjpznPI0PBlwfUVI9tke1Wl
	qblxEZ88DjjepQvlX+eHpoEg8b2CcmmeBkEKuArRAWo5petgdnp3CuVzzaRb+yU2
	I+R14LaE2qJolg89iSYWy38262ZTx1HnFkDTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AOdrPOWuPGIHy9Juo8JXVs8gmx2kTn8S
	cXm1NTrHgoYU0+krXKOsTDuy5+1Gp39+/iuwf8awMmWtLyLE7jBF7YC45nOzCqXB
	zJHBdiXLQR0SHCLLqmvSj+4qGLYc64GD7BS9+AbyGWnR9cQTjFH4j7LI2x2FyfnC
	zIGoq/CNXIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AC8C64DF;
	Thu, 22 Sep 2011 13:10:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0946E64DE; Thu, 22 Sep 2011
 13:10:55 -0400 (EDT)
In-Reply-To: <686c38876d5a4ad6bfac67ca77fe9bb3-mfwitten@gmail.com> (Michael
 Witten's message of "Thu, 22 Sep 2011 07:23:55 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D59FF58A-E53D-11E0-9A24-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181900>

Michael Witten <mfwitten@gmail.com> writes:

> 8<-----------8<-----------8<-----------8<-----------8<-----------8<-----------
>
> See the discussion starting here:
>
>   [PATCH] Clarify that '--tags' fetches tags only
>   Message-ID: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
>   http://thread.gmane.org/gmane.comp.version-control.git/180636

It is a good practice to point to earlier discussions while polishing
patch, and it also is good to include pointers in the commit log message
as a supporting material (additional reading), but that is _NOT_ a
substitute for a properly written commit log message. You need to state
what problem you are trying to fix and how the proposed patch fixes it.

>  Documentation/fetch-options.txt |   31 +++++++++++++++++++++++--------
>  1 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 39d326a..4cc5a80 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -56,14 +56,29 @@ endif::git-pull[]
>  ifndef::git-pull[]
>  -t::
>  --tags::
> -	Most of the tags are fetched automatically as branch
> -	heads are downloaded, but tags that do not point at
> -	objects reachable from the branch heads that are being
> -	tracked will not be fetched by this mechanism.  This
> -	flag lets all tags and their associated objects be
> -	downloaded. The default behavior for a remote may be
> -	specified with the remote.<name>.tagopt setting. See
> -	linkgit:git-config[1].
> +	Most of a remote's tags are fetched automatically as branches are
> +	downloaded. However, git does not automatically fetch any tag that,
> +	when 'git fetch' completes, would not be reachable from any local
> +	branch head.  This option tells git to fetch all tags (and their
> +	associated objects).

I would suggest clarifying the beginning of "git fetch --help" like the
attached patch. With that knowledge at hand, the readers do not need the
fuzzy "Most of ... are fetched" (leaving them wondering "what about the
rest, and how that Most is determined?"); we only need to say something
like "fetch all the tags from the remote and store them locally".

 Documentation/git-fetch.txt |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 60ac8d2..c6c7236 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -19,20 +19,19 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Fetches named heads or tags from one or more other repositories,
-along with the objects necessary to complete them.
+Fetches branches and tags (collectively known as 'refs') from one or more
+other repositories, along with the objects necessary to complete them.
+Which refs are fetched are determined by the <refspec> arguments, if
+given. Otherwise the default <refspec> configured for the <repository>
+are used (see "REMOTES" section below for how <refspec> works).
 
-The ref names and their object names of fetched refs are stored
-in `.git/FETCH_HEAD`.  This information is left for a later merge
-operation done by 'git merge'.
+The ref names and their object names are also stored in `.git/FETCH_HEAD`.
+This information is used by 'git pull' that invokes this command.
 
 When <refspec> stores the fetched result in remote-tracking branches,
-the tags that point at these branches are automatically
-followed.  This is done by first fetching from the remote using
-the given <refspec>s, and if the repository has objects that are
-pointed by remote tags that it does not yet have, then fetch
-those missing tags.  If the other end has tags that point at
-branches you are not interested in, you will not get them.
+the tags that point at commits on these branches are also fetched. Tags
+at the remote that point at commits that are not on these remote-tracking 
+branches are not fetched by this mechanism (use `--tags` option to fetch them).
 
 'git fetch' can fetch from either a single named repository,
 or from several repositories at once if <group> is given and
