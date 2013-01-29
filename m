From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] README: fix broken mailing list archive link
Date: Tue, 29 Jan 2013 10:10:46 -0800
Message-ID: <7vpq0nq2qh.fsf@alter.siamese.dyndns.org>
References: <1359456039-20562-1-git-send-email-artagnon@gmail.com>
 <7v622grlj6.fsf@alter.siamese.dyndns.org>
 <CALkWK0mm8UKBHE=tbXsiS4Z_qBGcRUUsmCKHHFequRiQRL3hsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 19:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0FeP-0003ch-45
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 19:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab3A2SKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 13:10:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369Ab3A2SKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 13:10:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2BF4B91F;
	Tue, 29 Jan 2013 13:10:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YPzayWfsEOv57kwuHfP/ZfzFGwY=; b=O6M/KD
	tMUDWLtpa0CyBAO1qsNxgcgzHkqyRfjvM4S0aXPSFBrNPzv6F5PwYRClFCvgPPu9
	WzltqAfdBPmzth0jBpKgteoPc8bA9R/VJApLfwgRkytUOB6qjgG8SJGA1mQAckwe
	4l+WqQtWtM4ZZr6pETucBRYQvBtGRugsI+HGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g4jq3q4kCblaUbp0q/GO2diDR0vPZ2TH
	y18m/0I4SmqGrFpxcEXxg9Ovfh9ucC2rQt+Xs4/aQPDRLsNdIB/nv2FxZLT2w0Wg
	zVeVafpbY58Py2v2d8bZ3SpaBEJQc+IbrwIto7cJ+aggo07EBLbVMdzq9yHtUd+B
	bb/KEUJvnxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E906CB91E;
	Tue, 29 Jan 2013 13:10:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B57DB91B; Tue, 29 Jan 2013
 13:10:48 -0500 (EST)
In-Reply-To: <CALkWK0mm8UKBHE=tbXsiS4Z_qBGcRUUsmCKHHFequRiQRL3hsw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 29 Jan 2013 23:11:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 355A4B56-6A3F-11E2-A093-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214953>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> marc.theaimsgroup.com does not exist anymore, so replace it
>>> with a link to the archive on GMane.
>>
>> I think it has been at http://marc.info/?l=git for some time.
>
> Isn't GMane what all of us refer to on the list though?

Then your original log message is wrong, no?  You earlier said that
we should replace it because marc no longer exists.  Now you are
saying we replace it because we prefer gmane.

I do not mind listing both, but I think we should limit the
enumeration to the minimum and let "and other archival sites" cover
the rest.
