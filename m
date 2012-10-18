From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: Aw: Re: [Patch v3 0/8] Create single PDF for all HTML
 files
Date: Thu, 18 Oct 2012 13:40:29 -0700
Message-ID: <7vy5j3ldj6.fsf@alter.siamese.dyndns.org>
References: <634888125.421937.1350580792693.JavaMail.ngmail@webmail11.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net,
	git@drmicha.warpmail.net
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 22:40:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOwta-0002lF-Jh
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 22:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab2JRUke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 16:40:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349Ab2JRUkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 16:40:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C90F9818;
	Thu, 18 Oct 2012 16:40:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N5ZQB6aNKPWIV9QOhwPmZAriMsQ=; b=PkWEYK
	uQEjiJmGtm2TMs19R3Huq14CJWZ6Q9aotEvNYCKRxo0veOC8VK0VnwBmrzLY67DF
	cGH5cTwXYVFUVOyUJTSp4mbJc8btxwJq66DJ4mk6dP8kP4KnsfZcKeree02lByIo
	YaE53IugKDAWkzFOReWPxCCmciZ6YBkh4hrUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KRVivL0I3gTUSa44x+bW6ALzZz4Gu6Xa
	8SWrC7ytWE596GT9TUAO16yN/U/RO5ox0Y6KC45deyeLlbK4EK0RbGD+B8g0DeYJ
	gMu3yIBjZvdGebsaXOl5K0pJSarB3ejEpeRl4HoBn+Pvc0qxtp7h//B3zf9j9OhA
	JT/SV/SPJ6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 289DD9816;
	Thu, 18 Oct 2012 16:40:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D56C9815; Thu, 18 Oct 2012
 16:40:31 -0400 (EDT)
In-Reply-To: <634888125.421937.1350580792693.JavaMail.ngmail@webmail11.arcor-online.net>
 (Thomas Ackermann's message of "Thu, 18 Oct 2012 19:19:52 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F186652-1964-11E2-98A6-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208018>

Thomas Ackermann <th.acker66@arcor.de> writes:

> Yes; in e2399e9 the following hunks where left out from the patch to update-hook-example.txt:
>
> @@ -111,12 +114,12 @@ then
>  
>        info "Found matching head pattern: '$head_pattern'"
>        for user_pattern in $user_patterns; do
> -	info "Checking user: '$username' against pattern: '$user_pattern'"
> -	matchlen=$(expr "$username" : "$user_pattern")
> -	if test "$matchlen" = "${#username}"
> -	then
> -	  grant "Allowing user: '$username' with pattern: '$user_pattern'"
> -	fi
> +        info "Checking user: '$username' against pattern: '$user_pattern'"
> +        matchlen=$(expr "$username" : "$user_pattern")
> +        if test "$matchlen" = "${#username}"
> +        then
> +          grant "Allowing user: '$username' with pattern: '$user_pattern'"
> +        fi
>        done
>        deny "The user is not in the access list for this branch"
>      done
> @@ -149,13 +152,13 @@ then
>  
>        info "Found matching head pattern: '$head_pattern'"
>        for group_pattern in $group_patterns; do
> -	for groupname in $groups; do
> -	  info "Checking group: '$groupname' against pattern: '$group_pattern'"
> -	  matchlen=$(expr "$groupname" : "$group_pattern")
> -	  if test "$matchlen" = "${#groupname}"
> -	  then
> -	    grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
> -	  fi
> +        for groupname in $groups; do
> +          info "Checking group: '$groupname' against pattern: '$group_pattern'"
> +          matchlen=$(expr "$groupname" : "$group_pattern")
> +          if test "$matchlen" = "${#groupname}"
> +          then
> +            grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
> +          fi
>          done
>        done
>        deny "None of the user's groups are in the access list for this branch"

Yuck.  That is because I almost always apply patches with whitespace
breakage fix.  The above two hunks, if taken as patches to shell
script, does nothing but adding whitespace breakages, turning tab
indent into expanded runs of spaces, and that was why the tool
dropped them.

Resurrected; will queue the result later.

Thanks.
