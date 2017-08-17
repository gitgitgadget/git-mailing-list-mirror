Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D5420899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbdHQVj3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:39:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34772 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753326AbdHQVj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:39:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id p14so1861730wrg.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oMtK8msBw40Yl/XCN4toNVa/OipJzUWEwdWVWsPIub8=;
        b=vSc+yBhYGEH/bRb7Dp31dNhKOoGu/hye9UGvjfE6E67u4/5LxatWOOCxXTM7fbUyl7
         Vb/DyEcXHll5DHJU9vf4w1V8Hr+gG9B79MSfZv2WTya7c0GVlqs2VF8pVYrLcuDAg0x2
         morWngvFlzB0ONmJ1hLS3MAFp/JYWEn4hzhXY3HqCXHlUCampBF1J1g/07ytRE5DJJFx
         LWjq7bdWZlZPzT2MKfSmYfpXovztUtbm5eC3ERJJbxquYP4zYcGR/VakuFn29aq80Beh
         KE9hbciNQTSk1MSSMHp++U4F+hsN5Hh2liYGWZufWOOGobSw9IpC882yWdoiVxduG4YR
         SRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oMtK8msBw40Yl/XCN4toNVa/OipJzUWEwdWVWsPIub8=;
        b=JfVXYgdZffDM2tqd1XuZUcboOAfVZiKGYL8PGNOJytinoalTd1XL0FEsujk9XKtc+Q
         jZaSXYNq4d3VS21x6jzYm3WlM+6s0g8ByYjOa2SKku6s9tf/IBBYORs4KEyRn1rrmTFV
         Szqo0RBof6H7scPTJ/5iY6PXd7nOTTFmpcwR9UqpDNQcSzGHYAvFc9Hl1VshGjxd8G5R
         Tjdn0pw8fZ6bQb5vNMjy2vYwt7ga5Ec/0j6sv67Q3OyI76B3oOzjrtnID06aYzGul6bh
         zGsPMTUk9XmpXw6LIjXcdLUiiWp2q1kDv5CV5LhB2OAQaTxK3uG41rVWknAHh6GCFGOZ
         Ta6Q==
X-Gm-Message-State: AHYfb5hvPQpw96BH+l+uBST7y0aMPPF0nB21SNWuchmVneEC8AfZoxME
        VVldE8bBTIaZPhfh8ubnBPi/1PbEfA==
X-Received: by 10.223.161.214 with SMTP id v22mr4168513wrv.135.1503005967015;
 Thu, 17 Aug 2017 14:39:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Thu, 17 Aug 2017 14:38:56 -0700 (PDT)
In-Reply-To: <xmqq7ey1gai3.fsf@gitster.mtv.corp.google.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
 <CAGZ79kaCtbuDEUJqJ+nVUW78ksLMyHZ2xhnbunUqzjkGRuYg+A@mail.gmail.com>
 <CAJfL8+QreNvRqVZ0t1Sw=+o4nFK6WuvuOWix_C0MNFik6Cc+rA@mail.gmail.com>
 <20170816225901.dbpzvsie2zgetunu@genre.crustytoothpaste.net>
 <20170817055516.4zz3ucvx4mgr6qus@sigill.intra.peff.net> <xmqq7ey1gai3.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Thu, 17 Aug 2017 23:38:56 +0200
X-Google-Sender-Auth: etZh0RaOT1_NimeFtsqwJEz-mOI
Message-ID: <CAJfL8+T0sC9TnYfdut1nqiE9e2misnjK6X0WFDkj-mPcuKB4Tw@mail.gmail.com>
Subject: Re: [PATCH 3/5] commit: replace the raw buffer with strbuf in read_graft_line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In fact, the former is already how we represent the list of fake
> parents in the commit_graft structure, so I think patch 5/5 in this
> series does two unrelated things, one of which is bad (i.e. use of
> parse_oid_hex() is good; turning the FLEX_ARRAY at the end into a
> oid_array that requires a separate allocation of the array is bad).

Agreed; I already split patch 5 into two separate changes (one fixing
memory allocation issue, one parsing object_ids into FLEX_ARRAY,
without modifying graft struct). In result patch 4 (free_graft) can
be dropped. I will send these changes as v3.


On Thu, Aug 17, 2017 at 11:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I'd expect most of the GIT_MAX constants to eventually go away in favor
>> of "struct object_id", but that will still be using the same "big enough
>> to hold any hash" size under the hood.
>
> Indeed.  It is good to see major contributors are in agreement ;-)
> I'd expect that an array of "struct object_id" would be how a fixed
> number of object names would be represented, i.e.
>
>         struct object_id thing[num_elements];
>
> instead of an array of uchar that is MAX bytes long, i.e.
>
>         unsigned char name[GIT_MAX_RAWSZ][num_elements];
>
> In fact, the former is already how we represent the list of fake
> parents in the commit_graft structure, so I think patch 5/5 in this
> series does two unrelated things, one of which is bad (i.e. use of
> parse_oid_hex() is good; turning the FLEX_ARRAY at the end into a
> oid_array that requires a separate allocation of the array is bad).
>
>> Agreed. Most code should be dealing with the abstract concept of a hash
>> and shouldn't have to care about the size. I really like parse_oid_hex()
>> for that reason (and I think parsing is the main place we've found that
>> needs to care).
>
> Yes.



--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
