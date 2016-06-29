Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C1A20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbcF2VWr (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:22:47 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36626 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbcF2VWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:22:45 -0400
Received: by mail-wm0-f54.google.com with SMTP id f126so197393123wma.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 14:22:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sBsxzxLdwG7uBJuYqdkJfI9eM4U+ZM7vhrsdlkZvxSQ=;
        b=cUHi31NrfqfMhRFZM4gMHAmbgnlTjo9qZ4gylsSv2kLFeW3E6QrQlifL1lzC1y09EV
         TQy5C8URhlr120njY3nMqyc5xCgeDHZXA+sgzQHhsLhRXZ+lVzQtv+d4muzKzoNUO2LN
         5WFykPK4v4fOdWRM89tOmWGQZjF/Gqgu899WhFwtR65nNAtYuZY9B9B1qjq4vJK5HRK9
         xKlqYdywmg8nDQi+GxxtNMBLPV8pCuSFwRQjEoc5uN57amCJ3d/CX+uFWZehDsZnRWgC
         RaoeykrTHGauQgZxwWhysLZnjZ6ITW9t6RfmLJW09Ck0gHNvlPmyG5513bIOjyHNwoUo
         6KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sBsxzxLdwG7uBJuYqdkJfI9eM4U+ZM7vhrsdlkZvxSQ=;
        b=ZMxgEfxA1OATiGaMZCtVAEYKy/VxPBscL9P4AQB7xgrrM0i8sv4kH/HGsP8lWc2EZE
         rGTE/eGufJwmVlDv26FfFFaJaQXQkzBjABkxYwESEtQF2SIGHZ+ulsMf1pi50WdlcrJH
         xEng9bXrlX34gcuN9omseHJwQkQnGct+39xHBRnTXONFOTKoAltKOVnmzPueItqK72ka
         fJfEZ5/DaCdmHyZJFQOPS6XaWOoz86FUV6BOh/kTahV7fO1yTWNrWEzo20y/AgTD3FI9
         Jvg5LNpPoDpoI3mnapTLc9V2aB+CBr4TxNIpYhWqTqP8byr/hUoDG8FA83QTZJWvXlhn
         FkaA==
X-Gm-Message-State: ALyK8tJuwctlu3MH8yi3W2a1ZutA+cq7t0/TuU0oQnVP0ZgnNQVAnpbV7MdsBDgIiNHYGw==
X-Received: by 10.28.182.68 with SMTP id g65mr24743129wmf.12.1467235339039;
        Wed, 29 Jun 2016 14:22:19 -0700 (PDT)
Received: from [192.168.1.34] (aefh205.neoplus.adsl.tpnet.pl. [79.186.137.205])
        by smtp.googlemail.com with ESMTPSA id f140sm620844wmf.22.2016.06.29.14.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 14:22:18 -0700 (PDT)
Subject: Re: [RFD] Place to document magic pathspecs like ":/" and pathspec
 handling
To:	Junio C Hamano <gitster@pobox.com>
References: <577425EF.6030900@gmail.com>
 <CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57743BFB.9040709@gmail.com>
Date:	Wed, 29 Jun 2016 23:22:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-29 o 21:51, Junio C Hamano pisze:
> On Wed, Jun 29, 2016 at 12:47 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>> I have noticed that the magic pathspec ":/" is described only in RelNotes
>> for revision 1.7.6:
>> |I think the reason might be that there was no good place to put that
>> information in.  Nowadays we have gitcli(7) manual page, but perhaps
> $ git help glossary
>
> look for pathspec.
Thanks. I haven't noticed that.

But I think it is not the best place to keep this documentation.
There are the following issues with it:

* it is hard to find; I did not search _glossary_ for information
  about how Git handles pathspecs, I would search it if I didn't know
  what pathspec means.

* it is longest entry in glossary, and the only one with nested
  list, but

* it is also too short to describe how Git handles pathspecs in detail,
  and a bit cryptic; there are no examples (so grepping docs for '":/"'
  didn't found it).

-- 
Jakub Narębski

