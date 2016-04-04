From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-format-patch.txt: don't show -s as shorthand for multiple options
Date: Mon, 04 Apr 2016 13:07:42 -0700
Message-ID: <xmqqr3el3zox.fsf@gitster.mtv.corp.google.com>
References: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
	<xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRMti0ayBMS2TTUc-Og=X-Pu2yeHxHOS74fw=X8BTsjhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Kevin Brodsky <corax26@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 22:07:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anAmt-000235-0e
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbcDDUHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 16:07:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756377AbcDDUHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 16:07:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA38A4F695;
	Mon,  4 Apr 2016 16:07:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0BI4OvFvLRsun8svPK0appwULZo=; b=rioDUW
	sFcly0b2H8Q9CdDstc6N3oqjNJt3iuKgDQ/l2Hz4313dKKcEM2/TB+RQB8VyHHbk
	Ook5rC/T+4l7wSQ3rSls/pAgce/AYcQqi4Drg1Plt2HCvBwFJBYFceAxt3hflyji
	Cw+sHnaXRg/hjAQ3t2x2C9Q9Vm+5RbPK7inA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BE1zL+XVAZMOM+MqkvlNLjHP/JBgNqMN
	3GwsFPT9gx4woI1F4J4+Sb0dEWMkxKdRMB20cfMlo7FlZKzsBuzKDNVCfoJOdch6
	I8siQChQmbbocTOkpvZMIwY77rcVmWdnhRuaTnvu6OGwC3lN/U/7Ecd8G56Thvul
	XNt/sA9aDYE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B192B4F694;
	Mon,  4 Apr 2016 16:07:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F0834F693;
	Mon,  4 Apr 2016 16:07:44 -0400 (EDT)
In-Reply-To: <CAPig+cRMti0ayBMS2TTUc-Og=X-Pu2yeHxHOS74fw=X8BTsjhQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 4 Apr 2016 15:48:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E49FCB6E-FAA0-11E5-8784-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290719>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Given that the ifndef/endif block immediately before this part is
>> also about excluding -p/-u/--patch when formatting the documentation
>> for format-patch, perhaps the attached may be a smaller equivalent?
>
> Perhaps. I kept self-contained to make it easier to add new options
> between the two if need be, but I don't feel strongly about it.

I don't either, but the reason why I thought it would make sense to
have them in the same block is because hiding --no-patch and --patch
are about the same theme: format-patch is about presenting the diff,
and neither disabling diff output nor explicitly asking for diff
output makes sense.

So...
