Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445DE203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 21:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbcKJVeI (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:34:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60722 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935542AbcKJVeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:34:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FD574F480;
        Thu, 10 Nov 2016 16:34:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDxxwkjhPAKFJXonAG1x22B5L18=; b=jYqTPp
        XsW8TrQCkdznN8X8ONT0JGyHcZmuc+PG3sq9TJBOoHhSBw4BeWjFcbNMhM39mjtJ
        lPa4XNZL8r7oyf2bpP4G/kIbUZanvjyMIzhrjCnCy0SkBnjAB/3THpR514a5jB53
        GupukQvIwckLa1hXJqm305j5iUe7XXCgyoxy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X5d22GIIJjlJQxj5wF99QLFjOitazz7Q
        figd3sNZAepr9XHXYaeb67O4Jqw3Z53C2btSfFCY7Eq0ypIuZsWRtLOziyi9KRR6
        khGcFh8ANzpi4jRHrFu9jIYaUEYPqPGYflZFdroONUB3vMU4jLeaooZSwkU8ktOE
        IK1ho2Zm0Bg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87A944F47F;
        Thu, 10 Nov 2016 16:34:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E78944F47E;
        Thu, 10 Nov 2016 16:34:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, tboegi@web.de
Subject: Re: [PATCH v1 0/2] Fix default macOS build locally and on Travis CI
References: <20161017002550.88782-1-larsxschneider@gmail.com>
        <xmqqwpgc6x4t.fsf@gitster.mtv.corp.google.com>
        <584C7DBA-71FE-4E66-85DC-EA22A6D2BB80@gmail.com>
Date:   Thu, 10 Nov 2016 13:34:04 -0800
In-Reply-To: <584C7DBA-71FE-4E66-85DC-EA22A6D2BB80@gmail.com> (Lars
        Schneider's message of "Thu, 10 Nov 2016 12:19:26 +0100")
Message-ID: <xmqqwpgb58ab.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 681207A2-A78D-11E6-9499-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> I've followed what was available at the public-inbox archive, but it
>> is unclear what the conclusion was.  
>> 
>> For the first one your "how about" non-patch, to which Peff said
>> "that's simple and good", looked good to me as well, but is it
>> available as a final patch that I can just take and apply (otherwise
>> I think I can do the munging myself, but I'd rather be spoon-fed
>> when able ;-).
>
> Sure! Here you go:
> http://public-inbox.org/git/20161110111348.61580-1-larsxschneider@gmail.com/
>
>
>> I do not have a strong opinion on the second one.  For an interim
>> solution, disabling webserver tests certainly is expedite and safe,
>> so I am fine taking it as-is, but I may have missed strong
>> objections.
>
> I haven't seen strong objections either. Just for reference, here is the patch:
> http://public-inbox.org/git/20161017002550.88782-3-larsxschneider@gmail.com/

Thanks.  Picked up both of them.

