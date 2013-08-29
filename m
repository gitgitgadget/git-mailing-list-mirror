From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/11] Fix some typos and improve wording
Date: Thu, 29 Aug 2013 11:16:19 -0700
Message-ID: <xmqqvc2o4b2k.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<70864071.34489.1377626361141.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6lf-00026a-Kl
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab3H2SQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:16:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650Ab3H2SQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:16:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF4F3D76D;
	Thu, 29 Aug 2013 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PXpvyVKOUswKjpNE/4VxxL5I7Mo=; b=SX1EAV
	QjjfuvVLEgnmn8ebGQM3sdBvs6WIXWa+avp52Qjao5eGHFq2EwcSshFwHxDwZ1VB
	sPOJYj4sDRCcl95p+ZI/aaB+qU2hnGjRYjf3i9VbiSyVzIhLPsJvRC83Jg4yS1PH
	L1kQ+3oSci7b72M0Xg3hvcAyfvjvZlI/61S/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=amQuh3fRVNMwdKe7HI3xUaWdpnY3nFJW
	wO6F2Mi0xgrX1iG3WQc+uFtMngWMMUq7LU8ICV8P9VSqXgwIukjhFDoiKBY6l3Nr
	jGT3fZ/WrTwbd+ySVCUYBGtog4mUNdS/b4cc5C9AXWoowDzWRd1jHd51DdUbQFhl
	+exbQFhB7TM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55DF53D76C;
	Thu, 29 Aug 2013 18:16:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99B3F3D76B;
	Thu, 29 Aug 2013 18:16:20 +0000 (UTC)
In-Reply-To: <70864071.34489.1377626361141.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 19:59:21 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AE3C6FA-10D7-11E3-922E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233307>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 6241a43..465d9cb 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -219,7 +219,7 @@ of development leading to that point.
>  
>  The best way to see how this works is using the linkgit:gitk[1]
>  command; running gitk now on a Git repository and looking for merge
> -commits will help understand how the Git organizes history.
> +commits will help understand how Git organizes history.
>  
>  In the following, we say that commit X is "reachable" from commit Y
>  if commit X is an ancestor of commit Y.  Equivalently, you could say
> @@ -793,7 +793,7 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
>  -------------------------------------------------
>  
>  Or you could recall that the `...` operator selects all commits
> -contained reachable from either one reference or the other but not
> +reachable from either one reference or the other but not
>  both; so
>  
>  -------------------------------------------------
> @@ -820,7 +820,7 @@ You could just visually inspect the commits since e05db0fd:
>  $ gitk e05db0fd..
>  -------------------------------------------------
>  
> -Or you can use linkgit:git-name-rev[1], which will give the commit a
> +or you can use linkgit:git-name-rev[1], which will give the commit a

As raised during the initial review, the previous sentence has ended
and this begins a new sentence, I think, hence "Or", not "or".

>  name based on any tag it finds pointing to one of the commit's
>  descendants:
>  
> @@ -864,8 +864,8 @@ because it outputs only commits that are not reachable from v1.5.0-rc1.
>  
>  As yet another alternative, the linkgit:git-show-branch[1] command lists
>  the commits reachable from its arguments with a display on the left-hand
> -side that indicates which arguments that commit is reachable from.  So,
> -you can run something like
> +side that indicates which arguments that commit is reachable from.  
> +So, if you run something like
>  -------------------------------------------------
>  $ git show-branch e05db0fd v1.5.0-rc0 v1.5.0-rc1 v1.5.0-rc2
> @@ -877,15 +877,15 @@ available
>  ...
>  -------------------------------------------------
>  
> -then search for a line that looks like
> +then a line like
>  
>  -------------------------------------------------
>  + ++ [e05db0fd] Fix warnings in sha1_file.c - use C99 printf format if
>  available
>  -------------------------------------------------
>  
> -Which shows that e05db0fd is reachable from itself, from v1.5.0-rc1, and
> -from v1.5.0-rc2, but not from v1.5.0-rc0.
> +shows that e05db0fd is reachable from itself, from v1.5.0-rc1,
> +and from v1.5.0-rc2, and not from v1.5.0-rc0.

This is easier to read. Good.
