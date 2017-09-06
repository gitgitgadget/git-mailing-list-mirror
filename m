Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34127208CD
	for <e@80x24.org>; Wed,  6 Sep 2017 11:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbdIFL7k (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 07:59:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:62966 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdIFL7j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 07:59:39 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MMb9i-1dq8pG19ri-008LHU; Wed, 06 Sep 2017 13:59:32 +0200
Subject: Re: [PATCH] name-rev: change ULONG_MAX to TIME_MAX
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <ef9aebb63227c36b8b72a65240a416a0271cc618.1504086318.git.git@grubix.eu>
 <xmqqbmmo8pp6.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <michael@grubix.eu>
Message-ID: <6a4cbbee-ffc6-739b-d649-079ba01439ca@grubix.eu>
Date:   Wed, 6 Sep 2017 13:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmmo8pp6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kGlKkDneoF4bKOvuhF+/n91JYEfxe73WhRig1pl8nfcBtJ/T9aX
 73Vue4X5pjZjCgyDhxvHSS7omni6D5Rsno6Cildl2VUim/pQRsk4gJOcvHt5FxOnSkRuW39
 DYXxJytRBevqS3pVOMPKiOnAyErew2PUg/2Uhr7rwlRoP3YQg6ShP4Yy9raP9Mlj1/RUV7M
 c6E0ZvrSA9RFtFZOIII7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EhIs9LeOiME=:DLh77uFtz3X3S7f3iEXdFf
 qDkPTxrQImt744VkK1PSuVamsueWM383CPBAsty7VowXmcqESxrBlJjGzNeu4+Mtw1SPkuiv5
 De+RGb9c4UZ2/fA4ebwbtGiYf2nwFzaCRgWyzGx8Iqm/oiynFGra6R9AoFCw+FttE1C6jhHRx
 d6rOENTXoRgsLMKtFpyLN80NHzMyUO7DGykrETpdJ/D+ZmOu/FYFz2EVGT9i9pkwfETMHz+Sy
 RB4qVTw43SdMe16f3JQyf8s2lVeJFhujJXZ7TYlw/vBj0KpRAA4AF9MRd4Gh3H1z5el4Y/BQg
 bYAlfysE31Bnv4Y6o79EMbsV7RJ9oTFFRj/cg6/7lWCFe1uKsK5lqul0JI96ubtD09ihm/AAV
 +xFJzGYw0urWli0W18NsijXrlPLPQZp4rR9fativb62mumGZBD0r88kJ8d5BfCnThEqpKEFza
 BCDp7PEs8f/2vIUi/D0JK8h7cKLH209ixitzh03Nqp0JmlTiZpdx/ugHMU3cXdzqEr8nEhXDL
 jf33ilShMINEbJ5dT3zTtMi0lTUqEOe5aIQxNymyk3QOenOkbLoxKwLvtynp+OnLIeZwy9B9s
 2d8knyg+fH4rtQPOhdeJozFD/lu1Iu4WwK17yxzd/1oUL5XeqH2JmcwhVz6aNrCReYLBswRdd
 aacnf7ofVvU3OC0Q9bHNke3bIPHaGLz7+EtmfBqGJbpDk5OMLJCdJFUD22zt2jJgl4znY6b6d
 hHXSdNjJBOjs789J3X5YT/6EvEqW6KMXMksXPbT3bwRCGC36//G9+X5/26I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 06.09.2017 05:35:
> Michael J Gruber <git@grubix.eu> writes:
> 
>> Earlier, dddbad728c ("timestamp_t: a new data type for timestamps",
>> 2017-04-26) changed several types to timestamp_t.
>>
>> 5589e87fd8 ("name-rev: change a "long" variable to timestamp_t",
>> 2017-05-20) cleaned up a missed variable, but both missed a _MAX
>> constant.
>>
>> Change the remaining constant to the one appropriate for the current
>> type
>>
>> Signed-off-by: Michael J Gruber <git@grubix.eu>
>> ---
> 
> Thanks.
> 
> I think this (and the earlier 5589e8) was caused by an unnoticed
> semantic conflict at 78089b71 ("Merge branch 'jc/name-rev-lw-tag'",
> 2017-05-30).  Merging is sometimes hard ;-)

Simple merges and semi-simple merges...

BTW, there's more fallout from those name-rev changes: In connection
with that other thread about surprising describe results for emacs.git I
noticed that I can easily get "git name-rev --stdin" to segfault there.
As easy as

echo bc5d96a0b2a1dccf7eeeec459e40d21b54c977f4 | git name-rev --stdin

for example.

That's unfortunate for the use-case of name-rev to amend git log output.

The reason seems to be that with "--stdin" or "--all", "name-rev" walks
and names all commits before beginning to use that those names for even
a single commit as above.

That segfault bisects to the logic changing commit in
jc/name-rev-lw-tag, but I think the changed logic simply leads to more
xmallocs() the segfault sooner now. Or something that I dind't spot even
after a few hours.

On the other hand, nearly every time that I try to understand describe
or name-rev I want get rid of insert_commit_by_date() and the like and
replace this by generations, and maybe a simple rev-walk (per ref)...

> Will queue.
> 
>>  builtin/name-rev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index c41ea7c2a6..598da6c8bc 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -253,7 +253,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>>  		struct commit *commit = (struct commit *)o;
>>  		int from_tag = starts_with(path, "refs/tags/");
>>  
>> -		if (taggerdate == ULONG_MAX)
>> +		if (taggerdate == TIME_MAX)
>>  			taggerdate = ((struct commit *)o)->date;
>>  		path = name_ref_abbrev(path, can_abbreviate_output);
>>  		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
