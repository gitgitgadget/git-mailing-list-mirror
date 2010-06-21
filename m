From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Mon, 21 Jun 2010 11:37:07 -0700
Message-ID: <7v1vc0i65o.fsf@alter.siamese.dyndns.org>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
 <AANLkTinB4N6xXm7_Locp-xJyN8Nkew_7t16XhjVi_GlB@mail.gmail.com>
 <7v7hltvcfy.fsf@alter.siamese.dyndns.org>
 <AANLkTiksOHr2m4HCPp8779VG95zexvYwgE86MsFzBJxF@mail.gmail.com>
 <7v631ci6ex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 20:37:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQls1-0004Rv-Qu
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 20:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686Ab0FUShP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 14:37:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0FUShO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 14:37:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DB8FBD2F1;
	Mon, 21 Jun 2010 14:37:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lw+o+ivXZRrZHTbvvN1+8Y/6RWQ=; b=fG9Yhb
	8GEmxnB6nFS5sigBvxJ1syLntfwxfAEgGVlSBOCuEILQRofiP9nzGlD97mYSlw+g
	4NRy/DjLF8j1oD4qmm9YjDI7fD5cTWEeKlG8CmeZjZv8/owOQ9jRJXR37t/xQyh0
	PJv0ki//68O90/RLcVMAT6F6ZDADCtJHS5a3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IQoyeh3346kyBWDL0D7E492CI6no0eMP
	HJgMThMZgXygBhg1hKW6v6DRkJattzfXfwJ+jqPNEXz0rnABNrAXpZOV20MtDn5k
	7Vs43hoTkIR8WSvBLlOyi5iwUBMpIXUnyCEuDCkQpS8wwp9HWqibCqLHdAYgvM0p
	vm+rLSBS9ls=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09989BD2EF;
	Mon, 21 Jun 2010 14:37:12 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A9D1BD2EA; Mon, 21 Jun
 2010 14:37:09 -0400 (EDT)
In-Reply-To: <7v631ci6ex.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 21 Jun 2010 11\:31\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0184A148-7D64-11DF-A8A9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149432>

Junio C Hamano <gitster@pobox.com> writes:

> Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:
>
>> So, here is the message ID
>> 1275399845-13311-1-git-send-email-pavan.sss1991@gmail.com
>
> Do you really mean that one?  Jakub had quite long review comments; so did
> Pasky.  I had an impression that the following was the last/latest version.
>
>     Subject: [PATCHv2] git-instaweb: Add option to reuse previous config file
>     Date: Wed,  2 Jun 2010 03:29:49 +0530
>     Message-ID: <1275429589-30634-1-git-send-email-pavan.sss1991@gmail.com>
>
> (FYI, you can visit "http://mid.gmane.org/$that_message_id", click on its
> subject string to see the thread in context).
>
> I see Jakub's Ack to it.  Please confirm that one is what you meant and
> I'll apply.
>
> Thanks.

Wait a minute.

That one was applied about ten days ago as 8b94125 (git-instaweb: Add
option to reuse previous config file, 2010-06-02) and has been cooking in
'next' since June 13th.

So what did I miss???
