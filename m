From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-ref: whitespace fix
Date: Thu, 25 Aug 2011 14:48:08 -0700
Message-ID: <7vliuhi2nb.fsf@alter.siamese.dyndns.org>
References: <1314286850-11080-1-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pangyanhan@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 25 23:48:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwhma-00085k-T1
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520Ab1HYVsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:48:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab1HYVsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:48:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC265063;
	Thu, 25 Aug 2011 17:48:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QjhqHpsPi+imVJI46jLznWDV01U=; b=utzI7d
	ElwgDzcteZFdIdAh8TtG54LEpAGL7n4uZWcbK+zWailO3ZYAMG+4TeRa8YI1RfLv
	Uwzqgl/At/Y/czQw0wv7Y2F+OIEXjqju1Cvrw1XhZBQUVSDzLDz2fme8hNaNZKkx
	G2mlQZAR1FGf9FvkrBLDb363YkoEuw+87CQ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKzm414VFkcLGXT0vHf46F51cxHAxcPW
	yUig6eyAVPeDY1S5uOXpIgr67Z8eN4tpgxz1AMv9pumimVHF8qvWy3OtTdwDCQQH
	EURJk6ZwDfCbDqq5Owx0Is9V+aH6PkwwNB1ia+m9VL0uA0HyCSm/HILvizE1PtEf
	S0fmYNMIBEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420285062;
	Thu, 25 Aug 2011 17:48:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B01975061; Thu, 25 Aug 2011
 17:48:09 -0400 (EDT)
In-Reply-To: <1314286850-11080-1-git-send-email-pangyanhan@gmail.com>
 (pangyanhan@gmail.com's message of "Thu, 25 Aug 2011 23:40:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC7B2206-CF63-11E0-9D8D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180124>

pangyanhan@gmail.com writes:

> From: Pang Yan Han <pangyanhan@gmail.com>
>
> Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
> ---
>  builtin/update-ref.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 76ba1d5..835c62a 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -11,7 +11,7 @@ static const char * const git_update_ref_usage[] = {
>  
>  int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  {
> -	const char *refname, *oldval, *msg=NULL;
> +	const char *refname, *oldval, *msg = NULL;

Heh, thanks. There are some more.

-- >8 --
Subject: [PATCH] whitespace: have SP on both sides of an assignment "="

I've deliberately excluded the borrowed code in compat/nedmalloc
directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/remote.c |    2 +-
 commit.c         |    2 +-
 http-push.c      |    2 +-
 read-cache.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9ff1cac..1fb441c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1113,7 +1113,7 @@ static int show(int argc, const char **argv)
 			url = states.remote->url;
 			url_nr = states.remote->url_nr;
 		}
-		for (i=0; i < url_nr; i++)
+		for (i = 0; i < url_nr; i++)
 			printf("  Push  URL: %s\n", url[i]);
 		if (!i)
 			printf("  Push  URL: %s\n", "(no URL)");
diff --git a/commit.c b/commit.c
index ac337c7..913dbab 100644
--- a/commit.c
+++ b/commit.c
@@ -515,7 +515,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 
 		commit = work_item->item;
 		for (parents = commit->parents; parents ; parents = parents->next) {
-			struct commit *parent=parents->item;
+			struct commit *parent = parents->item;
 
 			if (!parent->indegree)
 				continue;
diff --git a/http-push.c b/http-push.c
index 6e8f6d0..376331a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1655,7 +1655,7 @@ static int delete_remote_branch(const char *pattern, int force)
 		return error("Remote HEAD is not a symref");
 
 	/* Remote branch must not be the remote HEAD */
-	for (i=0; symref && i<MAXDEPTH; i++) {
+	for (i = 0; symref && i < MAXDEPTH; i++) {
 		if (!strcmp(remote_ref->name, symref))
 			return error("Remote branch %s is the current HEAD",
 				     remote_ref->name);
diff --git a/read-cache.c b/read-cache.c
index 4ac9a03..0a64103 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1087,7 +1087,7 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 {
 	if (in_porcelain && *first && header_msg) {
 		printf("%s\n", header_msg);
-		*first=0;
+		*first = 0;
 	}
 	printf(fmt, name);
 }
-- 
1.7.6.1.385.gb7fcd0
