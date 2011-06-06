From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 09:23:59 -0700
Message-ID: <7v8vtf9bds.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DEC8322.6040200@drmicha.warpmail.net> <201106061419.34599.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTcbG-0005EW-LG
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 18:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab1FFQYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 12:24:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab1FFQYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 12:24:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05A9457E7;
	Mon,  6 Jun 2011 12:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y+AaS4+BiqakVIS7YNQf00OcrCc=; b=gTKDhF
	gmh4cSdPuNb5rplEe/wnQxxYePZFkdmR3ZU8JUpRKz07P0KA6SI0Yz7aRGuX70Ki
	Jq/VoNNDXAUZ8NS8bmz+VYrdNmyqWfOe55gPQsUySRS/mVwEbg+z4+kzdGME7DJo
	/gudGTfsQdaC5lKg2Vm1MZa+Hr//XhM8RjZIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H0gVUP/SWEYuSEzQOurWqizkrjlsxPRM
	Vjlja0RimTynHrGN27U9xrAV4pzFJWiruG2+/+9wA49GhxG4CZ/czEGMOOoard29
	1auPNkVL6PGZFsi3hKo/Q/k99At3JzBGKuITVUCXqMacnQzHUz3XtQ0b2XA6GngA
	ONQDXQQosyc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DB2457E4;
	Mon,  6 Jun 2011 12:26:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B669A57E1; Mon,  6 Jun 2011
 12:26:11 -0400 (EDT)
In-Reply-To: <201106061419.34599.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 6 Jun 2011 14:19:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B50C9F82-9059-11E0-BBCF-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175135>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 6 June 2011, Michael J Gruber wrote:
>
> So what you suggest would make
>
>   $ git diff NEXT WTREE
>
> behave differently from
>
>   $ git diff
>
> and
>
>   $ git diff HEAD NEXT
>
> behave differently from
>
>   $ git diff --cached
>
> Do you really think that it is good idea?

I do not know if Michael is suggesting to make it different, but if the
difference is an improvement, it may be a good thing. Being different from
the current behaviour should not be a basis for automatic rejection ---
otherwise we won't make any progress.

I just don't know what the plans by advocates of this NEXT/WTREE are for
conflicted cases [*1*] to tell how they want to make the user experience, so I
cannot even tell if they want something different, let alone to judge if
the proposed difference is an improvement.

[Footnote]

*1* There may be other equally important corner cases, but let's tackle
one simple and obvious thing first to see where this goes.
