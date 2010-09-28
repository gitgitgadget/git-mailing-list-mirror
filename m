From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: be consistent in illustrations to 'git
 rebase'
Date: Tue, 28 Sep 2010 02:47:45 -0700
Message-ID: <7vy6amtd1a.fsf@alter.siamese.dyndns.org>
References: <1285662024-4992-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Sep 28 11:48:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Wn2-0001lU-7U
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 11:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab0I1Jry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 05:47:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab0I1Jrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 05:47:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED9AD9360;
	Tue, 28 Sep 2010 05:47:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3TzbFIQ2rEK2cTJBc96SlGubwBU=; b=NIec0y
	E4zz5IOU+iagz4fezshtxxyHnIi/ehkm46b5+ZoCpBaw03tybVu2XdX5S3AY6jUB
	OHUnNZoVsLJ41TprJI54s0HpLP3D8qPmr+5pXJu0wojnRsgr+jg1BW7omFXT3byD
	vG3kd0jI6Xxa/i1RC1ZFotIVdwwMs1QcwVuYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DdIUJV7sx8ThxMvzoyEgdm4eJVqIt61+
	Mc/X4psXR9sOVMKsSaKMbxbr9JW28n7XsYzla6IBXY+vmpNtkLy4RM0ier+kiaZC
	CkZex/Q9yq46qIlBk38ClpPYwDR4HE7wJL6wbcV9ICZLGKM/ubYIW8/6xsuyOCqw
	RvJ1Vy/9pOg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BEC7D935F;
	Tue, 28 Sep 2010 05:47:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EC35D935E; Tue, 28 Sep
 2010 05:47:47 -0400 (EDT)
In-Reply-To: <1285662024-4992-1-git-send-email-kirr@mns.spb.ru> (Kirill
 Smelkov's message of "Tue\, 28 Sep 2010 12\:20\:24 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75637746-CAE5-11DF-8C30-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157399>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Since we use a-b-c for mywork commits in one place, I think it would be
> logical to also use a-b-c too in other illustration on this topic.
>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> ---
>  Documentation/user-manual.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index fecc4eb..87ca1a7 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2424,41 +2424,41 @@ Keeping a patch series up to date using git rebase
>  --------------------------------------------------
>  
>  Suppose that you create a branch "mywork" on a remote-tracking branch
>  "origin", and create some commits on top of it:
>  
>  -------------------------------------------------
>  $ git checkout -b mywork origin
>  $ vi file.txt
>  $ git commit
>  $ vi otherfile.txt
>  $ git commit
>  ...
>  -------------------------------------------------
>  
>  You have performed no merges into mywork, so it is just a simple linear
>  sequence of patches on top of "origin":
>  
>  ................................................
>   o--o--o <-- origin
>          \
> -         o--o--o <-- mywork
> +         a--b--c <-- mywork
>  ................................................

Perhaps you would want to make the origin commit "O" while you are at it
(I can locally fix it up)?

>  Some more interesting work has been done in the upstream project, and
>  "origin" has advanced:
>  
>  ................................................
>   o--o--O--o--o--o <-- origin
>          \
>           a--b--c <-- mywork
>  ................................................
>  
>  At this point, you could use "pull" to merge your changes back in;
>  the result would create a new merge commit, like this:
>  
>  ................................................
>   o--o--O--o--o--o <-- origin
>          \        \
>           a--b--c--m <-- mywork
>  ................................................
>  
> -- 
> 1.7.3.6.g64005
