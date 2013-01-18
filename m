From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: replace zsh notation that breaks
 bash 3.X
Date: Fri, 18 Jan 2013 11:08:27 -0800
Message-ID: <7vr4liqpg4.fsf@alter.siamese.dyndns.org>
References: <1358505065-16913-1-git-send-email-drafnel@gmail.com>
 <m2obgmjzz0.fsf@igel.home>
 <CA+sFfMd6FLchoOcUpNZ3AxTLNp3qe=VjijRid4sWf-A3_w88qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, felipe.contreras@gmail.com,
	git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHJ5-0001Jb-R4
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab3ARTIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 14:08:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754520Ab3ARTI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 14:08:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7485AADDE;
	Fri, 18 Jan 2013 14:08:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0KuLsLBgFzUTeQZRCU8CGO4uREY=; b=s8K837
	aOovvkCtw1lMs1mc4aJmI4DQvsYWbcquAWwYOGwTHHGSzhN27oTP7fvqm1AgKsfl
	OV90+5DaxSdiQeHCFcSqBIm6x1E2TEJD1Umj96jncz8wIRUth2GP45Avc7XXPJPQ
	bZgGrSgJYC6RNnbRGvb9aZGPBfG4HZZDWMwmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCOolStdykBMOY8IkXneSk72ux7uDSul
	97i2vEksQATZava2kWIGT60SHEpMBav/c3sF/HNaK+2AxRMh+HMd9oskTkumK9Ty
	GUfajdQq3LpD/SHzKavDN+pGN4gSmFcGaOGoyWqPF2jTqyIs3HQEHlCezW78PHRC
	JwkpIbKHi7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68D9DADDD;
	Fri, 18 Jan 2013 14:08:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFEBDADDC; Fri, 18 Jan 2013
 14:08:28 -0500 (EST)
In-Reply-To: <CA+sFfMd6FLchoOcUpNZ3AxTLNp3qe=VjijRid4sWf-A3_w88qw@mail.gmail.com> (Brandon
 Casey's message of "Fri, 18 Jan 2013 11:07:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 716A168A-61A2-11E2-9C4D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213928>

Brandon Casey <drafnel@gmail.com> writes:

> On Fri, Jan 18, 2013 at 7:02 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Brandon Casey <drafnel@gmail.com> writes:
>>
>>> +                             array[$(($#array+1))]="$c"
>>
>> You don't need $(( )) since the array index is already evaluated as an
>> arithmethic expression.
>
> Ah, I didn't know that.  Thanks.
>
> I think Junio will probably fix this up if he thinks it's worth it,
> but I can resubmit if necessary.

Please; I do not have mental bandwidth to keep track of contrib/
material myself.
