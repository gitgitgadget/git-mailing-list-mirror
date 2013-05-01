From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/18] remote-bzr: massive changes
Date: Wed, 01 May 2013 11:38:47 -0700
Message-ID: <7vehdq5yvc.fsf@alter.siamese.dyndns.org>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
	<7vppxb8d9k.fsf@alter.siamese.dyndns.org>
	<CAMP44s3zf0Hbx4-KHVH7+wCm_czTigJo2y=wqD5Ai-9cKxZcug@mail.gmail.com>
	<7vli7y8xia.fsf@alter.siamese.dyndns.org>
	<CAMP44s0n28ihRXf4f25Sx0jkg2u-eROR93bkO0Nm6X00tmkVMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:39:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbvm-0004gm-FA
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670Ab3EASjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:39:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164Ab3EASjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:39:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED0331B8A3;
	Wed,  1 May 2013 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y2yQ1TnpLD19tlW8TOvx7bT9NyE=; b=xccX5Y
	p3bYeIPWxHiARxxK6uKt2/9DI9KKqbdx+Isvf5zch9zZPXg89Msq/1UaLyDbQlWu
	5OhMTGuxpOSy5y9jFgYZaEtcbkLZqjwU9w3vWkDNWIaFU7L2ZwUw6F+ufaX7023M
	EagABdhNnYKHATBB53untNjw+oC9slzXrEFzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SkyEiHK1dUbKkJFcqbhIUTUi3xWyfP42
	2T1L0MxMc+VLMSritVRCSqNvaIlga4Bt23EpFrO/IWEMNunEB50glz/c1xLlbOSp
	AkuVFuqeVEX2BDyA5V9i17jyp93qZQzU+XZbWHtXFedxvpah6SaVSOuZFrWrwbqF
	CjZvo+ZkENQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BB71B8A2;
	Wed,  1 May 2013 18:38:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DDEA1B8A1;
	Wed,  1 May 2013 18:38:49 +0000 (UTC)
In-Reply-To: <CAMP44s0n28ihRXf4f25Sx0jkg2u-eROR93bkO0Nm6X00tmkVMA@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 1 May 2013 13:35:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D3D11AC-B28E-11E2-9FDB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223119>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 1, 2013 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> So let's go ahead and apply these directly on top of 'master', once
>>>> we hear from Emacs folks and they are happy with it.  I'll queue it
>>>> on 'pu' so that I do not have to go back to the list archive when it
>>>> happens.
>>>
>>> I already heard that everything seems to be working correctly, except
>>> one feature, the biggest change, which I screwed up with a one-liner
>>> commit. That's why I added a test. Anyway, I've fixed it in my github
>>> branch and in this patch series, and I've told them to try the fix.
>>
>> Let us know when they make progress on that front.
>>
>> If Emacs decides to switch to Git and decides to use this version of
>> remote-bzr for their conversion, or at least a nontrivial group of
>> developers favor to do so, without seeing concrete technical points
>> that say remote-bzr is not yet ready (e.g. "the conversion is still
>> wrong and X, Y and Z needs to be fixed"), that would be a very
>> welcome solid vote of confidence in favor of us going ahead with
>> this.
>
> Seems unlikely for political reasons (isn't it always for GNU?), since
> RMS is heavily involved in the decision.

I am very aware of that discussion (and the original one when they
decided to use bzr).  That is exactly why I said "at least ... favor
to do so".
