From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [L10N] please review a batch l10n update for Git 2.2.0 final
Date: Fri, 21 Nov 2014 11:43:17 -0800
Message-ID: <xmqqioi8z6ei.fsf@gitster.dls.corp.google.com>
References: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
	<CAN0XMOLZw+btduQkQwMLykYFgFuZzTfMwnexyGR0FBdbG=qFmA@mail.gmail.com>
	<CANYiYbEt7r1Bjx9VA29Vk5FL9Qu0nTeXVZWAaggrcM=eNsY7Rg@mail.gmail.com>
	<CANYiYbH5-eDSkq8LQsyixMsDh6e9ZA7nTVib_GbdK5BQ6vE6OA@mail.gmail.com>
	<xmqqmw7l1nq5.fsf@gitster.dls.corp.google.com>
	<CANYiYbEa_p6q9iTS6Rys5dmZNhfZYngNFXGK-gYJFfzODg+B5g@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 21 20:43:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xru73-0001gZ-FM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 20:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbaKUTnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 14:43:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751629AbaKUTnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 14:43:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E32B6202C9;
	Fri, 21 Nov 2014 14:43:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VdJWT5aaQ0EO7n75zNaYhyrm7XM=; b=RW2Blb
	tiamuob2SSsOEnz87K7Q5w2taVpAfD/+RjdFx7yBqP2qIDsgYFjmv1fkI1Om8+NU
	gxo4DQupK1cbbI2d8+a0664NCLXyQZmUfY86TY7dv3bLDf6f/DImMhK+FK3Pdbgy
	tdLTGndSMPcqFFkiThqBwtYPymYoJT44YLjFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hf6SkFoGiQFz35s7sQxWn3aelaEnEHEC
	i9d9JLLupnYFMcs7VFIDQDjkZTSfJGbo74nMOi99rbGSUL/ubZ0I0vthih2qKlof
	avTXJTnRWVh6byT6z50UdCpwq5GQUvmEcOWfU0AxaTK1YJ8PIZbhaDYmBQ/xVgVB
	TR+gBdY1le4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6DDB202C8;
	Fri, 21 Nov 2014 14:43:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 415AD202C7;
	Fri, 21 Nov 2014 14:43:18 -0500 (EST)
In-Reply-To: <CANYiYbEa_p6q9iTS6Rys5dmZNhfZYngNFXGK-gYJFfzODg+B5g@mail.gmail.com>
	(Jiang Xin's message of "Fri, 21 Nov 2014 16:59:55 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A45E8C4E-71B6-11E4-B79C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> 2014-11-21 7:00 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>> I've pushed out what should be -rc3 minus l10n changes and try to
>> make sure there will be no N_() and _() changes.
>>
>> Let's do a 2.2-rc3 as the last round of this cycle tomorrow.  I've
>> fetched up to your 7ba2ba7 but haven't merged it yet, just in case
>> you will have further updates.  Otherwise, 2.2-rc3 will be what is
>> at the tip of 'master' today with 7ba2ba7 merged in.
>
>
> Hi Junio,
>
> Please pull the following changes since commit
> ca0107e279df1465946970113d68b4ee26ffbcc4:
>
>   Merge branch 'sv/submitting-final-patch' (2014-11-19 13:48:01 -0800)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po master
>
> for you to fetch changes up to 7ba2ba7d12163a8f9a9947d7880bd26f2970d4c5:
>
>   l10n: remove a superfluous translation for push.c (2014-11-20 16:23:43 +0800)

Thanks.  Done.
