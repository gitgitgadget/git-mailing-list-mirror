Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E835F20756
	for <e@80x24.org>; Tue, 17 Jan 2017 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdAQSea (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 13:34:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751081AbdAQSe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 13:34:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D59A55FAA8;
        Tue, 17 Jan 2017 13:34:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=08ztGtYdVnZmXdWSe1JHKqXh7MY=; b=fN9oVd
        pobIcRIAO+CFcfIbjfUgaU94YZ0Gg4Wp3vUDcWiIgxrudBXVH9cILF6RQQKIVuxH
        4cYtqQYPFMqEQ30NSRraJuDjJlLIXXybg0PvbVbtC95hK7Mfh/DMvNu4v/tW8NRu
        GGtdG5tCtQZWVrvOA0JF4USeiaybqgw6EUeQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LgnNRKi/MhABfwZrzUmG7BS+54aUov/Z
        THI2Xkwbuy/VDTiVKs5OkkKRQpkjW2NYcYF+F5Rz+trrBmElBGwGIA6Jq2/h8vza
        OHcZ20Bg01NaHWmfhGflFviTws3UYeM/q97pL/R89QLxmlFyyCltMcUccE0UamSk
        kV76f56+0WI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB20A5FAA7;
        Tue, 17 Jan 2017 13:34:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 219035FAA6;
        Tue, 17 Jan 2017 13:34:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     David Aguilar <davvid@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Janke <floss@apjanke.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitk pull request // was: Re: gitk: "lime" color incompatible with older Tk versions
In-Reply-To: <xmqqy3yba1jg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 15 Jan 2017 23:48:03 -0800")
References: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
        <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
        <20170113112043.j7nowdilolswyk2k@gmail.com>
        <20170114084825.lcecrbtxny3ntulf@gmail.com>
        <xmqq37gldp8g.fsf@gitster.mtv.corp.google.com>
        <20170116031706.GA3322@fergus.ozlabs.ibm.com>
        <xmqqy3yba1jg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
Date:   Tue, 17 Jan 2017 10:34:24 -0800
Message-ID: <xmqq4m0xpmbz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92EE9036-DCE3-11E6-9A3A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Paul Mackerras <paulus@ozlabs.org> writes:
>
>>> Paul, is it a good time to pull, or do you still have something not
>>> published yet that should go together with what you have already
>>> queued?
>>
>> I recently pushed out one more commit to update the Russian
>> translation from Dimitriy Ryazantcev.  The head is now 8fef3f36b779.
>> I have a couple more series that I am currently reviewing, but nothing
>> immediately ready to publish.  It would be a good time for you to do a
>> pull, since the "lime" color fix and the memory consumption fixes
>> should be helpful for a lot of people.
>
> Thanks.  I did want to get the memory consumption fix sooner rather
> than later, and this is very much appreciated.
>
> Pulled.

Hmph.  I am getting these:

        SUBDIR gitk-git
    Generating catalog po/sv.msg
    msgfmt --statistics --tcl po/sv.po -l sv -d po/
    po/sv.po:1388: duplicate message definition...
    po/sv.po:380: ...this is the location of the first definition
    msgfmt: found 1 fatal error
    make[1]: *** [po/sv.msg] Error 1
    make: *** [all] Error 2

Anybody else see this?
