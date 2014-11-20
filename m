From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [L10N] please review a batch l10n update for Git 2.2.0 final
Date: Thu, 20 Nov 2014 15:00:50 -0800
Message-ID: <xmqqmw7l1nq5.fsf@gitster.dls.corp.google.com>
References: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
	<CAN0XMOLZw+btduQkQwMLykYFgFuZzTfMwnexyGR0FBdbG=qFmA@mail.gmail.com>
	<CANYiYbEt7r1Bjx9VA29Vk5FL9Qu0nTeXVZWAaggrcM=eNsY7Rg@mail.gmail.com>
	<CANYiYbH5-eDSkq8LQsyixMsDh6e9ZA7nTVib_GbdK5BQ6vE6OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 00:01:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xraii-0005dU-RV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 00:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472AbaKTXA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 18:00:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756866AbaKTXAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 18:00:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E8A21F20D;
	Thu, 20 Nov 2014 18:00:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U4D+i7B1E1ob3sazx9Qbu3BKjb4=; b=ltESsz
	34qhIGU0vPjr/bsSLRdU1cdzwEm3rxPYzUFl7lFowwX9H/c8Bg73zdaxIUmMfQ0s
	9IQ9Ygqgja5BQRmjdNvZeEWZri/moTPA6xHPx9hFzz8hBcLlMN/6js9ch0253EsL
	CQJJG2Ot1xJpMIEJX+LIeORPaPWxFLiiJqmrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rM8Id6yo8sHqLnIXP3e496/bqmeJOV7U
	K9gc1RhFEHM6nAl4wzpbVVtAP3BK3CIavYTKBPURW7UTQkXBa4tbJqXIxEMwAwHX
	dkSCnpMVUEgW1G1uyfzy60YyJaB0khKVPGHIJ1r0W0puPReHcqrnUgg2Se4+1/JY
	5er7okxWwGc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 842841F20B;
	Thu, 20 Nov 2014 18:00:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2AAD1F209;
	Thu, 20 Nov 2014 18:00:52 -0500 (EST)
In-Reply-To: <CANYiYbH5-eDSkq8LQsyixMsDh6e9ZA7nTVib_GbdK5BQ6vE6OA@mail.gmail.com>
	(Jiang Xin's message of "Thu, 20 Nov 2014 16:30:44 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13D9EC8E-7109-11E4-AB8C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> 2014-11-20 16:04 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
>> 2014-11-20 14:31 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>>>>
>>>> NOTE for Ralf:  After I updated de.po, there are 3 fuzzies instead of one.
>>>> I can only fix one of them.
>>>>
>>>
>>> I just send a pull-request to you. It seems I have forgotten one git.pot update.
>>
>> Merged.  I also see a nice workaround in your commit.  It's a fix for the issue
>> you reported [1] yesterday on our side. ;-)
>>
>>      msgid "check"
>>     +msgstr "check|on-demand"
>>
>> [1]: http://www.spinics.net/lists/git/msg241964.html
>
> Another batch update:
>
> commit 7ba2ba7d12163a8f9a9947d7880bd26f2970d4c5
> ...

I've pushed out what should be -rc3 minus l10n changes and try to
make sure there will be no N_() and _() changes.

Let's do a 2.2-rc3 as the last round of this cycle tomorrow.  I've
fetched up to your 7ba2ba7 but haven't merged it yet, just in case
you will have further updates.  Otherwise, 2.2-rc3 will be what is
at the tip of 'master' today with 7ba2ba7 merged in.

Thanks.
