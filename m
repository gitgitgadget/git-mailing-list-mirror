From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 15:19:18 -0700
Message-ID: <7vy6cbpj89.fsf@alter.siamese.dyndns.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <AANLkTi=MenKX7Eh5PTpjfiYirrgLBCamWgorA35rx-Fy@mail.gmail.com>
 <7v62zfqya9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Brockman <gdb@MIT.EDU>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:19:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojg7l-0004ev-76
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab0HLWTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 18:19:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab0HLWTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:19:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB711CC45E;
	Thu, 12 Aug 2010 18:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TORjrS8zucmeBDX5+7vtclNXr2Y=; b=KJGfJN
	HuJ5GVR+SW5P2samHAgUzPMe+KQ8QzuOBaSUvUY3jq3W4Ij+NTPaS4S9XiDo1LeT
	F2pe7RCCjmG2aErRuPxb6GB6n+qN/zFomC4iHdFL1LCcyc7oyFESzgqMqty8gx+g
	ze+rnvh6e2obrYIN7V+5CtKFgSbPNYp7m7+oE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2CN/ICF7326yjlmDrqsoklyHod+wvAd
	k9U2yYd89VwpJh+eoW7tbwxa81cmexYrOrKi/dPxcTs15Nw6PjHJk68e52ITzXBy
	Iy/wI70K1uAT84FnaM9QsoPrpA9KO5RIgULt94m3g9LfpnrHKI4z5RHr8fAGjZQ2
	s8cMREiNzBY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D4EECC45C;
	Thu, 12 Aug 2010 18:19:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 356DFCC456; Thu, 12 Aug
 2010 18:19:20 -0400 (EDT)
In-Reply-To: <7v62zfqya9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 12 Aug 2010 15\:08\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC144BE4-A65F-11DF-9CE2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153432>

Junio C Hamano <gitster@pobox.com> writes:

> Greg Brockman <gdb@MIT.EDU> writes:
> ...
>> I had a submitted a revised patch that just uses HOME, see
>> http://thread.gmane.org/gmane.comp.version-control.git/152050/focus=152135.
>>  I guess that didn't make it in yet.
>
> No, it didn't; because you said
>
>     Err, actually it would probably be a good idea to
>     s/char *home = getenv("HOME");/const char *home = getenv("HOME");/
>
>     Greg
>
> hinting me not to pick it up.

Ok, I'll replace 1/3 with 

    http://thread.gmane.org/gmane.comp.version-control.git/152050/focus=152133

and hand-tweak the constness.

Thanks.
