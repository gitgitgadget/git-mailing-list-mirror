Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB4A1FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 12:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbdDOMKn (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 08:10:43 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34874 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753569AbdDOMKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 08:10:41 -0400
Received: by mail-io0-f171.google.com with SMTP id r16so121939505ioi.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ebrmzzUBf4MEFUMVSofKSJCQq4xVx9Aazii2uH/AYlg=;
        b=Fb42cZu+kNwWSpU+XgXqnNKmcS15Ib68DeDWDNhpYhQWWdM/6S3EHOXqri9HekUmnX
         ZiCj5DJT2lBoG6vyYjNiljZ1QWq3+JRCFljxZOrbuL3/clgR9BdOEhWfs5YSK4X5XcsR
         v2LOKDknsWIKbIzzR5lW90oJFE38bwGaf8hRYNH4EGY3K8tH0i4rnkvRFasW9UnMtO6U
         KGv3Aeo4lOQY0qLbwLElPmYtWzCX6FqClDna6JZUgwFw9Y3UTSuE652PRmSoLGR46RSs
         C225qK8vBAWzElh8d2ppfu87u+4+yznUcM0xdmxgaiyG4OUQgSfQ7Y7+J/8StrvU6+lu
         aB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ebrmzzUBf4MEFUMVSofKSJCQq4xVx9Aazii2uH/AYlg=;
        b=dCKSUNrwhI9E8edawuLb8ap1QYjlhAQQ6X6DYdQ3LT/qLW7f5/9LDSZprNxVIAm+h1
         2PrUtYxFNGRxE9/6FtNSA96yEVOBSPTrrVpJYkf57pvfUzXl1dGh8lj20TushxWb0GGS
         g//gqDkGBERtOWEEmc7XMR96gAnm8E5qSllcJm8FjQMUFR22eN8sTHOYkzjyWfjW+iSk
         GVczlpqiacsPLEy85vdTOLDtbuVI1915b7fyuZLt8JiB8o4fxgComflAnxIfziw3PSWp
         gy8kVIsS9XEnWztZmtK9YYd4oKlJToNArlLcu1I0exo7HKqnjxlonLQRgYZZDv1kXM6+
         oNhw==
X-Gm-Message-State: AN3rC/7FIdSbdnp/MHnyrymw6phTD809BNpHejnOZg8O0FTV6txo1v9E
        MFT1nhER7NZygt+RCjiHaonvpIm5WA==
X-Received: by 10.107.46.229 with SMTP id u98mr1951148iou.147.1492258241020;
 Sat, 15 Apr 2017 05:10:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Sat, 15 Apr 2017 05:10:20 -0700 (PDT)
In-Reply-To: <20170411101412.jjzdscnirh5yerbn@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-4-avarab@gmail.com>
 <20170411101412.jjzdscnirh5yerbn@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 15 Apr 2017 14:10:20 +0200
Message-ID: <CACBZZX7S_WdrNr04XnpnBhS=Kvtp0uAirx7yjUXrveh_jJSKLg@mail.gmail.com>
Subject: Re: [PATCH 03/12] Makefile & configure: reword outdated comment about PCRE
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:14 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 01:24:57PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Reword an outdated comment which suggests that only git-grep can use
>> PCRE.
>
> Makes sense.
>
>> -# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will=
 be
>> -# able to use Perl-compatible regular expressions.
>> +# Define USE_LIBPCRE if you have and want to use libpcre. Various
>> +# commands such as like log, grep offer runtime options to use
>> +# Perl-compatible regular expressions instead of standard or extended
>> +# POSIX regular expressions.
>
> s/such as like log, grep/such as log and grep/ ?
Thanks.

>> diff --git a/configure.ac b/configure.ac
>> [...]
>> -# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will=
 be
>> -# able to use Perl-compatible regular expressions.
>> +# Define USE_LIBPCRE if you have and want to use libpcre. Various
>> +# commands such as like log, grep offer runtime options to use
>> +# Perl-compatible regular expressions instead of standard or extended
>> +# POSIX regular expressions.
>
> Ditto.
>
>> @@ -499,8 +501,10 @@ GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
>>  GIT_CONF_SUBST([NO_OPENSSL])
>>
>>  #
>> -# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will=
 be
>> -# able to use Perl-compatible regular expressions.
>> +# Define USE_LIBPCRE if you have and want to use libpcre. Various
>> +# commands such as like log, grep offer runtime options to use
>> +# Perl-compatible regular expressions instead of standard or extended
>> +# POSIX regular expressions.
>
> And again. It's weird that the text appears twice in configure.ac.
> Apparently you can use --with-libpcre or USE_LIBPCRE in the environment?
> Configure is weird.

You can't, I've added this to the commit message:

    Copy/pasting this so much in configure.ac is lame, these Makefile-like
    flags aren't even used by autoconf, just the corresponding
    --with[out]-* options. But copy/pasting the comments that make sense
    for the Makefile to configure.ac where they make less sence is the
    pattern everything else follows in that file. I'm not going to war
    against that as part of this change, just following the existing
    pattern.
