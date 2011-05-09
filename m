From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Mon, 09 May 2011 09:20:29 -0700
Message-ID: <7vr587q20i.fsf@alter.siamese.dyndns.org>
References: <20110505191027.GA3242@camk.edu.pl>
 <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
 <4DC3A685.4080300@drmicha.warpmail.net> <4DC3CBEF.6080303@viscovery.net>
 <7voc3cqyfp.fsf@alter.siamese.dyndns.org> <4DC78C3C.6060004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJTCR-0008Rv-MU
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 18:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab1EIQUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 12:20:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab1EIQUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 12:20:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86B7B4212;
	Mon,  9 May 2011 12:22:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/nVnysgCf6SABfRZQrNozMtSTY=; b=onDc8x
	KGbzwvVrB2O+LmiD1nXuYe4LbU6wAPFIGIr3gHBZQldw2fw7D+w/OH3+XYjHxOdW
	KkNCepZLxlUqXRdEmv79aFW1EsNkFHqCuLgcvaebFwcgd6A0m27tV41C675S5wCA
	JgBIGJWHeEaKI+2eWs0XAmQKROmha0JHYmxX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mZ47PRMvZ+rlMAT3oLGTWx0dIVP6nkpZ
	LRa75waVrm5lnVr8I4sx9ypuKzBNl0SKRdtBZuOUIqYKS2bEW7ycBvjLErZF86Up
	/EPRVumT0T2T/6CplkD9WxrKyJ1w482hnIIGUFUtg+1BGhCNLQ3hL8LlypcS83g4
	Mx22+j13sfI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41CCA420D;
	Mon,  9 May 2011 12:22:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E90B4420C; Mon,  9 May 2011
 12:22:35 -0400 (EDT)
In-Reply-To: <4DC78C3C.6060004@viscovery.net> (Johannes Sixt's message of
 "Mon, 09 May 2011 08:39:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FE7E606-7A58-11E0-BB37-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173243>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/9/2011 6:40, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> - The behavior of quoting at the right of :- when the ${...:-...} exansion
>>> appears in double-quotes was debated recently at length at the Austin
>>> group (which revises the POSIX standard). You better move the expansions
>>> to assignments of temporary variables,...
>> 
>> What alternative semantics do Austin folks have in mind, by the way?  Just
>> declare this undefined?
>
> Most of the debate centered around how to quote a closing brace: the

Thanks for a summary.

> Looks good otherwise; I tested this with various shells, and there were no
> surprises.

Thanks, will amend.
