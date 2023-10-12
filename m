Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1496BCDB482
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379499AbjJLQU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379476AbjJLQUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:20:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB8CA
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:20:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FE343878D;
        Thu, 12 Oct 2023 12:20:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=UbEjlHhGAtHFRzzr3vsGyPlMoTGh84aHPY8nvj
        IJXNA=; b=exlCCmS2zuONqaLWOxcXHgN/TLpO+F/g1LKK3EGDIQZkhONTUdzwxD
        wYLp1xpOs4Q3JXuDOdzqI3TV3thardwYeoETdE7XY0i6LF5y7VVQViJXWnMhMmyQ
        UGXCEX03TOKFc5mX9bfGKkWY5xvGL9OBJrFEhGXjPVpr7qSTMixKg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 782863878C;
        Thu, 12 Oct 2023 12:20:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6C493878A;
        Thu, 12 Oct 2023 12:20:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Benson Muite <benson_muite@emailplus.org>
Cc:     Dorcas Litunya <anonolitunya@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy]Introduction and Problem while installing Git
In-Reply-To: <4c5fef38-a671-dd6b-4b10-a531e1ae254a@emailplus.org> (Benson
        Muite's message of "Thu, 12 Oct 2023 10:28:12 +0300")
References: <ZSeYzdx07Cj67lR4@dorcaslitunya-virtual-machine>
        <4c5fef38-a671-dd6b-4b10-a531e1ae254a@emailplus.org>
Date:   Thu, 12 Oct 2023 09:20:14 -0700
Message-ID: <xmqqmswnhkxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A441750-691B-11EE-8790-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Benson Muite <benson_muite@emailplus.org> writes:

> On 10/12/23 09:57, Dorcas Litunya wrote:
>> Hello everyone,
>> My name is Dorcas Litunya. I am excited to contribute to the git
>> community, I am a first time contributor through the Outreachy program.
>> I am excited to learn and grow through this project. I am currently
>> installing Git and I have been faced with this error once I run the make
>> command:
>> In file included from http.c:2:
>> git-curl-compat.h:3:10: fatal error: curl/curl.h: No such file or directory
>>     3 | #include <curl/curl.h>
>>       |          ^~~~~~~~~~~~~
> You will need to have curl libraries and development headers.
> https://curl.se/libcurl/
> You maybe able to get these from a package manager, for example on Ubuntu
> sudo apt-get install curl-dev
> Fedora
> sudo dnf install libcurl-devel

Thanks for helping.  Perhaps reading the INSTALL file at the top of
the working tree would worth the time?

