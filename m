From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: add space between branch name and
 status flags
Date: Wed, 30 Dec 2009 11:27:25 -0800
Message-ID: <7veimc1cv6.fsf@alter.siamese.dyndns.org>
References: <200911201309.16193.roman.fietze@telemotive.de>
 <7v4oopxeuf.fsf@alter.siamese.dyndns.org>
 <20091230224129.6117@nanako3.lavabit.com> <20091230145751.GE6914@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Roman Fietze <roman.fietze@telemotive.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4Ct-0000hf-Pe
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 20:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbZL3T1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbZL3T1j
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 14:27:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbZL3T1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 14:27:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0748C57D;
	Wed, 30 Dec 2009 14:27:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P+6f1NpcTl1yn/Pye5B0SldJhak=; b=cNwAa8
	vjP9nMLP6iCHsrRAD75wa2QdknQXBiA3As0vh8BJVCBT5rmQMqzzS+L1PVsoNxyC
	4Ml3JZTf0OP8pibjsU3sFEoScEf52r3vL+RiMgevfr0+GyMAkx7v5xEGA/YSnozu
	79dE2dPASXP5lgcgJOjByfF2Dtqqj2CzVcJ0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N63voxSIgPrY4VQg4rM+tM89eKWuGh2V
	CfPpMDCCjYSgMeTahb4r2vdlE7MwkaZvQXDI5+spF1J6aGaMf2a/ayvr2eXIWSYA
	DkD/03nL3xiaZKzyRCFCmjSOmiU4V+w73WbCWRYJsegg1eba8fyaTFyid1xJPFN0
	Anw6bD56quc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38C6A8C572;
	Wed, 30 Dec 2009 14:27:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E0A18C56F; Wed, 30 Dec
 2009 14:27:27 -0500 (EST)
In-Reply-To: <20091230145751.GE6914@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 30 Dec 2009 06\:57\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60395094-F579-11DE-9681-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135916>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> Junio, could you tell us what happened to this thread?
>> 
>> In response to a patch from Roman Fietze to outline a better way
>> to do it.  Nothing happened.
>
> Junio responded with a suggestion on how to improve the patch when
> GIT_PS1_SHOWDIRTYSTATE was not set, but Roman Fietze didn't send
> a revised patch, so it got dropped.
>
> Here is the revised patch, Junio, still think its a good idea?

Thanks for following up.

As I don't use $[wisu] myself, I don't have a very strong opinion either
way, but the user has spent cycles to compute them, so we'd better present
them in a way that is easier to read, I guess.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index fbfa5f2..3c8b6df 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -163,10 +163,12 @@ __git_ps1 ()
>  			fi
>  		fi
>  
> +		local f="$w$i$s$u"
> +		f="${f:+ $f}$r"
>  		if [ -n "${1-}" ]; then
> -			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
> +			printf "$1" "$c${b##refs/heads/}$f"
>  		else
> -			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
> +			printf " (%s)" "$c${b##refs/heads/}$f"
>  		fi

I notice that printf argument look very similar.  Maybe we want to do
something like

    printf "${1:-" (%s)"}" ...

to avoid duplication?
