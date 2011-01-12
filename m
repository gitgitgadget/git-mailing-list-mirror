From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: correct indenting and formatting
Date: Wed, 12 Jan 2011 01:05:30 -0800
Message-ID: <7vhbde331h.fsf@alter.siamese.dyndns.org>
References: <1294808703-1848-1-git-send-email-andrew@andrewgarber.com>
 <7vsjwy33zn.fsf@alter.siamese.dyndns.org>
 <7vlj2q3339.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Garber <andrew@andrewgarber.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 10:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcweH-0000yP-4m
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 10:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1ALJFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 04:05:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab1ALJFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 04:05:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E384263F;
	Wed, 12 Jan 2011 04:06:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BPFvbtwH3g3V7DnrZT44PoKWdYs=; b=HsAeSR
	y6NIu+GJaFDwJ+lR8pTcZlzMYdnFM+fKqV5ssuUkvPH/EP3Ql91rEyOw1umAjSKS
	M5shBcY2JEqS86XyWmSXO7rWMZa6Blv+zlYok4glp0XjdEDS0le3YL3rnH/C+vUF
	dju59bXJHO77q4OVNAacRXRnXRSWG6F7tyk4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKOileRyxDhKLP2F7eiPs4z93POT+TVn
	iMBMM8hbmabsb3eCtVkH0KnPPfimmLkHrN+dM9CGSPPFXC0MaeL5ecujl1e4xLaj
	7hnM+01MV79CQ8kOZ7EHy9C+dd8yc38+Fl87IVBy3Pc5bGCPN/KN+loWAtCSk4TZ
	f/h21pNLsm4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05494263E;
	Wed, 12 Jan 2011 04:06:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD235263D; Wed, 12 Jan 2011
 04:06:13 -0500 (EST)
In-Reply-To: <7vlj2q3339.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 12 Jan 2011 01\:04\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3735EF3C-1E2B-11E0-B0B6-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165008>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Andrew Garber <andrew@andrewgarber.com> writes:
>>
>>> - replace tabs with appropriate number of spaces
>>> - minor tweaks to code formatting
>>> ---
>>>  contrib/fast-import/git-p4 |   71 +++++++++++++++++++++-----------------------
>>>  1 files changed, 34 insertions(+), 37 deletions(-)
>> ...
> Will queue on a separate branch for you, expecting that you are doing this
> in preparation for a new feature or a bugfix to the script.

Forgot to say obligatory "Please sign-off your patch".  Please do so.
