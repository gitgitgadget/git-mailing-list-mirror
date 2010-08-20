From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/checkout: Fix message when switching to an
 existing branch
Date: Fri, 20 Aug 2010 11:17:04 -0700
Message-ID: <7v4oepcfof.fsf@alter.siamese.dyndns.org>
References: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
 <AANLkTine1mi0AiCL+ezwNpFs4_y_szSwJd+Enux5G26Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 20:17:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmW9c-0001W2-Sa
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 20:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab0HTSRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 14:17:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0HTSRP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 14:17:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1748CE70D;
	Fri, 20 Aug 2010 14:17:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GiL3UyfFgKAp2WVJLIPdKOE9Kbg=; b=H5bMsP
	BmFBYiJixrcoFTvNhioLKIBr5PAOWOu+GJPiJ+16JxydM8izVTrTxaDORtu2I4mf
	Tggh90hih9UvjNxrQzwThcXQrrxwN3/YWG6mAfi6rhwg30+scvs49zzJ0X7aiwKb
	bUxGjYtWRykVwXB4PYmpyj6U30iar7m6jsDGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLA7y1GN4hD8wvz7gLcf2DN9wpRyXfjs
	kVp7rq34IW0c1AqK2Vhj8thVbqsUFYkwNuBDeO+rxOk25xor9teiP51NvRF4U3cP
	NFCSDTGn2Zu0bgql0F4fAFI2QsSNDOP/b79qAaRfO5e7vnPB1LbB7Md50WjS3tZp
	GRJtaDpAea4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D17ECE70C;
	Fri, 20 Aug 2010 14:17:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D9AFCE70A; Fri, 20 Aug
 2010 14:17:06 -0400 (EDT)
In-Reply-To: <AANLkTine1mi0AiCL+ezwNpFs4_y_szSwJd+Enux5G26Y@mail.gmail.com>
 (Tay Ray Chuan's message of "Sat\, 21 Aug 2010 01\:46\:13 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 26B1E74E-AC87-11DF-B462-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154065>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Sat, Aug 21, 2010 at 1:41 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Fix "Switched to a new branch <name>" to read "Switched to branch
>> <name>" when <name> corresponds to an existing branch. This bug was
>> introduced in 02ac983 while introducing the `-B` switch.
>>
>> Cc: Tay Ray Chuan <rctay89@gmail.com>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>
> Please see
>
>   <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>

Hmm, I somehow find this version easier to read.
