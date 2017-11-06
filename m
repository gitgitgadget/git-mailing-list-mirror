Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E804202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 07:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdKFHKD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 02:10:03 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:65324 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751092AbdKFHKC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2017 02:10:02 -0500
X-AuditID: 12074413-3a3ff70000007929-f8-5a000ac9caf3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 40.A5.31017.9CA000A5; Mon,  6 Nov 2017 02:10:01 -0500 (EST)
Received: from [192.168.69.190] (p57BCCA7E.dip0.t-ipconnect.de [87.188.202.126])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA679wr3013305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 6 Nov 2017 02:09:59 -0500
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org
Cc:     me@ikke.info, hjemli@gmail.com, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-3-rafa.almas@gmail.com>
 <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
 <b0e3856b-e627-0d22-90da-3da1781f98b3@gmail.com>
 <xmqq1sldmqms.fsf@gitster.mtv.corp.google.com>
 <xmqqshdtl057.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c1b9cb69-0fdf-a58c-62cc-343a6abdbb84@alum.mit.edu>
Date:   Mon, 6 Nov 2017 08:09:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqshdtl057.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqHuSiyHKYGq/rEXXlW4mi4beK8wW
        S2e9YbRYuWYPs8WrjnZGi+4pbxktPh28yeLA7rHybK3Hzll32T1+3X3J5nHxkrLH501yAaxR
        XDYpqTmZZalF+nYJXBlnLx5hK7giVtH9ZSN7A+MUoS5GTg4JAROJS69XsHQxcnEICexgkji5
        YRMzhHOeSeL1maNsXYwcHMICPhKz5yqBxEUEOhgllvbuYgXpZhaIlni9ci8TRMNaJonezr3s
        IAk2AV2JRT3NTCDNvAL2En3XwLaxCKhIHN72jA3EFhWIkHje/B5sDq+AoMTJmU9YQGxOAWuJ
        kw8eMkLMV5f4M+8SM4QtLnHryXwmCFteonnrbOYJjAKzkLTPQtIyC0nLLCQtCxhZVjHKJeaU
        5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbopaaUbmKERIPwDsZdJ+UOMQpwMCrx8C6Y8z9SiDWx
        rLgy9xCjJAeTkijvlZd/IoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8DqzMEQJ8aYkVlalFuXD
        pKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeKXYgBoFi1LTUyvSMnNKENJMHJwgw3mA
        hr9gBRleXJCYW5yZDpE/xajL8Wzm6wZmIZa8/LxUKXHePSBFAiBFGaV5cHNgSewVozjQW8K8
        YiDreIAJEG7SK6AlTEBLZnMAfcdbXJKIkJJqYEx/cl9oXrSve1PP2w1rX2zwXTav4cCfiX3/
        nWe/jSrUfi90tI/5s+y+ik7Rsnuxfcu4FypM0j5auiLuzs+HuoY/l3z4YmZvklzW/XfFoYnM
        y/P3fdbZl9JWlx4bNMVs9dWNTbmnxJc4Pk4sTLzNlv6K6WTgr5UKfXyrFybKF3sa6Kp8Ypny
        cbISS3FGoqEWc1FxIgBM4Ds4PQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05/2017 07:17 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Rafael Ascensão <rafa.almas@gmail.com> writes:
>> ...
>>> Because changing the default behavior of that function has
>>> implications on multiple commands which I think shouldn't change. But
>>> at the same time, would be nice to have the logic that deals with
>>> glob-ref patterns all in one place.
>>>
>>> What's the sane way to do this?
>>
>> Learn to type "--decorate-refs="refs/heads/[m]aster", and not twewak
>> the code at all, perhaps.  The users of existing "with no globbing,
>> /* is appended" interface are already used to that way and they do
>> not have to learn a new and inconsistent interface.
>>
>> After all, "I only want to see 'git log' output with 'master'
>> decorated" (i.e. not specifying "this class of refs I can glob by
>> using the naming convention I am using" and instead enumerating the
>> ones you care about) does not sound like a sensible thing people
>> often want to do, so making it follow the other codepath so that
>> people can say "refs/tags" to get "refs/tags/*", while still allowing
>> such a rare but specific and exact one possible, may not sound too
>> bad to me.
> 
> Having said all that, I can imagine another way out might be to
> change the behaviour of this "normalize" thing to add two patterns,
> the original pattern in addition to the original pattern plus "/*",
> when it sees a pattern without any glob.  Many users who relied on
> the current behaviour fed "refs/tags" knowing that it will match
> everything under "refs/tags" i.e. "refs/tags/*", and they cannot
> have a ref that is exactly "refs/tags", so adding the original
> pattern without an extra trailing "/*" would not hurt them.  And
> this will allow you to say "refs/heads/master" when you know you
> want that exact ref, and in such a repository where that original
> pattern without trailing "/*" would be useful, because you cannot
> have "refs/heads/master/one" at the same time, having an extra
> pattern that is the original plus "/*" would not hurt you, either.
> 
> This however needs a bit of thought to see if there are corner cases
> that may result in unexpected and unwanted fallout, and something I
> am reluctant to declare unilaterally that it is a better way to go.

There's some glob-matching code (somewhere? I don't know if it's allowed
everywhere) that allows "**" to mean "zero or one path components. If
"refs/tags" were massaged to be "refs/tags/**", then it would match not only

    refs/tags
    refs/tags/foo

but also

    refs/tags/foo/bar

, which is probably another thing that the user would expect to see.

There's at least some precedent for this kind of expansion: `git
for-each-ref refs/remotes` lists *all* references under that prefix,
even if they have multiple levels.

Michael
