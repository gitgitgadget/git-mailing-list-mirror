From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch v2 5/8] Prerequisites for creating nice html for all
 files in Documentation/howto
Date: Thu, 11 Oct 2012 12:06:02 -0700
Message-ID: <7vfw5k7rs5.fsf@alter.siamese.dyndns.org>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
 <1873679011.46972.1349976139154.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 21:06:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMO5M-0007Uy-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 21:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043Ab2JKTGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 15:06:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964880Ab2JKTGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 15:06:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1EAF8255;
	Thu, 11 Oct 2012 15:06:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LcLMqYg/NBhAfd/s/VsCdzbwMEk=; b=GmCI+i
	+UAJLO77LCHdk/AnEkkM7D2iqM1tIm6p3tMAAMNMRTKr0JdqbD/c6rpk1wZXMamt
	9+YJ4XkvEINVvohZxTsNRPLOQNEP6+R0GAOGC98Payfrz4RRpyf+0Mv2umKXkniT
	j1kZMdmUsM1Lz8zWme2ych3DMcTk8pn5dXIAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dD2Zol6viJdqUG0Qz/IhOjFMCZJfMn1v
	pd495LrHpMqjfX0WDaxBcIzEkLxkW7OFS/6a6fv6BVYv65Xxi1lZI/qI+g0fxQJc
	W1S8O12Iy6i+ZZ34APJbrrp6K1plR9+VVyb4sSfoZnq6m4osARuenbpZ5WoweXDc
	bRQld6Pa+3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD6948254;
	Thu, 11 Oct 2012 15:06:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FC378253; Thu, 11 Oct 2012
 15:06:04 -0400 (EDT)
In-Reply-To: <1873679011.46972.1349976139154.JavaMail.ngmail@webmail22.arcor-online.net>
 (Thomas Ackermann's message of "Thu, 11 Oct 2012 19:22:19 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B42E14FE-13D6-11E2-A7AA-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207506>

Thomas Ackermann <th.acker66@arcor.de> writes:

>>From 2b9538990e30ae0911117c8e3d8b6891c9de31cf Mon Sep 17 00:00:00 2001
> From: Thomas Ackermann <th.acker@arcor.de>
> Date: Sat, 29 Sep 2012 17:28:54 +0200
> Subject: [PATCH] Prerequisites for creating nice html for all files in
>  Documentation/howto

These four lines are not needed; please remove them from all the patches.

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
> +	    for groupname in $groups; do
> +	      info "Checking group: '$groupname' against pattern: '$group_pattern'"
> +	      matchlen=$(expr "$groupname" : "$group_pattern")
> +	      if test "$matchlen" = "${#groupname}"
> +	      then
> +	        grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
> +	      fi
>          done
>        done

The inner "done" does not seem to align with the "for ...; do" it
corresponds to, does it?
