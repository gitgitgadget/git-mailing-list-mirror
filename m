From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/5] submodule--helper clone: remove double path checking
Date: Thu, 31 Mar 2016 15:21:26 -0700
Message-ID: <xmqqk2kil255.fsf@gitster.mtv.corp.google.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
	<1459458280-17619-4-git-send-email-sbeller@google.com>
	<CAPig+cToyvzc4RbBmAAQtGmJ3WpxO6Z+XzrxrXQqYVH2RJcb-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:21:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alky6-0001FU-El
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529AbcCaWVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:21:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757251AbcCaWV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:21:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90EDC5221C;
	Thu, 31 Mar 2016 18:21:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0f1cjtrcGNPeyefgmuvZBJS3qmA=; b=t8A3we
	n9HBl4u8QfXiBRQ185mjM67WLkxbyfjoj4ahetTRxUR7tQxo+ke+dUbDMrnj0Xup
	wrKyeb6OaisLQW8brpo69sT8JcYfDCIffzSIG/MJjVMjj6lxM1lijseN4xzJUKr0
	Qxwb7Fgk84WA+1XOnjDd4McQXTvgzEKXADozI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBzyNcmq9SDQmRKhQWCX8SGE9FRu+igT
	8f33ksFPz26i+orwyDo1x1D7go0K9Y20ksylwb9pL1cgGy2PNQO2yzRymzN36LQH
	o+JiGkxGXywWcAt5La0PgN3pXRQXD1phAqeono9CGtZ8+qxJJyE6PwPfr1IRIxy7
	4sq5ahZLscA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 863575221B;
	Thu, 31 Mar 2016 18:21:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E91C75221A;
	Thu, 31 Mar 2016 18:21:27 -0400 (EDT)
In-Reply-To: <CAPig+cToyvzc4RbBmAAQtGmJ3WpxO6Z+XzrxrXQqYVH2RJcb-g@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 31 Mar 2016 17:58:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E98D352C-F78E-11E5-9B57-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290477>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Mar 31, 2016 at 5:04 PM, Stefan Beller <sbeller@google.com> wrote:
>> submodule--helper clone: remove double path checking
>
> I think Junio mentioned in v1 that calling this "path checking" is misleading.

I'd tentatively use:

    "submodule--helper clone: create the submodule path just once"
