From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Wed, 27 Jan 2016 04:01:19 -0800
Message-ID: <xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 13:01:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOOms-0008BZ-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 13:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbcA0MBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 07:01:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751298AbcA0MBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 07:01:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65CAC39A26;
	Wed, 27 Jan 2016 07:01:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y1FdXbVNjh2DRc3wtAM9+ZF/KRY=; b=e5U/w2
	+1zlbQC3nZvPDb7Q9GLh2A93lidGNy1JIwQ5HPRzsGg8hl1UKubo0oXVK2H993C0
	sZ8YMc7q2n4PT69EgGGHwEQaCtkY87/BEv5FY/WkoPlJyh47ViChLWirB9T0/hYG
	zkDIWkAb2urhCK5TTDkv2lS9WB3tW+lVuLx7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZmnzKjyGMMzAOkgidCF1xnWxBQASKhT
	RQxE7oQ7PyO8bohuHFVOjGrjRw8kw4U4nAkF/XiLaiAlf7DErTPOJFPqpsDbXg/N
	Mk/3tPu6JowUBtsyWuX6fCxUQvvEDY1oU269YVjVvjLa3iSMuecn1Yc052SePaEj
	sLFLHmOCnSU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E24F39A25;
	Wed, 27 Jan 2016 07:01:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D328E39A24;
	Wed, 27 Jan 2016 07:01:20 -0500 (EST)
In-Reply-To: <CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 27 Jan 2016 16:14:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADEA57EE-C4ED-11E5-936B-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284910>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 27, 2016 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I spoke too soon, I am afraid.
>>> ...
>>> I wonder if this would be better done as a multi-part series that
>>> goes like this:
>>> ...
>>
>> So here is the first of the three-patch series to replace it.
>
> This is much better (the whole series, not just the first patch). We
> probably should add a test about help.autocorrect though, maybe in the
> first patch, because it's not tested at all in the test suite.

Patches welcome.  Thanks.
