Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3934620986
	for <e@80x24.org>; Sat,  1 Oct 2016 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbcJAT4T (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 15:56:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33004 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbcJAT4R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 15:56:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id p138so8334691wmb.0
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4L+gqE4DoymJ0grY7MOfhhqiDqIPWPgimDtEXasw5kg=;
        b=hDbsBaH71zLRNN/Aw8b8kisLc4AMEIJWgp8hfQDNW9OqPEs2SYkgW6ARwA25Av8yZO
         upjjumLrW1HDjn1eCSK8kfTWd/3s0f+zVmN/FjhpPIL2+f0G/uaccDhvU1KBkU6uzE3U
         H6RjkBv3DhJnp7t1pZ6pQhePL2gAl81ry/97+cXm6nzjyRIdEo53g3VGlaMXcfTkpNK4
         LQOWZlxS/wd3v44X99F3VRURNq7DOSYbZIWQwrx+Ubz2ZDbWdSyibYNg2IW2hHI5XQ9V
         yPSU2ktkVvCaAJFC8EaMUKOR0TqtJVUxQ6qpyDLfjWq3XhTSbb/5WA+JUbpd3Y14ECwT
         T/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4L+gqE4DoymJ0grY7MOfhhqiDqIPWPgimDtEXasw5kg=;
        b=UdS5BxcgWJiQf9G7YsDtOUtGgrUChUzfjJ0jejjTy6RwyN364Uyw3jIbWb07PiNVGY
         aR+k25PpNzNacybhQg7dAEHQZtHtB+hbblFq00vlO++NmUWnC4ypWotCNdBH3B0Vz8UP
         6S5gfod7/lUmptemMpB1eTpruR0460SXkXxTNmmfvLWxgcjlBJ6HCLzowG1QKoMx20Uh
         8FzOy80fbmFfAG52bP66UGA+dcsZ7vcZ/UEsUo8n1TUeQV/mhnwzDnZigNXgAKWZTr2y
         4TrzJQ4PyHKl6rtfxwjSjMJXG4P8Jyoqpac5Nuwr22l7s687SnmbU5fpWP2CPygxbk+u
         ZMZw==
X-Gm-Message-State: AA6/9RkutASofy21vbrZIufHJH0uz2OnsMIuRns8ptSCuqqiCtVyH82D9+UqhDWbr5nXTw==
X-Received: by 10.194.85.106 with SMTP id g10mr8309772wjz.229.1475351775940;
        Sat, 01 Oct 2016 12:56:15 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id r2sm10598207wmf.14.2016.10.01.12.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 12:56:15 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] i18n: difftool: mark warnings for translation
To:     Junio C Hamano <gitster@pobox.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-12-git-send-email-vascomalmeida@sapo.pt>
 <xmqqtwd3wooa.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <34c793f6-b297-3040-b5fa-29f4a9480cd2@gmail.com>
Date:   Sat, 1 Oct 2016 21:56:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwd3wooa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.09.2016 o 01:21, Junio C Hamano pisze:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
>> -			warn << 'EOF';
>> +			warn __ <<'EOF';
>>  Combined diff formats ('-c' and '--cc') are not supported in
>>  directory diff mode ('-d' and '--dir-diff').
>>  EOF
> 
> Wow, didn't imagine gettext would pick this up.  Nice.

From gettext documentation:
https://www.gnu.org/software/gettext/manual/gettext.html

 15 Other Programming Languages
 [...]
 15.5 Individual Programming Languages
 [...]
 15.5.18 Perl
 [...]
 15.5.18.4 What are Strings And Quote-like Expressions?

 Perl offers a plethora of different string constructs. Those that
 can be used either as arguments to functions or inside braces for
 hash lookups are generally supported by xgettext.

 [...]

 * here documents 

       print gettext <<'EOF';
       program not found in $PATH
       EOF

       print ngettext <<EOF, <<"EOF";
       one file deleted
       EOF
       several files deleted
       EOF

 Here-documents are recognized. If the delimiter is enclosed in single
 quotes, the string is not interpolated. If it is enclosed in double
 quotes or has no quotes at all, the string is interpolated.

 Delimiters that start with a digit are not supported!

-- 
Jakub Narębski

