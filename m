Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4BA1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 21:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbdAXV7F (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 16:59:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62758 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751003AbdAXV7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 16:59:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46674635AE;
        Tue, 24 Jan 2017 16:59:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g2iFJ4Y6O8UuMLdzKe7dOC8HwsA=; b=jyKLfn
        GeUlrqt6xuRqxKNpDgnwSXvzLjHTeXnFPDb3/m/EumPsFXATwY1wBj7WsZTetVef
        WMiWVvR87cahidRvsYRsBLZqqgRS0qlZHGZZmk1xFhN9kVFYSnfN/UhPzXQL/DVF
        UwjImCiOVzIFNGWBJuwHvgMrE+dF2byIzat7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xuJUSEC4PHd47i2Avv3dSUebTz00kNRl
        tROlKgqxkuNpcdSfWXNA39CqsNE0uoTpKIDBCZFo9ocYzhHml3+2VzeqrLP4HP/+
        QWdXdLVdBr5fR/oMKej14SwJGBJUS7FJF+sWtZlePMqOqBWY7UciM4zclX55NVMe
        J0WhAnELTEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E4FA635AD;
        Tue, 24 Jan 2017 16:59:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C15C635AC;
        Tue, 24 Jan 2017 16:59:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #03; Thu, 19)
References: <xmqqtw8uy62m.fsf@gitster.mtv.corp.google.com>
        <1929244236.1844627.1485284187492.JavaMail.open-xchange@app04.ox.hosteurope.de>
Date:   Tue, 24 Jan 2017 13:59:01 -0800
In-Reply-To: <1929244236.1844627.1485284187492.JavaMail.open-xchange@app04.ox.hosteurope.de>
        (Thomas Braun's message of "Tue, 24 Jan 2017 19:56:27 +0100 (CET)")
Message-ID: <xmqqh94oce6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5126B3F2-E280-11E6-947D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

>> * rh/mergetool-regression-fix (2017-01-10) 14 commits
>>   (merged to 'next' on 2017-01-10 at e8e00c798b)
>>  + mergetool: fix running in subdir when rerere enabled
>>  + mergetool: take the "-O" out of $orderfile
>>  + t7610: add test case for rerere+mergetool+subdir bug
>>  + t7610: spell 'git reset --hard' consistently
>>  + t7610: don't assume the checked-out commit
>>  + t7610: always work on a test-specific branch
>>  + t7610: delete some now-unnecessary 'git reset --hard' lines
>>  + t7610: run 'git reset --hard' after each test to clean up
>>  + t7610: don't rely on state from previous test
>>  + t7610: use test_when_finished for cleanup tasks
>>  + t7610: move setup code to the 'setup' test case
>>  + t7610: update branch names to match test number
>>  + rev-parse doc: pass "--" to rev-parse in the --prefix example
>>  + .mailmap: record canonical email for Richard Hansen
> ...
> Sorry for asking a maybe obvious question.
> Will that be merged into maint as well?

A good way to tell is to compare outputs from these two:

    $ git log --first-parent maint..$tip_of_the_topic
    $ git log --first-parent master..$tip_of_the_topic

I actually wasn't planning to.  We (or distro packagers) may want to
cherry-pick the essential bits from the topic and backport to 'maint'.

