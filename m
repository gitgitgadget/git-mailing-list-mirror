Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3236C208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdHaVvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 17:51:11 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:38225 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdHaVvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 17:51:10 -0400
Received: by mail-qk0-f169.google.com with SMTP id a21so3966119qkg.5
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xShSzdu2MwjpCMD/zlW8OL6CjjBLcpXpgOtqLNEw/NE=;
        b=GY1BM46iDohKU+ubZKShPP5w/2p0vtOrSnA7AT4XRIbK92yn5Df/+H/4ZoDle9w5cZ
         85d84B8ytc/V1B8ZPaCma+esXlVUsT8fgA1Zi0JOvolxqqSmuZu/Xje2OaIFFeKLFYc5
         tNDlSy78CqRoJeB5AXv3ITIjkOaRVh09AMhGdMO2SrQmngJFooN0RXD1Skl5eNwWJMZE
         8+9tO3J+LZwPgNZ4rKb7bouJ705cQtsSHBjEH0HGdjGUGFvsxtp741zn1MlVpcL2JyzM
         smDam6iHO2yfH9ZOtPusC0xhxZ58tv6YyD/H5HkEgks+z89eJLg4x7lR+q3uhcOSNTXv
         j1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xShSzdu2MwjpCMD/zlW8OL6CjjBLcpXpgOtqLNEw/NE=;
        b=Le4kn4omnkkmyCaID5S9u1AYph7/inhZA5lMY1eo+D0wI+Vqefj+iQlIx84pyhG6JW
         pfMlCnO2Lcg5puGp6noumdD3a6tf1BDpd3MFQIEAR2Rx2nNw/RZAKrpBmz9dVxtsUMnQ
         GnFSWmgWHJjYaNs2z9JzxIZN4aFJY1Jf7KiICHUmeb4lBnZOMxs2zQJ0WMfG3Mks7VOD
         kTAYSn1ifd83ypqGAneGMvtOtPoJ6dSi1TkdO64HGB/Ov3/ToOWNh2WKLBCr7PSeXhTg
         rSpio+WwLvbnrqttZZasH1vhiLw4uMFJezBWqsHF9IHzNYg8CyBqROui1EUu4sbmnx0E
         hDdw==
X-Gm-Message-State: AHPjjUjliQD+bo1kIDayK+asiQkt0i3cGfJOz6OcYZ+OnuJQWnlXefk3
        iLz13rMvlVnRXRcBciE=
X-Google-Smtp-Source: ADKCNb78C93DFzRdKj1rbWflXUUz383D/SKnHK4iv8X0rRuOHhj+phiGonIwFqspz0UZS2bpp/aq9Q==
X-Received: by 10.233.235.69 with SMTP id b66mr6110839qkg.200.1504216269251;
        Thu, 31 Aug 2017 14:51:09 -0700 (PDT)
Received: from ?IPv6:2604:6000:b40b:7800::2? ([2604:6000:b40b:7800::2])
        by smtp.gmail.com with ESMTPSA id z1sm600344qtz.1.2017.08.31.14.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2017 14:51:07 -0700 (PDT)
Subject: Re: [PATCH 0/1] Add stash entry count summary to short status output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
 <xmqqshggvien.fsf@gitster.mtv.corp.google.com>
From:   Sonny Michaud <michaud.sonny@gmail.com>
Message-ID: <a46f972b-e83f-a08c-72ab-bfd1e7c4b310@gmail.com>
Date:   Thu, 31 Aug 2017 17:49:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqshggvien.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

I appreciate you taking the time to look over this patch.  I have some
comments below before re-submitting an updated version.

On 08/24/2017 04:07 PM, Junio C Hamano wrote:
> Sonny Michaud <michaud.sonny@gmail.com> writes:
>
>> diff --git a/wt-status.c b/wt-status.c                                         
>> index 77c27c511..651bb01f0 100644                                              
>> --- a/wt-status.c                                                              
>> +++ b/wt-status.c                                                              
>> @@ -1827,6 +1827,15 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)                                                                          
>>         fputc(s->null_termination ? '\0' : '\n', s->fp);                       
>>  }                                                                             
>>                                                                                
>> +static void wt_shortstatus_print_stash_summary(struct wt_status *s)           
>> +{                                                                             
>> +       int stash_count = 0;                                                   
>> +                                                                              
>> +       for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);     
> A singleton instance of this in wt_longstatus_print_stash_summary()
> thing was OK, but let's not duplicate and spread the badness.  Have
> a simple there-liner helper function "static int stash_count(void);"
> that does the above and returns the stash_count, and use it from
> both places.
That is reasonable.
>> +       if (stash_count > 0)                                                   
>> +    color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## Stash entries: %d", stash_count);                                                                    
> That's a funny way to indent (dedent?) a body of an if() statement.
My bad, I can clean that up!
>
> Don't scripts that read this output (I notice that this is also
> called by wt_porcelain_print() function) expect that entries that
> are led by "##" are about the current branch and its tracking
> information?  
>
> This patch would break these script by adding this new line using
> the same "##" leader.
>
I did not consider porcelain output;  it looks like the headers are
stripped from it, though, so this might not be an issue.  Do you think
this is a worthwhile path to continue on?

Thanks,
Sonny
