From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Thu, 03 Dec 2009 17:19:48 -0800
Message-ID: <7v7ht3zgaz.fsf@alter.siamese.dyndns.org>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
 <1259543939.5679.5.camel@swboyd-laptop>
 <94a0d4530911300219j51e21e2cwae17d4248400a345@mail.gmail.com>
 <780e0a6b0911301345v42c2b22bs34092fb69b21a2a0@mail.gmail.com>
 <94a0d4530912030133n7e2fbf2asfea6e3896980dc7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 02:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGMqE-00050N-RK
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 02:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZLDBTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 20:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZLDBTx
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 20:19:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbZLDBTw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 20:19:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BC47A3D44;
	Thu,  3 Dec 2009 20:19:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ey9H5Dd6XIxFz9m5p+8MXAilK9k=; b=rL4X8R
	+HvL9hWjX0kjXSA/PRWvNsNvUJdwC+CxGIjh2AdcbxC5lk27gxrcjlwwtR/YlPqk
	NW/iHom+mOGPDfVWLDTdiAMmQWU38tjg+oBYbR3b0A7mtR1awyqea+FwxcfNUD3T
	TmT7+xhRsg/XAU4QCOSifHy1pM1zwpS1Kq6fE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=exKlp2EWWzcbS5NSXq7f+imPb1PlY3Is
	tPguCJ8+k7MNcTVp1yfS+iYM2mT5MWz5Ho6yom+FHadRDo2Hk4/MZ9qf8zeWwJof
	7+vkCPpo8qRjjLXb3XOaZPzJeYq929tlze0oblz6MUZBUsoPPuk0wRPlDZEWbB7n
	h6vW1fEIN6w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D80AA3D43;
	Thu,  3 Dec 2009 20:19:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1AC8DA3D42; Thu,  3 Dec 2009
 20:19:49 -0500 (EST)
In-Reply-To: <94a0d4530912030133n7e2fbf2asfea6e3896980dc7c@mail.gmail.com>
 (Felipe Contreras's message of "Thu\, 3 Dec 2009 11\:33\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20C62024-E073-11DE-89A3-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134487>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Nov 30, 2009 at 11:45 PM, Stephen Boyd <bebarino@gmail.com> wrote:
>> If you're already touching the line why not just do it once? I agree a
>> follow-up patch to cover the other commands would be good.
>
> Because the less trivial the patches, the less luck I have of getting
> them applied :)

Well, the name of the game is not "let me have more commits under my name
in a well known project".  It is "let's work together to make the system
better without stepping on each other's toes and without introducing
unintended side effects".

I actually do not think it is the complexity that matters.  It largely
depends on what other patches are in flight that may have interactions,
and if the change is suitable for the phase of the cycle.

> Anyway, I sent a patch to use OPT__QUIET directly in two places.

Yeah, I saw it and queued it to 'pu'.  Thanks.

We _might_ want to think about doing something about the lossage of "long
messages" by this conversion, and we may end up updating OPT__QUIET() to
allow its users supply messages that are more suitable than the default
one, but I do not want to see such a change to parse-options before 1.6.6
happens on the 'master' branch, as I do not have infinite mental
bandwidth.
