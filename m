Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8658B207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 01:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbcJDBU4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 21:20:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57527 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751495AbcJDBU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 21:20:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8967E43AF6;
        Mon,  3 Oct 2016 21:20:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kYKuT5UcSgS6NMBFrq7+3nmsUHc=; b=QWIfUn
        T7kZzujnRUDX0WJXTqB6tWVYlCS5PR+AQbszsTbtmeMzRN8X2jaz3oVN20eT61PM
        vAT/wmc4tSfEgJp4IOg89DabOtu5I/9IxUTmW+tHMBLs2+anGRRvAbwbJdUPKAHH
        0GjHF7mZrGNoYHmE8hKClAxwGUvD6obE0d6Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QKVJOLMhp2ulRzcjovHlvO88Dx8Sfb2m
        a0d11PQftiTAm16ZteYVmoMblZZYdhqHvSFh3TP16FAgyVi7Fw9JIK5e7FILMAsU
        WD4NuARL1G5HmeWshDnx18hc7a7UwaysnboekbS7x6x6ZJCPiOxWiBlUc6pE67Yn
        Ty//rQmcKTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 812AB43AF5;
        Mon,  3 Oct 2016 21:20:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED5F743AF4;
        Mon,  3 Oct 2016 21:20:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
        <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
        <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
        <87int9x1lp.fsf@red.patthoyts.tk>
        <xmqq60p98kym.fsf@gitster.mtv.corp.google.com>
        <xmqq7f9p6xh8.fsf@gitster.mtv.corp.google.com>
        <87mvilt4jg.fsf@red.patthoyts.tk>
Date:   Mon, 03 Oct 2016 18:20:51 -0700
In-Reply-To: <87mvilt4jg.fsf@red.patthoyts.tk> (Pat Thoyts's message of "Tue,
        04 Oct 2016 00:07:47 +0100")
Message-ID: <xmqqfuoc52q4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB631E5C-89D0-11E6-9FD9-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> I've tried to merge in these branches as they appear in your version
> although I already had one patch on top of 0.20.0 for some time. I've
> tentatively pushed this up to http://github.com/patthoyts/git-gui as
> branch 'pu' with additional stuff on top of the patches you already
> have. If this looks ok to you I'll merge this to my master and send you
> a merge request to get it all synchronized.

Your 64c6b4c507 matches what I expected to see as the result of
merging the above four topics on top of your 'master'.  I have no
opinion on the other topics that appear on top of it on the branch
you pushed out, other than that I trust the maintainer of the
subsystem and I'm fine to blindly pull them from you ;-)

I am not sure if f64a1a9311 ("git-gui: maintain backwards
compatibility for merge syntax", 2016-10-04) makes any practical
difference in the real world, though.  You'd need to find somebody
who grabs the newer version of git-gui that includes b5f325cb4a
("git-gui: stop using deprecated merge syntax", 2016-09-24), without
having updated their copy of git-core for more than a year, given
that 2.5.0 is from July last year.  It would not hurt, but I am not
sure if an extra invocation of "git version" is really worth it.

Thanks.

