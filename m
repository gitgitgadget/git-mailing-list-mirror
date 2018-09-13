Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAC61F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIMXZu (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:25:50 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33153 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIMXZu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:25:50 -0400
Received: by mail-qt0-f179.google.com with SMTP id r37-v6so6322632qtc.0
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=66duO3adPttt3NBrEpeEvmhSc7E98/yFveYPg0/5I2c=;
        b=KxSkZiaX7Ndduc15A8Ep/1zo3k5fk8Pl8l1wLEmK2/B4DN0BZJeE7dnUTRnYi4ME1L
         VbGN6XR9TID+Ig4Rltzqo3wHrnmxx0ITxQPBw4uiiGsqVsXakP7zxCcj1dWeeRY/89bU
         zPU09OvioH3WBsHI7UQTZsEZrlF6LKR+Q0smr4AgHX54NkjbTQHdN0VD+KEpGjenqQUI
         yxfG8+7/AhClmwut2PLQ84/SpqP02HSl651eTvjzLInk8uKrfMptgHyItbWhFiTsQgYF
         bPkhMEGVl6ltJxsUNtTCkWfUE4mXdwIaNOfkDY6q6U3Dd5MX3HRHpieT4DSpSAmPsGdK
         ztsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=66duO3adPttt3NBrEpeEvmhSc7E98/yFveYPg0/5I2c=;
        b=ekffewP2jn/66KS9R5CudmENHwUt46V2mDkcSzLVJxrcb+swJ43pcx1JwNRO5RyD1a
         hzfuQGc4drMTe7cRP4L5f2Q7eN3NJ6nYRtXc/oa1VumpoKfC6YyupfVIAtDsSkdWZRfj
         EyiDfx+Kfwn+G1FuVv8OfOs/4MXneCCPJiQZFtqNUXQNrBqT1eiJBQITNHMQBBQcnJxf
         x3mMnzThfL0qUV9eotp02WypbvOeJi0Nhlj76s0NW1WTmD3yZqxpV17S3HkPDfjtqI3Y
         kRfkL0pfuGOy/XGncbOYX31bQaRsyf6LjIQElnOdLT6G1BOouBBCCJejnTB+Tp25TXs9
         kycg==
X-Gm-Message-State: APzg51AUj/hgNjxxejP/ZC9uLUqfeVkBwDwtYbC9bSkAdP75/cv2Q/zU
        ojxGmppOtlqgDtfrKvqlBrc=
X-Google-Smtp-Source: ANB0VdaK962+8Ybrztei3jfB1rfUIN68LD+04pxARF1NN0FX4PAAUtC78oeo+PdFnlwa+yDf8sLStA==
X-Received: by 2002:a0c:83c4:: with SMTP id k62-v6mr6166336qva.88.1536862511931;
        Thu, 13 Sep 2018 11:15:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d087:f807:1318:50bb? ([2001:4898:8010:0:b9bd:f807:1318:50bb])
        by smtp.gmail.com with ESMTPSA id s35-v6sm3269062qtj.79.2018.09.13.11.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:15:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] contrib: add coverage-diff script
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.40.git.gitgitgadget@gmail.com>
 <pull.40.v2.git.gitgitgadget@gmail.com>
 <7714b0659e3210e34d0904b3347473427546d15c.1536850601.git.gitgitgadget@gmail.com>
 <xmqqzhwlfg7o.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3ba684df-f6eb-1ebb-2421-160b89b2f246@gmail.com>
Date:   Thu, 13 Sep 2018 14:15:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhwlfg7o.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2018 1:40 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +			then
>> +				line_num=$(($line_num + 1))
>> +			fi
>> +		fi
>> +	done
> I have a feeling that a single Perl script instead of a shell loop
> that runs many grep and awk as subprocesses performs better even on
> Windows, and it would be more readable and maintainable.
>
> perl -e '
> 	my $line_num;
> 	while (<>) {
> 		# Hunk header?  Grab the beginning in postimage.
> 		if (/^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/) {
> 			$line_num = $1;
> 			next;
> 		}
>
> 		# Have we seen a hunk?  Ignore "diff --git" etc.
> 		next unless defined $line_num;
>
> 		# Deleted line? Ignore.
> 		if (/^-/) {
> 			next;
> 		}
>
> 		# Show only the line number of added lines.
> 		if (/^\+/) {
> 			print "$line_num\n";
> 		}
> 		# Either common context or added line appear in
> 		# the postimage.  Count it.
> 		$line_num++;
> 	}
> '
>
> or something like that, given that you seem to only need line
> numbers in new_lines.txt anyway?

Thanks for the deep dive here, especially with the perl assistance. I've 
never written any perl, but it seems like the right tool here. I'll have 
time to revisit this next week.

Thanks,

-Stolee

