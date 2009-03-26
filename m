From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Remove spurious uses of "you" in
 git-bisect.txt.
Date: Wed, 25 Mar 2009 20:48:01 -0700
Message-ID: <7vprg5t05q.fsf@gitster.siamese.dyndns.org>
References: <20090324220201.GM19389@fieldses.org>
 <1238039084-4810-1-git-send-email-dmellor@whistlingcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, bfields@fieldses.org
To: "David J. Mellor" <dmellor@whistlingcat.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmgbe-0008C9-4d
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbZCZDsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbZCZDsM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:48:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbZCZDsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:48:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 632A6A5558;
	Wed, 25 Mar 2009 23:48:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D752DA5555; Wed,
 25 Mar 2009 23:48:02 -0400 (EDT)
In-Reply-To: <1238039084-4810-1-git-send-email-dmellor@whistlingcat.com>
 (David J. Mellor's message of "Wed, 25 Mar 2009 20:44:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB866C06-19B8-11DE-9963-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114719>

"David J. Mellor" <dmellor@whistlingcat.com> writes:

> These were added by accident in a42dea3.
>
> This patch also rewords the description of how ranges of commits can be
> skipped.
>
> Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
> ---
>  Documentation/git-bisect.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index a356a2b..ffc02c7 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -151,7 +151,7 @@ $ git reset --hard HEAD~3		# try 3 revisions before what
>  					# was suggested
>  ------------
>  
> -Then you compile and test the chosen revision. Afterwards you mark
> +Then compile and test the chosen revision, and afterwards mark
>  the revision as good or bad in the usual manner.
>  
>  Bisect skip
> @@ -175,8 +175,8 @@ using the "'<commit1>'..'<commit2>'" notation. For example:
>  $ git bisect skip v2.5..v2.6
>  ------------
>  
> -This tells the bisect process that no commit between `v2.5` excluded and
> -`v2.6` included should be tested.
> +This tells the bisect process that no commit after `v2.5`, up to and
> +including `v2.6`, should be tested.

Thanks; this part is much easier to read now.  These 'excluded/included'
have always bothered me.
