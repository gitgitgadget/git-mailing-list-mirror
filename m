From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7.1 3/4 (amend)] gitweb: File based caching layer (from
 git.kernel.org)
Date: Mon, 29 Nov 2010 14:20:13 -0800
Message-ID: <7vr5e3zs9u.fsf@alter.siamese.dyndns.org>
References: <201010311021.55917.jnareb@gmail.com>
 <201011130056.24222.jnareb@gmail.com> <201011281223.03141.jnareb@gmail.com>
 <201011281231.46786.jnareb@gmail.com>
 <7vvd3fzskv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 23:20:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNC5O-0002gl-6I
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab0K2WUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:20:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0K2WUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:20:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2ADCE3953;
	Mon, 29 Nov 2010 17:20:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+3EpZ2zcs3IFGn/b60Izbxk0O0=; b=rvHABm
	F9fb1NasYq66pPd++SNfYt9AidUPVon0JCxEpp0zGgknLerlnLQiohEXyysLFcmr
	pNg9hDe07VnuAcJQmlGeZqGbCa9K7sDapKFVqJWVBy2dJydv/gF6OjsseePEpkry
	wYOwspvmRbnMyBGVHNg0aKI/HTF3eWyV3JBsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g7ERHSt8pPT9YzQwU1czLOLaobHX3GPK
	nGTxubwUF/nD+xX9ScvPPM4J9zzsC2P9iDDJ+9CpZGcVXR/gkvj18qGCxrTI6VOU
	PYZip0X33fBW86gd+EpbDy7exbPlRQ0AnfqFzCmWeWxVV9/+0KuZlP3cyW2UoYW7
	Q/1rzNWM7oY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABECC394F;
	Mon, 29 Nov 2010 17:20:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 46503394E; Mon, 29 Nov 2010
 17:20:32 -0500 (EST)
In-Reply-To: <7vvd3fzskv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 29 Nov 2010 14\:13\:36 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E76553F8-FC06-11DF-8BDE-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162434>

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>>> I have made mistake with this line when moving $caching_enabled check
>>> out of cache_fetch to its caller.
>>> 
>>> Reusing $fullhashpath variable as a *capture buffer* (it has nothing
>>> to do with path; it is not a filename no longer) wouldn't help there.
>>
>> Errr... I meant that this abuse didn't help avoiding my mistake.
>
> Thanks.

Wait a bit.

This seems to match what I have already queued on 'pu', no?  Am I
hallucinating?
