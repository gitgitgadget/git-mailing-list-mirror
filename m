From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 18:49:22 -0700
Message-ID: <7vk4tdxcgt.fsf@alter.siamese.dyndns.org>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
 <4B9EA22E.1010103@lsrfire.ath.cx> <7v3a01jmp9.fsf@alter.siamese.dyndns.org>
 <ca433831003151735u697c5e3fm431dd98bcf48f7bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 02:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrLuc-0002zb-1i
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 02:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965936Ab0CPBtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 21:49:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965901Ab0CPBtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 21:49:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D463A09B9;
	Mon, 15 Mar 2010 21:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XZXi0nvs5qGHaUTAtFmM6TLL/LQ=; b=wFXWmC
	aucX6foIgrZI4elrk1MYsagfrEcT2yIxsGsjLnfzouKEveErvNKbQWvEe55UAIEP
	V6GEVBxvNz+HVx91fMDiSfJNDzhrPnA0OUu8KYwval75niWlYzZ8dDgCZHcVI1NY
	A75WynVnk6kiUU/ZVwVpux2GBRCDylQ7KJ/zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q90nS5efIjJIGGAqpm3NjIDmZbKQ3SjO
	KS5KdjW1iaw09nl+COL9a/DCDUILnZTMOpGTwhg428s9MeHye0d5Nt6ZXywGSHOf
	LryBb52ACnv6YiWs7QXG7nxzCvcLYll5r5v2e2RY1a4nff6+6CAIG7ONNCBm1qxU
	GGwY5MKSazY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36F0FA09B5;
	Mon, 15 Mar 2010 21:49:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D9BBA09A9; Mon, 15 Mar
 2010 21:49:23 -0400 (EDT)
In-Reply-To: <ca433831003151735u697c5e3fm431dd98bcf48f7bf@mail.gmail.com>
 (Mark Lodato's message of "Mon\, 15 Mar 2010 20\:35\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28357EA6-309E-11DF-9D12-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142291>

Mark Lodato <lodatom@gmail.com> writes:

> On Mon, Mar 15, 2010 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Another thing to worry about is how "--comments" and "-v" would interact
>> with each other.
>
> What about putting the comment on the line below, with the same level
> of indentation?

That, or in an order that is the other way around.

I think eventually people realize that "branch -v" and "tag -l -n $n" are
similar and start making noises about "branch -v -n $n" to internally run
"log --oneline".  To prepare for such a feature creep, comment first then
commit would probably be a better idea, but I dunno.
