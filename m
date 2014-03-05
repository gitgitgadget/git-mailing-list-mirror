From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] i18n: proposed command missing leading dash
Date: Wed, 05 Mar 2014 13:57:15 -0800
Message-ID: <xmqqbnxkfgw4.fsf@gitster.dls.corp.google.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<xmqqa9d5lsdb.fsf@gitster.dls.corp.google.com>
	<CANYiYbEZEYwrOh0VZAGiX_sMB3z+6ntv3_UgbLkvsU6FvH07Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLJoZ-0000qu-G0
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 22:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651AbaCEV5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 16:57:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012AbaCEV5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 16:57:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0758706B7;
	Wed,  5 Mar 2014 16:57:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F8p/KLwcIbwnGePAxXpli+q0Xys=; b=pqRwk/
	x3I4BtRcfisigGLPaP15LZVRq9ulbh2Y/NY9GlX3snAqOj+w+e0PKe2Y3Unie/A0
	G+lMpCRbwkIeFqyDn6uqR0afQznAcCk4tpsSOkInp5A77uVlejbVt55GDnXlloOE
	M9RIHpl4oS10BsuKyKBoWeUH8BKtlCx/z4NT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BtUFuFQ9xDRMVtcbmeVzL6GL77WOW9Qa
	BIGIggmagWH1Yn160YmbPRa8ZngJVOfPUgX/uv4O6exT5hzTFKOHM+o6gu2h7Zdc
	P8SrfmgvZNPlDq+A6gb1ixUVqXx50+BnVdsbOZaVMVvcFZSiFtuY08pVfiR/GyP4
	faRCW//Lzw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A88A1706B6;
	Wed,  5 Mar 2014 16:57:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7E1A706B3;
	Wed,  5 Mar 2014 16:57:16 -0500 (EST)
In-Reply-To: <CANYiYbEZEYwrOh0VZAGiX_sMB3z+6ntv3_UgbLkvsU6FvH07Dg@mail.gmail.com>
	(Jiang Xin's message of "Wed, 5 Mar 2014 22:14:44 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1DDA79A8-A4B1-11E3-A7B3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243486>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2014-03-05 2:40 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>> From: Sandy Carter <sandy.carter@savoirfairelinux.com>
>> Date: Mon,  3 Mar 2014 09:55:53 -0500
>>
>> Add missing leading dash to proposed commands in french output when
>> using the command:
>>     git branch --set-upstream remotename/branchname
>> and when upstream is gone
>>
>> Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * Forwarding to the i18n coordinator.  I don't do French, but this
>>    seems trivially correct.
>
> Applied to maint branch of git://github.com/git-l10n/git-po, and can be
> merged to master directly.

Thanks.
