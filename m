Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CF81FEAA
	for <e@80x24.org>; Sat, 16 Jul 2016 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbcGPVqJ (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 17:46:09 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34717 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbcGPVqH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2016 17:46:07 -0400
Received: by mail-io0-f175.google.com with SMTP id q83so132510290iod.1
        for <git@vger.kernel.org>; Sat, 16 Jul 2016 14:46:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TnfXBXwNo2j+dPJS7hTkQtSFTG1jMDHVkF8206ZLSng=;
        b=N3YVlHfbDQxmku4EcG5mTLeBtMufA4Q89Lbn8hsir++cauE58gNDBsc+Q8gCa1I9Of
         IgtKeS5tG47w0VQmUlCUNcX9hXzssElpPe4shwpUDmQ7I6jFa/m15Iw1bvxNmbr/WnwH
         C6egTOSDlI1Aw+bGuVMKQBPFnxfwioMTOfVdSRVyERtdZLowUl+rRbnFNxmxsVpHu8JO
         5l+16n7gyKfwRvi0y4CvkFPmjOM3+or9ZSEZBrIZroJZymGHU43ZxYg7bQOmLRq71iWE
         z8n5mXLNBrbtbgu9IHGev1qro2yCzATBL5AkgXcSc7gSIUJwkLhoIv2NUFhCS8tS+6I0
         xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=TnfXBXwNo2j+dPJS7hTkQtSFTG1jMDHVkF8206ZLSng=;
        b=HOhiDrGwY41KUfQiSpTCSiKkOaqGEXpGY4WCC/DxleLzTwnli+0L37y1829MLK95Cf
         Pa0c0Z2pMVoxQHTFW/sil2+NAFINYPbnBCk7/Gfp7iwqOJlY140Z176EmIFbtooB/dDV
         7tWvRTVRnQ+BfCm5TE+Pjnu79pScBaIVMQB4olnqUr01zBM+jq2IVEWN9iYAVgGLzA3Q
         hvT4la9ws/7u20Zcdsu5ZYCrGWGDeg2N13aC4bwIT72CFWgc9rlhfIgbQX+ecMMZjWoy
         0lR6lvIWNi16+H5QFJHMn8acda3Jv0SaMf/mLhuYOgjlOVQvyU/i/SgnzJsrhZdUdtE4
         yWQg==
X-Gm-Message-State: ALyK8tJSfU2kKa8HYDO4rjecy+DZzbDFzm1nbyx4oaKAfdyAKt4RyradvbZGtqKK8XvTbz61HLdLNpAqUVZFbA==
X-Received: by 10.107.182.8 with SMTP id g8mr17699909iof.53.1468705566763;
 Sat, 16 Jul 2016 14:46:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Sat, 16 Jul 2016 14:46:06 -0700 (PDT)
In-Reply-To: <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Sat, 16 Jul 2016 23:46:06 +0200
Message-ID: <CAPp-Vrb5MQw-S25sTmdeatrFv5bv2pLG_mS5=9-ew8J_GNi+kQ@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Dear Brian,

Thank you for your response. It very good to hear that changing the
hash is on the git project's list. I haven't found any official
communication on that topic since 2006.
I'll look into the contributions guide and the source codes, to check
if I can contribute to this transition. If you have any documentation
or other related info, please point me towards it.

Thanks,
Zsolt Herczeg


2016-07-16 22:13 GMT+02:00 brian m. carlson <sandals@crustytoothpaste.net>:
> On Sat, Jul 16, 2016 at 03:48:49PM +0200, Herczeg Zsolt wrote:
>> But - and that's the main idea i'm writing here - changing the storage
>> keys does not mean you should drop your old hashes out. If you change
>> the git data structure in a way, that it can keep multiple hashes for
>> the same "link" in each objects (trees, commits, etc) you can keep the
>> old ones right next to the new one. If you want to look up the
>> referenced object, you must use the newest hash - which is the key.
>> But if you want to verify some old hash, it's still possible! Just
>> look up the objects by the new key, remove all the newer generation
>> keys, and verify the old hash on that.
>>
>> A storage structure like this would allow a very great flexibility:
>>  - You can change your hash algorithm in the future. If SHA-256
>> becomes broken, it's not a problem. Just re-hash the storage, and
>> append the new hashes the git objects.
>>  - You can still verify your old hashes after a hash change - removing
>> the new hashes from the objects before hashing should give you back
>> the old objects, thus giving you the same hash as before.
>>  - That makes possible for signed tags, and commits to keep their
>> validity after hash change! With a clever-enough new format, you can
>> even keep the validity of current hashes and signs. (To be able to do
>> that, you should be able to calculate back the current format from the
>> new format.)
>>
>> Moving git forward to a format like this would solve the weak-key
>> problem in git forever. You would be able to configure your key algo
>> on a per repository basis, you - and git - can do the daily work on
>> the newest hashes, while still carrying the old hashes and signatures,
>> in case you ever want to verify them. That would allow repositories to
>> gracefully change hashes in case they need to, and to only
>> compatibility limitation is that you must use a new enough git to
>> understand the new storage format.
>>
>> What are your thoughts on this approach? Will git ever reach a release
>> with exchangeable hash algorithm? Or should someone look for
>> alternatives if there's a need for cryptographic security?
>
> I'm working on adding new hash algorithm support in Git.  However, it
> requires a significant refactor of the code base.  My current plan is
> not to implement side-by-side data, for a couple reasons.
>
> One is that it requires significantly more work to implement and
> complicates the code.  It's also incompatible with all the refactoring
> I've done already.
>
> The second is that it requires that Git have the ability to store
> multiple hashes at once, which is very expensive in terms of memory.
> Moving from a 160-bit hash to a 256-bit hash (my current plan is
> SHA3-256) requires 1.6× the memory.  Storing both requires 2.6× the
> memory.  If you add a third hash, it requires even more.  Memory is
> often a constraint with using Git.
>
> The current plan is to use git-fast-import and git-fast-export to handle
> that conversion process, and then maybe provide wrappers to make it more
> transparent.
>
> Currently the process of the refactor is ongoing, but it is a free time
> activity for me.
>
> If you'd like to follow the progress roughly, you can do so by checking
> the output of the following commands:
>
>   git grep 'unsigned char.*20' | wc -l
>   git grep 'struct object_id' | wc -l
>
> You are also welcome to contribute, of course.
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204
