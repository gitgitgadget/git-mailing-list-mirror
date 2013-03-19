From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Tue, 19 Mar 2013 11:08:02 -0700
Message-ID: <7vwqt3i7p9.fsf@alter.siamese.dyndns.org>
References: <20130318220224.3b23a381@hoelz.ro>
 <20130318231043.GD5062@elie.Belkin> <7v38vsma9o.fsf@alter.siamese.dyndns.org>
 <20130319015541.GH5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 19:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI0xf-0007MP-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 19:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933396Ab3CSSIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 14:08:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933390Ab3CSSIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 14:08:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D80B823;
	Tue, 19 Mar 2013 14:08:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z4etbaGsefqBEOL4CnoNB/yNIyQ=; b=YOhBTl
	Ct812jJCBjXbQVAoO8PXlT3mEQHEvEbG2qtj1+/jFjCtyEJX4DxuXRaxxk3rxxM+
	P5tgPjkuaM7+76oe5j4TicuvfHlbwBOGHuUHQ+pBc7fjAv+ZwKr+eQw4ussoDD72
	7jENYXEnTFcokTahnAk4C/ECJDNLA+cLudPvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a1/mgSu3C3C9KYYe5zn8RdjX1/wmz8yz
	ZyfkRPrFKVTzxlTMxpcTrmugwy8Mo2eJ6M+3aU4konDqyCpW757Xp9vx7uvBajL4
	bx2o6CNSZWfKmZvX2UTfZ6WOsuRQktgAdUZV+f4vfI/7kgct/NprL8p4bJ1H/Tnj
	/6I7wiqbKAg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ED77B821;
	Tue, 19 Mar 2013 14:08:04 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C101B81C; Tue, 19 Mar 2013
 14:08:03 -0400 (EDT)
In-Reply-To: <20130319015541.GH5062@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 18 Mar 2013 18:55:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1540CB0-90BF-11E2-BA72-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218544>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Test nits:
>>> ...
>>> Hope that helps,
>>>
>>> Jonathan Nieder (3):
>>>   push test: use test_config where appropriate
>>>   push test: simplify check of push result
>>>   push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'
>>
>> Are these supposed to be follow-up patches?  Preparatory steps that
>> Rob can reroll on top?  Something else?
>
> Preparatory steps.

OK, thanks.  I'll queue these first then.
