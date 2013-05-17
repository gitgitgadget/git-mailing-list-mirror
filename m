From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Fri, 17 May 2013 10:57:29 -0700
Message-ID: <7vfvxlzdyu.fsf@alter.siamese.dyndns.org>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
	<7vbo891ra8.fsf@alter.siamese.dyndns.org>
	<CAPig+cSYKM3XUm4m=ip_=p0mQz=gz0VKx7bfS=UdUsFMECWEQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:57:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOuP-0006XN-BI
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab3EQR5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:57:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504Ab3EQR5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:57:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBAB21BFAE;
	Fri, 17 May 2013 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4B/x+fySnQ1HnU7ZZMZx4yr4YHk=; b=BvpRUx
	yRmhcXdNX+pm+Un2BMCnJy0gjH893Bo+nqLrIHappCK+V1QDGJQb5Q59r3Fr81wV
	eZGfvnpOsNRZzdEa6pdK6P/oLHHgvvSIQikN9XxD5wl2M2VEc9vqJ3GhdPtlY3X+
	QhLn10fGIilt3l4laHsQY/o+4kbFPhMGLvhew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PJ5Skzob7Aexrm/LzDOSrhh3SGYp7Lno
	UaYPwQtJoMVM8mnQ5GPvJbUVTpz4glbJJHaAjrR2PeNJRwPI4jW9z7HyL2VJFPEz
	xrI6dcfjMDZQQ4PO+yGH/eBNVO9zoMVpVDBM6jZk1ua8sD47DhqUef5n9pciW2Ow
	gbTOofDHrj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD2B41BFAD;
	Fri, 17 May 2013 17:57:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B56AE1BFA9;
	Fri, 17 May 2013 17:57:30 +0000 (UTC)
In-Reply-To: <CAPig+cSYKM3XUm4m=ip_=p0mQz=gz0VKx7bfS=UdUsFMECWEQw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 17 May 2013 13:29:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E76993E-BF1B-11E2-AC43-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224722>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 17, 2013 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>>> Do you have advice on how we should proceed?  :sigh: sorry for wasting
>>> so much maintainer time on this series already.  If you need any
>>> resends or anything please let me know.  This time I'll wait for a
>>> strong opinion before firing off patches.
>>>
>>> My opinion: yeah, v5's ([NO_]APPLE_COMMON_CRYPTO) was probably where
>>> we should have stopped painting.  Hindsight is 20/20.  Luckily it
>>> never left "pu".
>>
>> I could do this easily:
>>
>>     $ git checkout da/darwin ;# b72ac20a6f73b
>>     $ git format-patch --stdout -2 |
>>       sed -e 's|COMMON_DIGEST_FOR_OPENSSL|APPLE_COMMON_CRYPTO|g' >P.mbox
>>     $ git checkout HEAD^^ ;# 29de20504e
>>     $ git am P.mbox
>>     $ git diff da/darwin HEAD ;# sanity check
>>     $ git log da/darwin.. ;# sanity check
>>     $ git branch -f da/darwin
>
> That would lose the one legitimate COMMON_DIGEST_FOR_OPENSSL which
> needs to be defined before <CommonCrypto/CommonDigest.h> is included.

It probably is a good catch, but I'll stop reading patches and start
today's integration cycle (and will tag 1.8.3-rc3).

At this point, I think the best would be for you to reroll these two
patches, then after David reviews it and I'd re-queue the result
with

	... original commit message ...

        Reorginized use of Makefile variables and C preprosessor
        macros with help by Eric Sunshine.

	Signed-off-by: David
        Signed-off-by: Eric
        Signed-off-by: Me

or something.  Can you two help that?
