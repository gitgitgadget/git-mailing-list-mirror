From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb.conf.txt: fix typo
Date: Tue, 31 Mar 2015 13:28:32 -0700
Message-ID: <xmqq4mp0rjwv.fsf@gitster.dls.corp.google.com>
References: <1396558187-5674-1-git-send-email-git-patch@agt-the-walker.net>
	<551A9BE9.3070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?SsOpcsO0bWU=?= Zago <git-patch@agt-the-walker.net>,
	git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:28:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd2mE-0008Pk-AU
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 22:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbbCaU2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 16:28:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755791AbbCaU2f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 16:28:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51C7445658;
	Tue, 31 Mar 2015 16:28:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oEj0d6K7Tis/
	MV3WfxoD99EswdQ=; b=Vs9TVEdFslvjx6IB/kPGWCk+dhOfBtGL0OMNGF8k6R86
	wtOZap17Ei5xcGCDAvh70USBDy1jL4OyZI62EQyYiI7QZjabBaUF9V0dPa4iJ2c7
	bOqEVypLXOOyzdmnmnNTKQkKZ4xkLBMptwH2UCJ/A4CGXVS49ZlWCx9kQjc3kIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QwYaBS
	UrRpjbCagjRfgEDwOO0/VrdVE7OTN7J5s2MFcnPmTxHEUoZybJDn8xU0AUsNO1Mq
	5ZrD/FActNcVOd2Ug7+RrWdXOQzW+eQaKgzyEJSPbAgGfAeKN9INAgpE8Syn+CVS
	KpMlU3XwXQK7LlNRKw1owsh0nbDDO52QGronU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38D8445657;
	Tue, 31 Mar 2015 16:28:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC8EE45656;
	Tue, 31 Mar 2015 16:28:33 -0400 (EDT)
In-Reply-To: <551A9BE9.3070907@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Tue,
	31 Mar 2015 15:06:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 808D3A10-D7E4-11E4-A47A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266553>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On 2014-04-03 at 22:49, git-patch@agt-the-walker.net wrote:
>> From: J=C3=A9r=C3=B4me Zago <git-patch@agt-the-walker.net>
>>
>> "build-time" is used everywhere else.
>>
>> Signed-off-by: J=C3=A9r=C3=B4me Zago <git-patch@agt-the-walker.net>
>
> You are right, it is variable set during build process,
> not after project is built.
>
> ACK (for what it is worth).
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Thanks; the patch is linewrapped but I can fix it up.

It is funny to see an ack to a patch that is almost a year old,
though ;-)

>
>> ---
>>   Documentation/gitweb.conf.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.co=
nf.txt
>> index 952f503..8b25a2f 100644
>> --- a/Documentation/gitweb.conf.txt
>> +++ b/Documentation/gitweb.conf.txt
>> @@ -482,7 +482,7 @@ project config.  Per-repository configuration
>> takes precedence over value
>>   composed from `@git_base_url_list` elements and project name.
>>   +
>>   You can setup one single value (single entry/item in this list) at=
 build
>> -time by setting the `GITWEB_BASE_URL` built-time configuration vari=
able.
>> +time by setting the `GITWEB_BASE_URL` build-time configuration vari=
able.
>>   By default it is set to (), i.e. an empty list.  This means that g=
itweb
>>   would not try to create project URL (to fetch) from project name.
>>
>>
