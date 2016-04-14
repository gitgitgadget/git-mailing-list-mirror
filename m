From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add submitGit patch-submission information
Date: Thu, 14 Apr 2016 16:03:51 -0700
Message-ID: <xmqqpotreqso.fsf@gitster.mtv.corp.google.com>
References: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
	<0102015416d52b62-ce575cc4-6dc2-4097-8883-79baac701105-000000@eu-west-1.amazonses.com>
	<xmqq37qng721.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:03:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqqIo-0008W8-V6
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 01:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbcDNXDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 19:03:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751660AbcDNXDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 19:03:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14C8D1345A;
	Thu, 14 Apr 2016 19:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JfR6PXfWQf9wzL3tVSEJarSolpk=; b=AsjQlp
	LL9S+QtceatyXRBrPV5LH1G5ddrhS5TwwgDJiqqCBrcZqjiUPig+JN1a0ndBGJt5
	0m7704OvqIGGshkkuuhmwcsbscT87UpEi1jd8L2pO4fzTnHQYlnHyO7HjXnLqoED
	7XkslY3IPFHTLod1t1/9xjxtk39DB6sB7KysA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sIxZ9arjK+JaM7BuiF4sXcTWiYg3ofAW
	2sVhlm7p/OEwyiVBkBhwFQaUAmSyrmu4yvyVKf916zpFJbxQlOSyQThszxTNBvFy
	8QE7+IndNTiawZinM1Xxvn5LJu5jf54xGFL4Jd5nG+IAK0gbT5B+znp2FnwifeKL
	lD3e0XV9IoY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D2BE13459;
	Thu, 14 Apr 2016 19:03:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77E2813458;
	Thu, 14 Apr 2016 19:03:52 -0400 (EDT)
In-Reply-To: <xmqq37qng721.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 Apr 2016 15:27:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 27F39890-0295-11E6-99D7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291577>

Junio C Hamano <gitster@pobox.com> writes:

>> +Because of these factors, it's recommended that you use one of these
>> +specific methods to generate and send your patchs:
>
> Perhaps:
>
>     It's recommended ... your patches, unless you already know how
>     to correctly send your patches as plain-text e-mails.
>
> That is, the ones listed below are known to produce good patches,
> but our recommendation is _so_ strong to urge users with working

Well, I meant "our recommendation is *not* so strong" here.
