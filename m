Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D821F462
	for <e@80x24.org>; Fri, 26 Jul 2019 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfGZWCO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 18:02:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61242 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfGZWCO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 18:02:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 232CD151B14;
        Fri, 26 Jul 2019 18:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y/3xzUEvqvDw
        M0GvuTWOw33JNTs=; b=Z86qfkUu26Pkeb1KYpsEE3fJWbYgVbCKn8AgYKUolEcY
        9DnnmAVGnu9PtaP6pSidwNPPuN+RtUTTl6kBXo9IWtyDaJJtNTJRcISUxqiXOvtb
        8wxLjGRtm1mPiDd/RFhmvSj7WEZQ86Q9JGsixBdIky+FzJS+yV6N+nEjFy9ETFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Aq9FCm
        4CsxFafurJShIx3FluKTBsB3Pzk2yc5PX8dy4ZuaQdps9QQGJYAJU87w48iFNleB
        dlhAtnhC/YgR6Efwm2DXXIkzKg5yeEI1wX6HgRqD2jZItAQiuxVMIdES1Lv4dpKB
        fWXl5ejsT0MdB7ijCvgMQcIFYpu2Dft73jxrg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B983151B13;
        Fri, 26 Jul 2019 18:02:09 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77B11151B12;
        Fri, 26 Jul 2019 18:02:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Kuzmin <kuzmin.robin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to report issues or provide patches for the documentation IN OTHER LANGUAGES?
References: <CAAztzVEeX1H6ge0J=S1=zY5UMprzvYyDaL530-7yahhYCKOaog@mail.gmail.com>
Date:   Fri, 26 Jul 2019 15:02:07 -0700
In-Reply-To: <CAAztzVEeX1H6ge0J=S1=zY5UMprzvYyDaL530-7yahhYCKOaog@mail.gmail.com>
        (Robin Kuzmin's message of "Fri, 26 Jul 2019 14:12:51 -0700")
Message-ID: <xmqq8sskmp40.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 031285A6-AFF1-11E9-BBEE-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Kuzmin <kuzmin.robin@gmail.com> writes:

> At this page (in Russian)
>     https://git-scm.com/book/ru/v2/%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83=
%D0%BC%D0%B5%D0%BD%D1%82%D1%8B-Git-%D0%9F%D0%BE%D0%B4%D0%BC%D0%BE%D0%B4%D=
1%83%D0%BB%D0%B8
> I see:
>     =D0=B2=D1=8B =D1=80=D0=B0=D1=81=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B8=
=D0=BC
> I expected:
>     =D0=BC=D1=8B =D1=80=D0=B0=D1=81=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B8=
=D0=BC
> And I fail to find the exact file to fix. I fail to find a clear
> description of how to provide a fix/pull-request (or a least to report
> the issue).

I'll only respond to the "Subject" as I am not involved in that book
project.

1. Visit https://git-scm.com/book/ and find "The source of this book
   is hosted on GitHub.  Patches, suggestions and comments are
   welcome."  'hosted on GitHub' has link. Click.

2. We are taken to github.com/progit/progit2; among the list of
   files, I see CONTRIBUTING.md, which sounds promising. Click.

3. Very helpful notes about how the project expects contributions to
   them appear; at the end, there is Translations section, with a
   link to TRANSLATING.md. Click.

4. There seems to be a table that maps language to a separate
   repository.  -ru seems to map to https://github.com/progit/progit2-ru
   but I cannot even read the language and cannot grok the left hand
   side column of the table where it has the name of the language
   X-<.  Just guess, have faith and click.

5. There is a search box at the top of the page.  I blindly copy and
   paste "=D0=B2=D1=8B =D1=80=D0=B0=D1=81=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=
=B8=D0=BC" from your message and click "In
   this repository".  Then I change my mind and enclose the two-word
   search term inside a pair of double quotes and do the same.

6. I find only one instance of the combination of two words in the
   result.

I cannot read/understand much of the things I see during this
journey, but hopefully I helped you a bit?





