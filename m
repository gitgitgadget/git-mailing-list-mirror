From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9164: More style fixes
Date: Fri, 31 Aug 2012 11:01:09 -0700
Message-ID: <7vipbzndp6.fsf@alter.siamese.dyndns.org>
References: <20120826003430.GA32346@dcvr.yhbt.net>
 <1346394580-12083-1-git-send-email-robert@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 20:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7VX3-00031g-MC
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 20:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab2HaSBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 14:01:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754350Ab2HaSBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 14:01:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AB479898;
	Fri, 31 Aug 2012 14:01:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fa+xphJuQKLB0DTASVYoyXfh6IU=; b=a/grUF
	ep2l/7KmRlOMR2A2ou+D2n6Bfa6YRINqhUP/dn4RNL1Osv1SlXnTdbIwSD/OMzE8
	OC06G/JXWB9X8mYPiDQCT+tEDpWtblG9tDn0L5A9GQz8aOTkozacOkjRoMrIpu9F
	9Ppmyxx6DOFfg/eAdA9FiXjQ7wKsYIlOGuIqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sZLS1wbO9y8XtV9RaQZU/ZS9lktE1X31
	frLF2oLo1qeLwRUfttxDgXUj6CmWodcG6BFbqZVLxeGT0ytYvmf/IIqa5TdJ0rK2
	UGQ5eE9pRw7Dhh1VK31tbtuBAFqs/adKtxXPkrlBuUulgFTNbuOn21nLIhR53jz3
	SuOebs2frhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C279897;
	Fri, 31 Aug 2012 14:01:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A8099892; Fri, 31 Aug 2012
 14:01:10 -0400 (EDT)
In-Reply-To: <1346394580-12083-1-git-send-email-robert@debian.org> (Robert
 Luberda's message of "Fri, 31 Aug 2012 08:29:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D87FB986-F395-11E1-B3E4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204599>

Robert Luberda <robert@debian.org> writes:

> Make sure t9164 conforms with the coding guidelines:
>  - remove spaces after redirection operators;
>  - insert spaces between function names and parentheses;
>  - split `if ...; then' lines;
>  - use `test' instead of `['.
>
> Signed-off-by: Robert Luberda <robert@debian.org>
> ---
>  t/t9164-git-svn-dcommit-concurrent.sh |   69 ++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 36 deletions(-)

Interesting.

$ git log --oneline --stat -1 -- 't/t9164-*'
e48fb75 git svn: handle errors and concurrent commits in dcommit
 t/t9164-git-svn-dcommit-concrrent.sh | 216 +++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

I wonder where the typo in filename came from (notice the missing "u")?

Perhaps the "More" in your subject implies there were some earlier
patches I haven't seen?  The patch does not seem to apply to my tree
even with the target file renamed.

> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> index d8464d4..d75ebdc 100755
> --- a/t/t9164-git-svn-dcommit-concurrent.sh
> +++ b/t/t9164-git-svn-dcommit-concurrent.sh
> @@ -12,16 +12,15 @@ test_expect_success 'setup svn repository' '
>  	svn_cmd checkout "$svnrepo" work.svn &&
>  	(
>  		cd work.svn &&
> -		echo >file && echo > auto_updated_file
> +		echo >file && echo >auto_updated_file
>  		svn_cmd add file auto_updated_file &&
>  		svn_cmd commit -m "initial commit"
>  	) &&
>  	svn_cmd checkout "$svnrepo" work-auto-commits.svn
>  '
>  N=0
> -next_N()
> -{
> -	N=$(( $N + 1 ))
> +next_N () {
> +	N=$(($N + 1))
>  }
>  
>  # Setup SVN repository hooks to emulate SVN failures or concurrent commits
> @@ -35,39 +34,39 @@ next_N()
>  # the hook should be applied for (each time the hook is run, the given
>  # number is decreased by one until it gets 0, in which case the hook
>  # will execute its real action)
> -setup_hook()
> -{
> +setup_hook () {
>  	hook_type="$1"  # "pre-commit" or "post-commit"
>  	skip_revs="$2"
> -	[ "$hook_type" = "pre-commit" ] ||
> -		[ "$hook_type" = "post-commit" ] ||
> +	test "$hook_type" = "pre-commit"  ||
> +		test "$hook_type" = "post-commit"  ||
>  		{ echo "ERROR: invalid argument ($hook_type)" \
>  			"passed to setup_hook" >&2 ; return 1; }
> -	echo "cnt=$skip_revs" > "$hook_type-counter"
> +	echo "cnt=$skip_revs" >"$hook_type-counter"
>  	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
>  	hook="$rawsvnrepo/hooks/$hook_type"
> -	cat > "$hook" <<- 'EOF1'
> +	cat >"$hook" <<-'EOF1'
>  		#!/bin/sh
>  		set -e
>  		cd "$1/.."  # "$1" is repository location
> -		exec >> svn-hook.log 2>&1
> +		exec >>svn-hook.log 2>&1
>  		hook="$(basename "$0")"
>  		echo "*** Executing $hook $@"
>  		set -x
> -		. ./$hook-counter
> +		. "./$hook-counter"
>  		cnt="$(($cnt - 1))"
> -		echo "cnt=$cnt" > ./$hook-counter
> -		[ "$cnt" = "0" ] || exit 0
> +		echo "cnt=$cnt" >"./$hook-counter"
> +		test "$cnt" = "0" || exit 0
>  EOF1
> -	if [ "$hook_type" = "pre-commit" ]; then
> +	if test "$hook_type" = "pre-commit"
> +	then
>  		echo "echo 'commit disallowed' >&2; exit 1" >>"$hook"
>  	else
>  		echo "PATH=\"$PATH\"; export PATH" >>"$hook"
>  		echo "svnconf=\"$svnconf\"" >>"$hook"
> -		cat >>"$hook" <<- 'EOF2'
> +		cat >>"$hook" <<-'EOF2'
>  			cd work-auto-commits.svn
>  			svn up --config-dir "$svnconf"
> -			echo "$$" >> auto_updated_file
> +			echo "$$" >>auto_updated_file
>  			svn commit --config-dir "$svnconf" \
>  				-m "auto-committing concurrent change"
>  			exit 0
> @@ -76,8 +75,7 @@ EOF2
>  	chmod 755 "$hook"
>  }
>  
> -check_contents()
> -{
> +check_contents () {
>  	gitdir="$1"
>  	(cd ../work.svn && svn_cmd up) &&
>  	test_cmp file ../work.svn/file &&
> @@ -89,7 +87,7 @@ test_expect_success 'check if post-commit hook creates a concurrent commit' '
>  	(
>  		cd work.svn &&
>  		cp auto_updated_file au_file_saved &&
> -		echo 1 >> file &&
> +		echo 1 >>file &&
>  		svn_cmd commit -m "changing file" &&
>  		svn_cmd up &&
>  		test_must_fail test_cmp auto_updated_file au_file_saved
> @@ -100,9 +98,9 @@ test_expect_success 'check if pre-commit hook fails' '
>  	setup_hook pre-commit 2 &&
>  	(
>  		cd work.svn &&
> -		echo 2 >> file &&
> +		echo 2 >>file &&
>  		svn_cmd commit -m "changing file once again" &&
> -		echo 3 >> file &&
> +		echo 3 >>file &&
>  		test_must_fail svn_cmd commit -m "this commit should fail" &&
>  		svn_cmd revert file
>  	)
> @@ -113,9 +111,9 @@ test_expect_success 'dcommit error handling' '
>  	next_N && git svn clone "$svnrepo" work$N.git &&
>  	(
>  		cd work$N.git &&
> -		echo 1 >> file && git commit -am "commit change $N.1" &&
> -		echo 2 >> file && git commit -am "commit change $N.2" &&
> -		echo 3 >> file && git commit -am "commit change $N.3" &&
> +		echo 1 >>file && git commit -am "commit change $N.1" &&
> +		echo 2 >>file && git commit -am "commit change $N.2" &&
> +		echo 3 >>file && git commit -am "commit change $N.3" &&
>  		# should fail to dcommit 2nd and 3rd change
>  		# but still should leave the repository in reasonable state
>  		test_must_fail git svn dcommit &&
> @@ -131,9 +129,9 @@ test_expect_success 'dcommit concurrent change in non-changed file' '
>  	next_N && git svn clone "$svnrepo" work$N.git &&
>  	(
>  		cd work$N.git &&
> -		echo 1 >> file && git commit -am "commit change $N.1" &&
> -		echo 2 >> file && git commit -am "commit change $N.2" &&
> -		echo 3 >> file && git commit -am "commit change $N.3" &&
> +		echo 1 >>file && git commit -am "commit change $N.1" &&
> +		echo 2 >>file && git commit -am "commit change $N.2" &&
> +		echo 3 >>file && git commit -am "commit change $N.3" &&
>  		# should rebase and leave the repository in reasonable state
>  		git svn dcommit &&
>  		git update-index --refresh &&
> @@ -146,10 +144,9 @@ test_expect_success 'dcommit concurrent change in non-changed file' '
>  '
>  
>  # An utility function used in the following test
> -delete_first_line()
> -{
> +delete_first_line () {
>  	file="$1" &&
> -	sed 1d < "$file" > "${file}.tmp" &&
> +	sed 1d <"$file" >"${file}.tmp" &&
>  	rm "$file" &&
>  	mv "${file}.tmp" "$file"
>  }
> @@ -159,7 +156,7 @@ test_expect_success 'dcommit concurrent non-conflicting change' '
>  	next_N && git svn clone "$svnrepo" work$N.git &&
>  	(
>  		cd work$N.git &&
> -		cat file >> auto_updated_file &&
> +		cat file >>auto_updated_file &&
>  			git commit -am "commit change $N.1" &&
>  		delete_first_line auto_updated_file &&
>  			git commit -am "commit change $N.2" &&
> @@ -181,7 +178,7 @@ test_expect_success 'dcommit --no-rebase concurrent non-conflicting change' '
>  	next_N && git svn clone "$svnrepo" work$N.git &&
>  	(
>  		cd work$N.git &&
> -		cat file >> auto_updated_file &&
> +		cat file >>auto_updated_file &&
>  			git commit -am "commit change $N.1" &&
>  		delete_first_line auto_updated_file &&
>  			git commit -am "commit change $N.2" &&
> @@ -202,11 +199,11 @@ test_expect_success 'dcommit fails on concurrent conflicting change' '
>  	next_N && git svn clone "$svnrepo" work$N.git &&
>  	(
>  		cd work$N.git &&
> -		echo a >> file &&
> +		echo a >>file &&
>  			git commit -am "commit change $N.1" &&
> -		echo b >> auto_updated_file &&
> +		echo b >>auto_updated_file &&
>  			git commit -am "commit change $N.2" &&
> -		echo c >> auto_updated_file &&
> +		echo c >>auto_updated_file &&
>  			git commit -am "commit change $N.3" &&
>  		test_must_fail git svn dcommit && # rebase should fail
>  		test_must_fail git update-index --refresh
