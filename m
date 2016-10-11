Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF301F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbcJKVjr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:39:47 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36456 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbcJKVjq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:39:46 -0400
Received: by mail-qt0-f179.google.com with SMTP id m5so4796022qtb.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=piKLPtu8pn7cskxLHYLlBFc8CwGt09fpXTz8VHLYgS0=;
        b=drc4CQbFQg89pRUBiVRjljS67PFStym6al52fVZw+Hkha6YbxRMy477PL6InXQMfOg
         hOLLSQ+gF7QWcjfPQOqY/hYKFu7D3g0sooChEHSlhb0QucI1nPMPz9DYRHLNJX4vvlF9
         dKoWuZXfn8rBiN3QDuvZlcCHyBkVugUMHnhUD60eTTlpdhDoALGyWiDh9FMFcqklJEVh
         lv4qSlzVKHRprxcCHKvhL6KbguhHVIeO0PZpVPw71wFz/FnBe3B03OFOMWajSmgAGiok
         sOr2tzuQOkRz6IqLnQg6BGWmmlxuogx8hT15TKhyCUsyr7n2Yp3xasOiS6eHaKPFShE7
         dT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=piKLPtu8pn7cskxLHYLlBFc8CwGt09fpXTz8VHLYgS0=;
        b=e3OUPr+dMq2F9XOcqZTgrYvPsENEJ41Gjc0WG/cQMIN5eWaBpgvLaL0hOT27eh8kDH
         duxSe1qjSrAYxW9FraI5nr5Mt5FKlCzhTVZ4hGPI/7OCRgoSIH73K5LsRrGep1xfTnin
         CnJUEG5kyPGw3o1DJOh/upzjG6VkUl5HtY5bd1EUSqsPVWQPLFNueB3Bju6kY6Otxkn+
         MTZlu4ukRFKNSYeepIs+8l7rwm++C3qiTNkCZFn93ytagsRVW8gqokuhftHzoqx0feb5
         J8co1bq58DHEVnUjup81c4I2EWkLp/8SEwD7FP2fsON2sO4rdZNRr009lvHfH45mR/CZ
         aKsA==
X-Gm-Message-State: AA6/9RmdVg2nbyQ9vxq10oL5Ss3wLWfBaVsRUL12MYtIt0AjvtedUSijkpwwPBrd0gHWJpkTuOSga65El5mqeNWo
X-Received: by 10.237.33.225 with SMTP id m30mr5690809qtc.61.1476221985850;
 Tue, 11 Oct 2016 14:39:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 14:39:45 -0700 (PDT)
In-Reply-To: <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com> <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 14:39:45 -0700
Message-ID: <CAGZ79kZGerbcQWmK0=OjJEH4DpYVFSEeRzR5TssPGunK-Lf0nw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 2:39 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Oct 11, 2016 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * sb/submodule-ignore-trailing-slash (2016-10-10) 2 commits
>>   (merged to 'next' on 2016-10-11 at e37425ed17)
>>  + submodule: ignore trailing slash in relative url
>>  + submodule: ignore trailing slash on superproject URL
>>
>>  A minor regression fix for "git submodule".
>>
>>  Will merge to 'master'.
>>
>
> Going by the bug report, this *may* be more than
> minor and worth merging down to maint as well, eventually.

and here is the actual bug report:

https://public-inbox.org/git/CAL4SumgJbrirymt5+iyNbpo++xXfzJZRiHDm8=0+eCArpCX=DA@mail.gmail.com/
