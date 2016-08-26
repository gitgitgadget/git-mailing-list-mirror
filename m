Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DB11F859
	for <e@80x24.org>; Fri, 26 Aug 2016 01:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbcHZBHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 21:07:47 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36795 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbcHZBHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 21:07:46 -0400
Received: by mail-yw0-f176.google.com with SMTP id u134so40224193ywg.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1h1aMbl0gNeCpqdDeKA0EkiQ0vbcXMQNoSqU71BZxgM=;
        b=oZOg3QUgwoZ6FtEIsAfR3mn2uPvWM1gaszgKtnzsY+wcI1rHCBlg0HX6WgAedhqv4M
         HoyYVmLU2buz7gd6zyVFB8kkfr8EJ5RTBYc1/K74YVgxqh75OJgAZDMUBNjJrRbHSkH3
         7WzJc/0BA00qiggV3AItwceXo5NrVOWMio+sI21zMFJrpRnE+TVQPrbD0VV7iyLt8cAo
         sBAcVJOtvC/G5PyYy9F2OJTqwPhOI+LetJ11f8jnIsqWHXxrv8Tlf2GNnR/rkHJyUE93
         MxzZzKsq6VX7ASLEm2RKbqBrBRV4+3WLSBDRbTqSnJ8kzuc2UnHjw6UhZzYOkiXXhD0J
         ZsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1h1aMbl0gNeCpqdDeKA0EkiQ0vbcXMQNoSqU71BZxgM=;
        b=Gj9oMnixLLtQmAkpZu4LQ4J9WC0MvrSTelXJudb+PZ69uzgTYgi/eUwpTG0bdfUMDd
         6swFgvJbYk/Zm54pgWejOR4UF/HN77AOO5kSxKvtk94qeX5Wd9cpjgTofWffngPIXnmx
         dXoYJ46ygTGqHycmvLUoBARbBj2qTI2h0lcoQJ9VIC99cjMoZru/F1dTjfYB6yLmsQpD
         JHsEodRXTxqni8kgufnmVLtCRPdH/UVBCIO2Jsy1ODqT4hxdk0Zei+jBePV8JfFz8eUs
         S1KbwVhlcNZxPYGahx4R9HQWYZm5nrYdw/nZ5plgPf1Bpiclk6DiDgrnxyNd+oaRKAts
         1vLA==
X-Gm-Message-State: AE9vXwPzDaLvTyirr7tgeQoAQlRLoiC4NU1d8mMOjri+S7qbwecxEPJ/ZwncViag8v3zX9/vXx94AJLUkyxcWg==
X-Received: by 10.13.228.196 with SMTP id n187mr417870ywe.83.1472173253830;
 Thu, 25 Aug 2016 18:00:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 25 Aug 2016 18:00:33 -0700 (PDT)
In-Reply-To: <xmqqy43klhds.fsf@gitster.mtv.corp.google.com>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <20160825155255.28929-1-tboegi@web.de> <xmqqy43klhds.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 25 Aug 2016 18:00:33 -0700
Message-ID: <CA+P7+xr+Bi232Cexu-t+W0sSzGrKkS=A=9EWqivKjnw2GueGXQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Update eol documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> tboegi@web.de writes:
>
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> Sorry for posting this so late:
>> While reviewing another patch I realized that the eol related
>> documentation was not updated as it should be.
>>
>> Torsten B=C3=B6gershausen (2):
>>   git ls-files: text=3Dauto eol=3Dlf is supported in Git 2.10
>>   gitattributes: Document the unified "auto" handling
>>
>>  Documentation/git-ls-files.txt  |  3 +--
>>  Documentation/gitattributes.txt | 24 ++++++++++++++++--------
>>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> This [0/3] is meant to be a cover for [1/2] and [2/2]?
>
> I am trying to see if we broke format-patch recently, or it is a
> manual editing error.  The latter I do not care about; the former I
> do.
> --

Yes. I recently changed some of format patch and would like to make
sure I didn't break it...

Thanks,
Jake
