From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix spelling of "occurred"
Date: Fri, 10 Jun 2016 15:22:04 -0700
Message-ID: <xmqqziqsd6r7.fsf@gitster.mtv.corp.google.com>
References: <CAFZEwPMgYCau=LxdtjZ2WVJXp91mXYG5bc=0X0mo_eJ+eYqLHA@mail.gmail.com>
	<1465585526-32187-1-git-send-email-peter@colberg.org>
	<xmqqd1noeodt.fsf@gitster.mtv.corp.google.com>
	<20160610220405.GA19824@alcyone>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Peter Colberg <peter@colberg.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:22:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBUog-0006Cs-37
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 00:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbcFJWWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 18:22:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751724AbcFJWWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 18:22:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 22282233DC;
	Fri, 10 Jun 2016 18:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=osJW+Riux1qCepIHOCDYZf+cSw0=; b=j5KGTP
	rHSZzdnAid4pIyAbB9sZKOYHYUCqDVGlL7Wxb+6Tl7HpDFbNYGr6Omq1STOoMCHo
	ZW3iXAp4nLUgyu431GUg7cXtXLpk7IPfLncRqNAvtsBdq/ZdpyhYWBYa5nIuSk8I
	wcRHY8WlRsuo4xIcoGECRNExGTLAE91kAwU24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3Ss9joDWEgW3LLq4cYrV77tp+1+Mc3y
	aNoMYJHjvQ2dN+PSGtZtQkO0dEj3+0qTsNxqE3WhzW2Yr12gIdW6kOMYT5uJrUaC
	3KR0aLcy7DgVGeMjaGpSScyAH5BNkUO7wSguQE8qrVJVHSnK8RBu/3GFnez+5H8t
	BtddIVluu4Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 18DCC233D9;
	Fri, 10 Jun 2016 18:22:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABD50233D8;
	Fri, 10 Jun 2016 18:22:06 -0400 (EDT)
In-Reply-To: <20160610220405.GA19824@alcyone> (Peter Colberg's message of
	"Fri, 10 Jun 2016 18:04:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3EE276A-2F59-11E6-A510-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297080>

Peter Colberg <peter@colberg.org> writes:

> On Fri, Jun 10, 2016 at 02:15:58PM -0700, Junio C Hamano wrote:
>> For this one, I am tempted to say that it may be better to remove
>> the verb altogether, which would lead to a more concise error
>> message.
>
> Thanks, I will send [PATCH v3] when the next release cycle begins.

There may not be a need for resend, though.  I already split them
into two and queued to my tree (two patches, pc/occurred topic
ending at 3a39f61e0).

Thanks.
