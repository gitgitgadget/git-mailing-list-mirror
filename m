Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B561F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHVUPP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 16:15:15 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:39209 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeHVUPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 16:15:15 -0400
Received: by mail-qt0-f181.google.com with SMTP id o15-v6so2882534qtk.6
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=F+DeN0brWCu4e35afFVeiM734p9RPn/f9cnyfqxcSDU=;
        b=PsbLUp4vNUJLjSBs9Tg3fxza8uA/Now33edhVfkxcpxAO5veueNXbzxlal5g7ccyUn
         PewgBFW4Oze/quhoqUFbEM3uIy5WNWE44r8w/oIV0/LH+20oE3rNr8//i8U5T/aATMzq
         BTgXfwS84RnCs/EKA5t6A5/E5PUZApGT4RwiMODI2gAAg2dmos06yHY5J4b+2J3LSBc4
         Ugn4MP/mJaq0LKKaksGkfdfCLfwgVcNXAYX00QUJievelPeuKLSaThNKaCk5WFi18i/+
         uuufRdS2RDOodWtQAOS9RyvaVj2+bZlpkNgQshMdHoXRllaDvqgHrpmz52OBMTWyrxY5
         4I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F+DeN0brWCu4e35afFVeiM734p9RPn/f9cnyfqxcSDU=;
        b=UIaj8LmcyTV8Q4ElQirL5P+e36PLwO9zOz4HGn6LjQF8ga3s9jIGvgMCZvyD75hiPp
         PdDWVSh6uipp5j2e9CXhNREKAj/Ei1jz6R3oRnI3Ap/tzaA23I2QIUF60g/8CPtMedWa
         NvQH+KBS+t0PMau4Tg7kXDIkSyJDvUitQo6scyxcMn10RK2mnvjwJuxYN79OL01kph80
         BrEIH9TW5mQPIIGZYUs5/oO69HRy5KUpMhFdNgHT/4TLfJZixf8uMPjG6q6KcHuZhF82
         J9pMBFlhwjlxEPiiA4nu0QW44QTqmFSoKYeT+cPAYRZnyWt50e5Uq3V3IM0ZFdf7B6jD
         VFkQ==
X-Gm-Message-State: APzg51D+SfRa9M2PWoJqnm1CaO4HFq/GbmEmPrkFOT//p+PCGAYnsRyY
        uWAi6Mrv2zwlbmOyUUT0ucUIRFs3
X-Google-Smtp-Source: ANB0VdaPvPN0SzXhZOTZ5gGCGtET5aljo8MZKuE50dUZnERWPY+lFe7MP07vNrFIIclv+c32+mQzSA==
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr15624576qvm.115.1534956576324;
        Wed, 22 Aug 2018 09:49:36 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id g18-v6sm1422187qta.57.2018.08.22.09.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:49:35 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net>
 <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
 <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com>
 <20180822151703.GB32630@sigill.intra.peff.net>
 <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
 <CACsJy8DifmYtDE4D58yVM7rYhfJFe8p-t9bXgMmMsw=txxmzHA@mail.gmail.com>
 <20180822162609.GA11904@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com>
Date:   Wed, 22 Aug 2018 12:49:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180822162609.GA11904@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2018 12:26 PM, Jeff King wrote:
> On Wed, Aug 22, 2018 at 06:14:24PM +0200, Duy Nguyen wrote:
>
>> On Wed, Aug 22, 2018 at 6:08 PM Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Wed, Aug 22, 2018 at 6:03 PM Jeff King <peff@peff.net> wrote:
>>>> On Wed, Aug 22, 2018 at 07:14:42AM -0400, Derrick Stolee wrote:
>>>>
>>>>> The other thing I was going to recommend (and I'll try to test this out
>>>>> myself later) is to see if 'the_hash_algo->rawsz' is being treated as a
>>>>> volatile variable, since it is being referenced through a pointer. Perhaps
>>>>> storing the value locally and then casing on it would help?
>>>> I tried various sprinkling of "const" around the declarations to make it
>>>> clear that the values wouldn't change once we saw them. But I couldn't
>>>> detect any difference. At most I think that would let us hoist the "if"
>>>> out of the loop, but gcc still seems unwilling to expand the memcmp when
>>>> there are other branches.
>>>>
>>>> I think if that's the thing we want to have happen, we really do need to
>>>> just write it out on that branch rather than saying "memcmp".
>>> This reminds me of an old discussion about memcpy() vs doing explicit
>>> compare loop with lots of performance measurements..
>> Ah found it. Not sure if it is still relevant in light of multiple hash support
>>
>> https://public-inbox.org/git/20110427225114.GA16765@elte.hu/
> Yes, that was what I meant. We actually did switch to that hand-rolled
> loop, but later we went back to memcmp in 0b006014c8 (hashcmp: use
> memcmp instead of open-coded loop, 2017-08-09).

Looking at that commit, I'm surprised the old logic was just a for loop, instead of a word-based approach, such as the following:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..5e5819ad49 100644
--- a/cache.h
+++ b/cache.h
@@ -1021,9 +1021,41 @@ extern int find_unique_abbrev_r(char *hex, const 
struct object_id *oid, int len)
  extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
  extern const struct object_id null_oid;

+static inline int word_cmp_32(uint32_t a, uint32_t b)
+{
+       return memcmp(&a, &b, sizeof(uint32_t));
+}
+
+static inline int word_cmp_64(uint64_t a, uint64_t b)
+{
+       return memcmp(&a, &b, sizeof(uint64_t));
+}
+
+struct object_id_20 {
+       uint64_t data0;
+       uint64_t data1;
+       uint32_t data2;
+};
+
  static inline int hashcmp(const unsigned char *sha1, const unsigned 
char *sha2)
  {
-       return memcmp(sha1, sha2, the_hash_algo->rawsz);
+       if (the_hash_algo->rawsz == 20) {
+               struct object_id_20 *obj1 = (struct object_id_20 *)sha1;
+               struct object_id_20 *obj2 = (struct object_id_20 *)sha2;
+
+               if (obj1->data0 == obj2->data0) {
+                       if (obj1->data1 == obj2->data1) {
+                               if (obj1->data2 == obj2->data2) {
+                                       return 0;
+                               }
+                               return word_cmp_32(obj1->data2, 
obj2->data2);
+                       }
+                       return word_cmp_64(obj1->data1, obj2->data1);
+               }
+               return word_cmp_64(obj1->data0, obj2->data0);
+       }
+
+       assert(0);
  }

  static inline int oidcmp(const struct object_id *oid1, const struct 
object_id *oid2)


