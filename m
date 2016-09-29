Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975D7207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934636AbcI2VWB (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:22:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35387 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933484AbcI2VV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:21:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id b4so657259wmb.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NpYrQ9fJqBKmZfsxaF6NEUdTfZa0Lil7dv96Des30OY=;
        b=YXWHRkAbi0anF+r9RWyFLuH6H3mdIbR/MGlZFQG8IEijE3vpBSYr01n/r5GddfFxZh
         aCLCS1Xv99ZAuasu3ec3MyUBXC4SN6gb+yWiH72TJ2D20G1fHddctFjNwmBC0JElQPRs
         4J/yqxyNQR9OCQrnBPHSbZSD0KTvDXrFyzSAaftxxzr6DTqWVt5TQO6CQu9x5MYa5xDp
         tQqUCSsuQWNpK/xvtyZ+sqrA8x84QaF68hEry5okGwuDjgj70yZAHHzTdM1CWyupw+2S
         iLIdu1eELicr/Y9Vq+Bbh7u7IyZj9rMAfsZ8smshaYNXTS0ej1SdTb0LW175nnWcMRhW
         WU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NpYrQ9fJqBKmZfsxaF6NEUdTfZa0Lil7dv96Des30OY=;
        b=fgIcDz+F4BKCg7Be6Lnvlswc70n6GkAUrfdkCJEZkhJznUXC44Mysn/KzAkigVCQym
         IHsPE5NEfWS4gBJpCL892rq91OOFU0EPDfEbr55K7v17XBxPuQhU/Fo7YtVzIdQIQDSC
         Wal9bmWnxH+19Obqm7GuaRPtLMECKVmnjFXKhXXEfIENh7oYLVVvEhblmAonZbxEhom4
         mqjsM2Ue1cuTkUdZVITB4SxHtbnewvXihoy6fZvxSdNu7kxDQ5cQhgq4E47VAfsrPLqn
         HjVo3o2wE3rARtQh+TpMwcBFKcYskSMwxPp3cnBPtOG3qa3pm1pnhO1ICPmxwTBJus0u
         4X+A==
X-Gm-Message-State: AA6/9RkDHNgpZSpP9Ztu09cG2XlnnnO7rJVXr5FRXKMIzDgRQ9E32vRlgwFEcTtBRGWYPA==
X-Received: by 10.28.66.6 with SMTP id p6mr548843wma.59.1475184105643;
        Thu, 29 Sep 2016 14:21:45 -0700 (PDT)
Received: from [192.168.1.26] (eln216.neoplus.adsl.tpnet.pl. [83.21.207.216])
        by smtp.googlemail.com with ESMTPSA id iq2sm16158308wjb.19.2016.09.29.14.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Sep 2016 14:21:44 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] i18n: add--interactive: mark strings for
 translation
To:     Junio C Hamano <gitster@pobox.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-2-git-send-email-vascomalmeida@sapo.pt>
 <xmqqr387y4le.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <906445d8-25df-1b9a-8656-631ce007fc39@gmail.com>
Date:   Thu, 29 Sep 2016 23:21:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqr387y4le.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.09.2016 o 00:52, Junio C Hamano pisze:
> Vasco Almeida <vascomalmeida@sapo.pt> writes: 

>>  my $status_fmt = '%12s %12s %s';
>> -my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
>> +my $status_head = sprintf($status_fmt, __('staged'), __('unstaged'), __('path'));
> 
> Wouldn't it make sense to allow translators to tweak $status_fmt if
> you are allowing the earlier elements that are formatted with %12s,
> as their translation may not fit within that width, in which case
> they may want to make these columns wider?

Perl's printf, sprintf, and format think all codepoints take up 1 print
column; also, without "use utf8;" they all think that one byte is one
codepoint (as it is in latin1 encoding).

Many codepoints can take 0 print columns (zero-width joiners), or 2
columns (so called wide characters).

The proper way to justify Unicode output is described e.g. in
http://www.perl.com/pub/2012/05/perlunicook-unicode-column-width-for-printing.html

  use Unicode::GCString;

  my $gcs  = Unicode::GCString->new($str);  # grapheme cluster string
  my $cols = $gcs->columns;
  my $pad  = " " x (12 - $cols);

  $status_head .= $str . $pad . " ";

Though we would need to provide fallback if there is no perl-i18n,
no extended Unicode support in Perl (also, if we are not using
gettext).


So it is even more complicated.

>>  			prompt_yesno(
>> -				'Your edited hunk does not apply. Edit again '
>> -				. '(saying "no" discards!) [y/n]? '
>> +				# TRANSLATORS: do not translate [y/n]
>> +				# The program will only accept that input
>> +				# at this point.
>> +				__('Your edited hunk does not apply. Edit again '
>> +				   . '(saying "no" discards!) [y/n]? ')
> 
> Not just [y/n], but "no" in "saying no discards!" also needs to
> stay, no?  I wonder if it is a good idea to lose the TRANSLATORS
> comment by ejecting "[y/n]" outside the "__()" construct here.

Actually the message to translators should also mention that if
the translation of "no" doesn't begin with 'n', then one needs
to say something like '(saying "n" for "no" discards!)'.

Best,
-- 
Jakub Narębski

