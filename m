From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Mon, 06 May 2013 07:48:44 -0700
Message-ID: <7vk3nctb8z.fsf@alter.siamese.dyndns.org>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
	<CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
	<7vsj264am4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0OysW1Rnc+Dk1R697zhtV+ubCMfDa+aWizOaHEcLbsJA@mail.gmail.com>
	<7v4nem488y.fsf@alter.siamese.dyndns.org>
	<CAMP44s0TtwBL=0MxU2C8QUkgA61KauPTcctH9TzQ_DdTaxh0eg@mail.gmail.com>
	<CAMP44s0zbb7GO2oFZ5LhSu3Xu_SMZcit5Yzqk+E=4XoO9Ju5Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 16:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZMii-0008OB-0v
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 16:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab3EFOss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 10:48:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab3EFOsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 10:48:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FFD91AF58;
	Mon,  6 May 2013 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zThMVhExBUm2kR4hyEZqj74sXVQ=; b=KAkZr1UpKqU1LSSZVsu5
	ADB374CWvUfrc/JQ1iOFl78MwolSXzKBvzwCQVwflACX5AlgtXx66Ev8lijQE332
	VI3WmlFoVm7jid6azdN76rSZe5lpwu0bG8B5RxAedIpS7p/dLBUYyTSBmINii4/v
	dwnPo25hSoW/qwOO1Ck4WZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PejQR+9JyMrAc0as4kfvVWP3gxH0zlqfK+JX197cUsolRP
	UuIdFg9Rf/zHMQGEPpUCEYqQnA7EBvzx9CBYfKnqmA/mkL837+g6MAVPbKMFNv7f
	m1OF8pBpUr3s5bTY+XMsJcboTgR/wO0HEPtJA4kSd2VWGfiLUCUv1b6+68OTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 939241AF56;
	Mon,  6 May 2013 14:48:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB5E81AF51;
	Mon,  6 May 2013 14:48:45 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DD3812E-B65C-11E2-8A99-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223454>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 1, 2013 at 6:14 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, May 1, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> It is just the "strip this, strip that" explanation, which is not
>>> technically correct, does _not_ have to be our justification for
>>> picking '@' as a short-hand for HEAD.
>>
>> The point is that it follows from @something -> @.
>
> So my proposal is:
>
> ---
> Typing 'HEAD' is tedious, especially when we can use '@' instead.
>
> The reason for choosing '@' is that it follows naturally from the
> ref@op syntax (e.g. HEAD@{u}), except we have no ref, and no
> operation, and when we don't have those, it makes sens to assume
> 'HEAD'.
>
> After this patch, we can use 'git show @~1', and all that goody goodness.

That reads much better.
