Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFC61F516
	for <e@80x24.org>; Mon, 25 Jun 2018 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755710AbeFYU1j (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 16:27:39 -0400
Received: from dmz-mailsec-scanner-1.mit.edu ([18.9.25.12]:45556 "EHLO
        dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751949AbeFYU1i (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 16:27:38 -0400
X-AuditID: 1209190c-b5fff70000000b9f-40-5b3150390d2e
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 30.29.02975.930513B5; Mon, 25 Jun 2018 16:27:37 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id w5PKRaOk020953
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 16:27:37 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.18.248.31])
        (authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id w5PKRY1R003007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 16:27:35 -0400
Received: by darkmatter.mit.edu (Postfix, from userid 115)
        id 7C045354B50; Mon, 25 Jun 2018 16:27:34 -0400 (EDT)
Received: from [192.168.1.34] (209-6-198-183.s4021.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com [209.6.198.183])
        by darkmatter.mit.edu (Postfix) with ESMTPSA id 0A025354B4D;
        Mon, 25 Jun 2018 16:27:34 -0400 (EDT)
Subject: Re: [PATCH] Makefile: tweak sed invocation
To:     Eric Sunshine <sunshine@sunshineco.us>
Cc:     Git List <git@vger.kernel.org>, Dan Jacques <dnj@google.com>
References: <1529954005-18189-1-git-send-email-asedeno@mit.edu>
 <CAPig+cQxAxFUFE8j2O7iaZoAby9ioNd6Wf1OVAr5qU7kTrQOyQ@mail.gmail.com>
From:   =?UTF-8?Q?Alejandro_R=2e_Sede=c3=b1o?= <asedeno@mit.edu>
Message-ID: <2b532078-dcf6-f38a-bda8-8fb1ace8306c@mit.edu>
Date:   Mon, 25 Jun 2018 16:27:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQxAxFUFE8j2O7iaZoAby9ioNd6Wf1OVAr5qU7kTrQOyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixCmqrGsZYBht8HeTsUXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDLeNc1nLHjDVdF9YjFrA+Nv9i5GTg4JAROJTR+OMnUxcnEICSxm
        kti37zczhHOaUaLz42xWCOcNk8TMX7tZQFqEBIokHl7oZoNI3GSU2DtrJjNIQljAWGL9/wNg
        toiAlsSE5T1sIDazgIPE6jln2SEa2hglHjesZwJJsAnYScxbcgvM5hWwkrj/6jPYUSwCqhJr
        TzxgBLFFBaIkvu7oYoaoEZQ4OfMJ2BWcAoESn2eshlpgJjFv80NmCFtc4taT+UwQtrxE89bZ
        zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRNya3SzU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3E
        CA58SZ4djGfeeB1iFOBgVOLhXfHSIFqINbGsuDL3EKMkB5OSKG8as2G0EF9SfkplRmJxRnxR
        aU5q8SFGCQ5mJRFeu/1A5bwpiZVVqUX5MClpDhYlcd7sRYzRQgLpiSWp2ampBalFMFkZDg4l
        Cd79fkBDBYtS01Mr0jJzShDSTBycIMN5gIZb+QPV8BYXJOYWZ6ZD5E8xKkqJ8y4HaRYASWSU
        5sH1ghOT0A/5V4ziQK8I834GqeIBJjW47ldAg5mABpc9Brm6uCQRISXVwCgk4tYS5z759YQv
        n5nXXuPx/3765VENs4A1zKJvLh5VzLhuwa1efWHFjQf8hy5H6CsFcs4IecV8Z337bo7cgpO2
        Dv4bnYK9j15+4mHifzHjzt2auaeXXq2SFJ695sb3T8sNH06Q2fzIhUOoqdB2QuEZj5Uz+f8n
        p29wWXpDQLX8atHfDws3iX5WYinOSDTUYi4qTgQAJIL07ScDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-06-25 16:15, Eric Sunshine wrote:
> On Mon, Jun 25, 2018 at 3:18 PM Alejandro R. Sedeño <asedeno@mit.edu> wrote:
>> With GNU sed, the r command doesn't care if a space separates it and
>> the filename it reads from.
>>
>> With SunOS sed, the space is required.
> 
> MacOS and the various BSD's ship with BSD 'sed', not GNU 'sed', so it
> seemed prudent to check this change against them as well, which I did,
> and can report that it does not cause any regression on those
> platforms.
> 
> Therefore, the patch looks good. Thanks.

Thanks for checking on that, Eric. I tested MacOS locally before 
submitting as well. From a quick skim of the POSIX sed page, the space 
is expected, so this should be portable.

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

-Alejandro

> 
>> Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
>> ---
>> diff --git a/Makefile b/Makefile
>> @@ -2109,7 +2109,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
>>          $(QUIET_GEN)$(RM) $@ $@+ && \
>>          sed -e '1{' \
>>              -e '        s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>> -           -e '        rGIT-PERL-HEADER' \
>> +           -e '        r GIT-PERL-HEADER' \
>>              -e '        G' \
>>              -e '}' \
>>              -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \

