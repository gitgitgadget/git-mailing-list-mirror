Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F621F6BF
	for <e@80x24.org>; Wed,  7 Sep 2016 04:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbcIGEcO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 00:32:14 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46804 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751093AbcIGEcN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 00:32:13 -0400
X-AuditID: 12074412-1c3ff70000000931-37-57cf98483892
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 89.DE.02353.8489FC75; Wed,  7 Sep 2016 00:32:11 -0400 (EDT)
Received: from [192.168.69.190] (p57907A20.dip0.t-ipconnect.de [87.144.122.32])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u874W42H003515
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 7 Sep 2016 00:32:05 -0400
Subject: Re: [PATCH v2 02/38] rename_ref_available(): add docstring
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
 <f89d56ef0841a3cc35689436c0b9473c6773d22d.1473003902.git.mhagger@alum.mit.edu>
 <236a95a0-59d4-3788-9104-5ca299119e66@gmail.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8a13500c-55a0-a069-4b69-a651c218ded5@alum.mit.edu>
Date:   Wed, 7 Sep 2016 06:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <236a95a0-59d4-3788-9104-5ca299119e66@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqOs943y4QfcOA4v5m04wWnRd6Way
        aOi9wmyx4uocZoslD18zW3RPecto8aOlh9li5lVrizNvGhkdOD12zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8eC5/fZPT5vkgvgiOKySUnNySxLLdK3S+DKuH4mtWAyT8XL+3ENjNc5
        uxg5OSQETCQWz13F3MXIxSEksJVR4lvrREaQhJDAOSaJM3t0QWxhAWeJfw3zmUFsEYFkiSP7
        37JANOxmlGictgGsm1lgH5PEuTuP2UCq2AR0JRb1NDOB2LwC9hIHmy6wgNgsAioSr17sApsk
        KhAi0b5sPVSNoMTJmU+Aajg4OAVsJV6dKAAJMwuoS/yZd4kZwpaXaN46m3kCI/8sJB2zkJTN
        QlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIJAjtYFx/Uu4QowAH
        oxIP74W958KFWBPLiitzDzFKcjApifJunXQ+XIgvKT+lMiOxOCO+qDQntfgQowQHs5II7zyQ
        HG9KYmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwMB4eSBK/odKBGwaLU9NSKtMyc
        EoQ0EwcnyHAeoOE2IDW8xQWJucWZ6RD5U4yKUuK8zSAJAZBERmkeXC8sUb1iFAd6RZi3FqSK
        B5jk4LpfAQ1mAhq8bvdpkMEliQgpqQbGfctS2DYsXpT1UWbGOUc9h8jpUh+XOVbPykoXz4zR
        vMQT9Mj07mHziit9RxWexF3nEs/Ysqyrln85t57eixsR+2abHr37VtY67BX78fk/FZVf7dkS
        8lB+VnHfkUDz2+uelLbqPGDPZVD6/1iDU1D6/vIXzsbeHh852l/U2qVZLhNJyXNuiD2nxFKc
        kWioxVxUnAgAi70Yqi8DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2016 04:25 PM, Jakub Narębski wrote:
> W dniu 04.09.2016 o 18:08, Michael Haggerty pisze:
> 
>> +/*
>> + * Check whether an attempt to rename old_refname to new_refname would
>> + * cause a D/F conflict with any existing reference (other than
>> + * possibly old_refname). If there would be a conflict, emit an error
>> + * message and return false; otherwise, return true.
>> + *
>> + * Note that this function is not safe against all races with other
>> + * processes (though rename_ref() catches some races that might get by
>> + * this check).
>> + */
>> +int rename_ref_available(const char *old_refname, const char *new_refname);
> 
> Just a sidenote: does Git have a naming convention for query functions
> returning a boolean, for example using is_* as a prefix?

I've never heard of an official convention like that, and don't see it
documented anywhere. But there are a lot of functions (and variables)
whose names start with `is_`, and it seems like a reasonable idea.

> That is, shouldn't it be
> 
>   int is_rename_ref_available(const char *old_refname, const char *new_refname);

I agree, that would be a better name.

But that naming change is orthogonal to this patch series, which only
adds a docstring to the function. I don't think it's worth rerolling
this 38-patch series to add it. So I suggest that we keep your idea in
mind for the next time this code is touched (or feel free to submit a
patch yourself, preferably on top of this patch series to avoid conflicts).

Thanks,
Michael

