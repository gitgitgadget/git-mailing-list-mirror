Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B923202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 03:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbdJ3DtF (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 23:49:05 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44813 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdJ3DtE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 23:49:04 -0400
Received: by mail-qt0-f196.google.com with SMTP id 8so14815610qtv.1
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tuTBK7CwXTndCA3BBMqt2M2WJxWJdhPppNBVq6fnG/A=;
        b=K/KrGCuUn2OlSlbkB3jwyCy3DFQ815bBTTtUVAq79mpD0WoYqfdp/ZNLmPK7a24+yQ
         mSe3e9YnSI31FY9UWxD6iqCN9DxmW9Fbjhslqo3J5pEtLWAUhVWAl6hmw3lnrCTFzmg6
         hWRN8Kuqevhv5urKOl9UOaO1/YTvKvucyxRvfQcd/2xV1I+/3lRko20lLGUigK1mAXWJ
         Ud6xE3ZQuWAJzQUXQW5DxoyryKk1zxJWTLFX3qnTiRRbOhKxgnzjclK755ELOauUh6Sz
         wqGiLkGIgXDDJTckSSbrz7bDiWxstkJTIES+uFDiiinasdP3xsy6KDw8EdpFmZRrVqcV
         4jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tuTBK7CwXTndCA3BBMqt2M2WJxWJdhPppNBVq6fnG/A=;
        b=uIwLlRLU0Xpakwi+qEijCbiP987yLAwS5RLwju1TbwMMQZSiUZfnlbMgtVqwvS9wiB
         sF81ZHi1NtqPmxIP5b3YzjUmqGPPsz7ThtLsqjW0fMuKXsmx/iJf0utwQ7IoLagU7Y22
         XOLYu77rdxY5PwFN0ZyvTa+quDkx8P5V0CvXJyF9F5HLDH3OSbZRi9qpq+jMHinXtrJZ
         elBPOBc0AfuMqJbPI4Bw2jcWCyy0qutMllHtuIqgPvIkelxzZBoCxs62EJksTBWIwgDO
         AA9324zYCVyDZ6BdA2vLx/yfLCDE00GROorMYQt/ZUHEv4gs8X197H4zgGXfbybwGvS5
         njzg==
X-Gm-Message-State: AMCzsaWU98/lo0No53We2MmO/EMetdYuZ7KdV1K2SyfpKuf17GA1qqZC
        I4UC5nwX45TWccg4aQuU1bWKeg16Wu/S0tgNYb4=
X-Google-Smtp-Source: ABhQp+S4k+UnmA6qGueUz5fha1VADkg1jISbtD3yx0bzDAPt8Hg8Dmn06kZTc3ncsdNS9xnnhtPDHfWjprFVe1VjDkw=
X-Received: by 10.200.35.248 with SMTP id r53mr11517714qtr.110.1509335343501;
 Sun, 29 Oct 2017 20:49:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sun, 29 Oct 2017 20:49:03 -0700 (PDT)
In-Reply-To: <874lqh8jwr.fsf@curie.anarc.at>
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-5-anarcat@debian.org>
 <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com> <874lqh8jwr.fsf@curie.anarc.at>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Oct 2017 23:49:03 -0400
X-Google-Sender-Auth: BHi0LxmGJekKwwSPqTMAilc2G48
Message-ID: <CAPig+cTJTK8jSA+_hr2A8=t6CQ+CTjTuzvA24NTTEPEhMy9Jrw@mail.gmail.com>
Subject: Re: [PATCH 4/4] remote-mediawiki: allow using (Main) as a namespace
 and skip special namespaces
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 10:11 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org>=
 wrote:
> On 2017-10-29 15:49:28, Eric Sunshine wrote:
>> On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupr=C3=A9 <anarcat@debian.o=
rg> wrote:
>>> +    foreach my $local_namespace (sort @tracked_namespaces) {
>>> +        my ($mw_pages, $namespace_id);
>>> +        if ($local_namespace eq "(Main)") {
>>> +            $namespace_id =3D 0;
>>> +        } else {
>>> +            $namespace_id =3D get_mw_namespace_id($local_namespace);
>>> +        }
>>> +        if ($namespace_id >=3D 0) {
>>
>> This may be problematic since get_mw_namespace_id() may return undef
>> rather than a number, in which case Perl will complain. Since the code
>> skips the $mediawiki query altogether when it encounters "(Main)", you
>> could fix this problem and simplify the code overall by simply
>> skipping the bulk of the foreach loop body instead of mucking around
>> with $namespace_id. For instance:
>>
>>     foreach my $local_namespace (sort @tracked_namespaces) {
>>         next if ($local_namespace eq "(Main)");
>>         ...normal processing...
>>     }
>
> Ah yes. I see your point but it doesn't actually skip the query when it
> encouters main ($namespace_id >=3D 0).

Ah, yes, you're right. My brain glossed over the '=3D' in '>=3D' for some r=
eason.
