From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/2] Replace remaining git-* calls in git stash
Date: Thu, 23 Jul 2009 07:08:10 +0900
Message-ID: <20090723070810.6117@nanako3.lavabit.com>
References: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
	<1248206777-6984-2-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjzO-0006Nl-NG
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZGVWIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZGVWIc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:08:32 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35427 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbZGVWIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:08:31 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 6B2D511B834;
	Wed, 22 Jul 2009 17:08:31 -0500 (CDT)
Received: from 2862.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id B1H83IJ1QRCP; Wed, 22 Jul 2009 17:08:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=xV1YbMtB3tsXTgOz7iG9ZJ4j4n8SiQPRqKJOc6Wrtn62PKuJVko6OCR0Qd5CytDLIi2QT2Xf9S4ZmMfaZhztUjIRCxg4D8efHrtYhn3gWgJC9hUIZKwpjxtPpCKgf/jbIzTuPfUdrOkCdjW1dBh5s7f9FvWyeBsaoCR2QRtDJMk=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1248206777-6984-2-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123798>

Quoting Martin Koegler <mkoegler@auto.tuwien.ac.at>:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---

Thank you. Even though 'git blame' says I am not responsible for these two (I AM responsible for the one in your other patch)...

Acked-by: Nanako Shiraishi <nanako3@lavabit.com>

>  git-stash.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 5b4b4e6..03e589f 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -203,7 +203,7 @@ apply_stash () {
>  		git diff-tree --binary $s^2^..$s^2 | git apply --cached
>  		test $? -ne 0 &&
>  			die 'Conflicts in index. Try without --index.'
> -		unstashed_index_tree=$(git-write-tree) ||
> +		unstashed_index_tree=$(git write-tree) ||
>  			die 'Could not save index tree'
>  		git reset
>  	fi
> @@ -297,7 +297,7 @@ apply_to_branch () {
>  	fi
>  	stash=$2
>  
> -	git-checkout -b $branch $stash^ &&
> +	git checkout -b $branch $stash^ &&
>  	apply_stash --index $stash &&
>  	drop_stash $stash
>  }
> -- 
> 1.5.6.5



-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
