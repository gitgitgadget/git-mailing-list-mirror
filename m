Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010D01F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 10:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbcH2KJX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 06:09:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34777 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756027AbcH2KJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 06:09:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so8798835wma.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YW9Dk9b6mxwkClGl8WOHqs+mClmhGdsWol03eRbXeO4=;
        b=auPaNkBfSB0TJGYIV0K0VgYknpDNbycy60fChKLIvyU5xBl6PqsNlXhkvWmDq9+6Cl
         HDxDsMP0oaKBaVMI9A6wywaUFZLDjIVuf6yj1JiUGxDF2i7MENWxknWHgwbiN0rfqfxi
         6l6pzNShdnK5yjixYnQ05OqHclOLAv/qF1Eewmx8ocMALoQ0J23FWTajlMAweb+6NQqL
         S3WTmGiJd+AdpjyM0rkesU3CJNewfq+q+SX4QvcG92VWMBwgBpcWSFRrFIiFKs/ZP2Sm
         oTketXgDgXsR7iZ4MfnE+eDgiabIijjLrse+UacRocRW5HRbFhf9VoqRwAf29ypztLZO
         aXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YW9Dk9b6mxwkClGl8WOHqs+mClmhGdsWol03eRbXeO4=;
        b=bpaBQPKQeID2ddfnu1OOqMLGXFIMBr3cYF0690A/9NK334jszUOjzzkS3Fci6K5HqK
         ovMWjL5zxb/hnAE0nCLwOlO+2jz9EzJzlI916lqL3nzUfYGC9jtsV6hJ2ynQybz4UD9I
         2Wudn7qGAoPGpAL8TBhvg79YRKFwWIVjl9bXfJbISiXTCcGpWlR2ITRiPAqwcmQamdho
         dtWpu65ED8GiIhel9qLiv7KbyygT7gE8WiGrBYDdl4SvxjqRAM+9GCNP5jomJRAjtwjm
         DCpq1yuTHZ/OTaLLHZgMVIjgUh6cZ44mfQ6T2As+vLUGFj8rOUHUf3lRfK/0c+trXzpT
         8YZQ==
X-Gm-Message-State: AE9vXwPGCru7+SoYVeDGwAMJ/+vZ66DxF/x5JvOcxwWYWwwcvIkfWR1WUjX/9l/vVzwBZw==
X-Received: by 10.28.29.211 with SMTP id d202mr10137484wmd.64.1472465360232;
        Mon, 29 Aug 2016 03:09:20 -0700 (PDT)
Received: from [10.32.248.244] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id f187sm12759023wmf.15.2016.08.29.03.09.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 03:09:19 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 09/13] convert: modernize tests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqk2f3fgbd.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 29 Aug 2016 12:09:17 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <70802AA1-8455-49FA-8457-7E590289FFCC@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-10-larsxschneider@gmail.com> <xmqqk2f3fgbd.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Aug 2016, at 22:03, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Use `test_config` to set the config, check that files are empty with
>> `test_must_be_empty`, compare files with `test_cmp`, and remove spaces
>> after ">" and "<".
> 
> All of the above are good things to do, but the first one needs to
> be done a bit carefully.
> 
> It is unclear in the above description if you made sure that no
> subsequent test depends on the settings left by earlier test before
> replacing "git config" with "test_config".

I assumed that I would see test failures if a subsequent test depends
on the settings left by earlier tests. I'll add this comment to the
commit message.


>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 7bac2bc..7b45136 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -13,8 +13,8 @@ EOF
>> chmod +x rot13.sh
>> 
>> test_expect_success setup '
>> -	git config filter.rot13.smudge ./rot13.sh &&
>> -	git config filter.rot13.clean ./rot13.sh &&
>> +	test_config filter.rot13.smudge ./rot13.sh &&
>> +	test_config filter.rot13.clean ./rot13.sh &&
>> 
>> 	{
>> 	    echo "*.t filter=rot13"
> 
> For example, after this conversion, filter.rot13.* will be reverted
> back to unconfigured once setup is done.
> 
>> test_expect_success check '
>> 
>> -	cmp test.o test &&
>> -	cmp test.o test.t &&
>> +	test_cmp test.o test &&
>> +	test_cmp test.o test.t &&
>> 
>> 	# ident should be stripped in the repository
>> 	git diff --raw --exit-code :test :test.i &&
> 
> It happens to be true that this subsequent test does not do any
> operation to cause data come from and go into the object database
> for any path that match the pattern "*.t", because for whatever
> reason the previous "setup" step happens to do more than just
> "setup".  It already exercised the filtering by doing "git add" and
> "git checkout".
> 
> If we were writing the script t0021 from scratch today, we would
> have used test_config *AND* squashed there two tests into one
> (i.e. making it a single "the filter and ident operation" test).
> Then it is crystal clear that additional tests on commands that may
> involve filtering will always be added to that combined test
> (e.g. we may try "cat-file --filters" to ensure that rot13 filter is
> excercised).
> 
> But because we are not doing that, it may become tempting to add
> test for a new command that pays attention to a filter to either of
> the test, and it would have worked OK if this patch weren't there.
> Such an addition will break the test, because in the second "check"
> test, the filter commands are no longer active with this patch.
> 
> So while I do appreciate the change for the longer term, I am not
> quite happy with it.  It just looks like an invitation for future
> mistakes.

I'll follow your judgement here. However, from my point of view a future 
addition that causes test failures is no issue. Because these test failures
would be analyzed and then the tests could be refactored accordingly.


>> @@ -130,7 +130,7 @@ test_expect_success 'filter shell-escaped filenames' '
>> 
>> 	# delete the files and check them out again, using a smudge filter
>> 	# that will count the args and echo the command-line back to us
>> -	git config filter.argc.smudge "sh ./argc.sh %f" &&
>> +	test_config filter.argc.smudge "sh ./argc.sh %f" &&
>> 	rm "$normal" "$special" &&
>> 	git checkout -- "$normal" "$special" &&
> 
> This one is clearly OK.  Anything related to argc filter only
> appears in this single test so it is not just OK to use test_config,
> but it makes our intention very clear that nobody else would use the
> argc filter.  I think similar reasoning would apply to the test_config
> conversion in the remainder of the script.

OK, then I will keep these test_config's and revert the first one.


> As to other types of changes you did in this, I see no problem with
> them.


Thanks,
Lars
