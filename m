Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89EC1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 06:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbcIHGmQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 02:42:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55238 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752676AbcIHGmP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Sep 2016 02:42:15 -0400
X-AuditID: 1207440d-be3ff700000008af-1b-57d1084583b4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id DC.7C.02223.54801D75; Thu,  8 Sep 2016 02:42:14 -0400 (EDT)
Received: from [192.168.69.190] (p57907CC2.dip0.t-ipconnect.de [87.144.124.194])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u886g9F5016207
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 8 Sep 2016 02:42:10 -0400
Subject: Re: [PATCH v2 00/38] Virtualization of the refs API
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
 <xmqqmvjjldp2.fsf@gitster.mtv.corp.google.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <7aac9c43-b8fc-c6fa-6311-4ff7a5495464@alum.mit.edu>
Date:   Thu, 8 Sep 2016 08:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvjjldp2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1HXjuBhucHOdiUXXlW4mi4beK8wW
        Sx6+ZrbonvKW0eJHSw+zxcyr1hZn3jQyOrB77Jx1l92jq/0Im8ez3j2MHhcvKXvsX7qNzWPx
        Ay+Pz5vkAtijuGxSUnMyy1KL9O0SuDKmnP7GVrBHtOLMg9msDYxHBLsYOTkkBEwkOi5sY+li
        5OIQEtjKKLHp/1tGCOc8k8Tbr9fYQaqEBWwk9n+6wApiiwioSUxsO8QCYgsJZEhs7dgGVsMs
        MJVJondxNojNJqArsainmQnE5hWwl/i2uw/MZhFQkfh/+TpYvahAiET7svVQNYISJ2c+AZvJ
        KWAt0di9mhlipp7Ejuu/WCFseYntb+cwT2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClO
        TdYtTk7My0st0jXSy80s0UtNKd3ECAl33h2M/9fJHGIU4GBU4uHlkL4QLsSaWFZcmXuIUZKD
        SUmU16cYKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEV4btYrgQb0piZVVqUT5MSpqDRUmcV22J
        up+QQHpiSWp2ampBahFMVoaDQ0mCt5IdqFGwKDU9tSItM6cEIc3EwQkynAdo+BWw4cUFibnF
        mekQ+VOMilLivEdBEgIgiYzSPLheWDp6xSgO9IowLwvICh5gKoPrfgU0mAlosNCp8yCDSxIR
        UlINjJ5/1zz2jnvWm6R2Q9m54O/+wisPddpfLPwd8jf81GTffTvDcq8HsvrUzbvLq/4msOvy
        V5OGoDz5tBOamXqdqRv/zvNoU7wd5hzklGSx0llPteyUl+E+jxe2rtvEuVduuHXT8pPYDc0o
        Yf96d1VzyUuL6mYt/R7jM0X0UWxp2ILvN27t/n2lWYmlOCPRUIu5qDgRAK2K49oiAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07/2016 09:20 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This is v2 of the patch series to virtualize the references API
>> (though earlier patch series similar in spirit were submitted by
>> Ronnie Sahlberg and David Turner). Thanks to Junio, Eric, and Ramsay
>> for their comments about v1 [1].
>>
>> Nobody pointed out any fundamental problems with v1, but this version
>> includes the following improvements:
> 
> Curiously, many of these improvements were already in 'pu'.

I pushed some of these changes to GitHub a while ago and mentioned that
fact on the mailing list [1]; I assume you fetched from there. But I was
waiting for the dust to settle from the earlier patch series and the
2.10 release before sending them to the mailing list again.

>> * In "refs: add methods for reflog":
>>
>>   * Don't export `files_reflog_iterator_begin()` (suggested by
>>     Ramsay).
> 
> This I can see was missing in what has been in 'pu'.

And according to your "What's cooking", you were waiting on this change
before proceeding.

FYI: I haven't done significant work on any next steps, which IMO could
go in many possible directions:

* Splitting loose and packed refs storage into two separate ref_store
subclasses that are joined together using some kind of
overlay_ref_store. This is not necessarily a blocker for the following
ideas, but the overlay_ref_store would make it easier to construct other
hybrid ref-stores, as for example the ubiquitous "most references are
stored in main repo; per-worktree refs are stored in worktree".

* Implementing reference caching as a ref_store that "writes through"
changes to a backing reference store. This is also not a blocker for
other ideas, but it would allow reference caching easily to be turned
on/off for other reference stores (or even disabled for packed/loose
reference storage during command invocations that know they won't have
to iterate over references more than once).

* A variant of loose reference storage that encodes the reference names
somehow before turning them into filenames (1) to make refnames
independent of filesystem path-name encoding issues, and (2) to
eliminate D/F conflicts, thereby allowing reflogs to be retained after a
reference is deleted.

* A reference backend based on LMDB (or any other key-value store).

* A reference backend based on Shawn Pearce's RefTree proposal or
something like it [2].

It's uncertain when I'll next have a chunk of time to work on any of these.

Michael

[1] http://public-inbox.org/git/575990FB.5000908@alum.mit.edu/
[2]
http://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/t

