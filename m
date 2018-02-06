Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897841F576
	for <e@80x24.org>; Tue,  6 Feb 2018 09:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeBFJZb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 04:25:31 -0500
Received: from mail.javad.com ([54.86.164.124]:60746 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752207AbeBFJZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 04:25:28 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A495B3E89D;
        Tue,  6 Feb 2018 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517909127;
        bh=N2X1480SP7lplVXWn9m3mo1xMk8oJUCikiMkju+2XRo=; l=675;
        h=Received:From:To:Subject;
        b=K5FDY0ggwsXSJ8l0CAGQm/Ut/pmA3SyDGoIp9sdT8QT+C7cNyvuIYS5n4CeIJAncO
         02Nt0APcisdZKC6H6wCsQ4cgvtZjrVESwNE04a1E/uxNTW4GfUHK7gGp+e4bQVFLSI
         t2EtJ3HOkoTM01a/LAMjYImZQzrAT2eVjn8KeiZg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517909127;
        bh=N2X1480SP7lplVXWn9m3mo1xMk8oJUCikiMkju+2XRo=; l=675;
        h=Received:From:To:Subject;
        b=K5FDY0ggwsXSJ8l0CAGQm/Ut/pmA3SyDGoIp9sdT8QT+C7cNyvuIYS5n4CeIJAncO
         02Nt0APcisdZKC6H6wCsQ4cgvtZjrVESwNE04a1E/uxNTW4GfUHK7gGp+e4bQVFLSI
         t2EtJ3HOkoTM01a/LAMjYImZQzrAT2eVjn8KeiZg=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eizVG-0007qO-2a; Tue, 06 Feb 2018 12:25:26 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: cherry-pick '-m' curiosity
References: <87wozry7z4.fsf@javad.com>
        <CAGZ79kZ5ZiETM7L6DRr1pSXMGBPPyOazsM8Gi0E9jrMYfwrfdA@mail.gmail.com>
Date:   Tue, 06 Feb 2018 12:25:26 +0300
In-Reply-To: <CAGZ79kZ5ZiETM7L6DRr1pSXMGBPPyOazsM8Gi0E9jrMYfwrfdA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 5 Feb 2018 14:03:12 -0800")
Message-ID: <87eflyv5a1.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Feb 5, 2018 at 3:46 AM, Sergey Organov <sorganov@gmail.com> wrote:
>> Hello,
>>
>> $ git help cherry-pick
>>
>> -m parent-number, --mainline parent-number
>>            Usually you cannot cherry-pick a merge because you do not
>>            know which side of the merge should be considered the
>>            mainline.
>>
>> Isn't it always the case that "mainline" is the first parent, as that's
>> how "git merge" happens to work?
>>
>> Is, say, "-m 2" ever useful?
>
> Say you want to backport everything except that topic using cherry-picks.
> Then -m2 would be useful?

Didn't get the idea, sorry. Care to clarify?

-- Sergey
