From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] Correct common spelling mistakes in comments and
 tests
Date: Fri, 12 Apr 2013 13:39:06 -0700
Message-ID: <7vppxzcwlx.fsf@alter.siamese.dyndns.org>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <20130412064837.GA5710@elie.Belkin> <20130412071102.GK5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 22:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQkkm-0007Bc-D2
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 22:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab3DLUjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 16:39:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924Ab3DLUjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 16:39:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBD98164BA;
	Fri, 12 Apr 2013 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fu495PBoFa6PKHsUXaJOh9LaKws=; b=XqD20S
	gkRT5noCqLRdp/9bJMti6HkrkQ/3X9wT+Lx6OyM5AcIDzJYRZ/agJbDrICmqMy3T
	7riGtUzO6sKaNSEx3zX9mlBovZTJb4xUXDUjWRICK+ZOKnU6OJm9TPavRrzOFgwn
	y398axcDXhSClCgX2qK1zh/QWeL4NhFFC6fXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FEPejn5hS2artxikJQLD8AL9njPC2huo
	lWM53Sw9CbdahhBj3ZT3/YQEpsEAYkDzuF7yC+2PnAR34eSyxZjn+8b1D2aAE5So
	rbm+7ah/YTK5bqsHNDHWFSk4r+9b8G5T7AohARgas6nuB0LzHzoar2B1fIMtvvgt
	ItcTD7Flc4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1EF9164B9;
	Fri, 12 Apr 2013 20:39:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35A97164B8; Fri, 12 Apr
 2013 20:39:08 +0000 (UTC)
In-Reply-To: <20130412071102.GK5710@elie.Belkin> (Jonathan Nieder's message
 of "Fri, 12 Apr 2013 00:11:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0626C6F6-A3B1-11E2-81DF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221024>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index d8b7f2ff..f8a08b7f 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -116,7 +116,7 @@ tree_pretty_content="100644 blob $hello_sha1	hello"
>  
>  run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
>  
> -commit_message="Intial commit"
> +commit_message="Initial commit"
>  commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
>  commit_size=176
>  commit_content="tree $tree_sha1

This breaks the test for rather obvious reasons.  I'll squash this in:

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index f8a08b7..9820f70 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -118,7 +118,7 @@ run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
-commit_size=176
+commit_size=177
 commit_content="tree $tree_sha1
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000

Thanks.
