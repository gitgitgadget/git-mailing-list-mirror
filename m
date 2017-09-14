Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E504B209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 14:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdINORq (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 10:17:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33204 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdINORq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 10:17:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id h4so1568222pfk.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=93Uf2Stwj4goOmH4VyhfffFpurBZ1qFSK/p5CDuUoxo=;
        b=Qp58r0JY2Fb7YpABY1XzjOaIS2wQCfPUdMurQ4H0t1MEVJIg8PNPeNBVAePYRQaJDZ
         UQy8zyR1G15h3mgkFiDinzfVDwGp3kzcm/3sx/FEIlcgk34BwY/81lvJ4EKfeYFSHvhA
         lI9DzuxCaUEj54sxPSFv3UGWwtI3VyUZAuBNvauGjZP9Q6USctk8DQdzvDtYSw1EpqXj
         Y/khwW8FXc4Gh69/kA/wa5vHguWhgoucDW19Ario6b2wJL8gxTO4SvOnA5D32Mu6E/kJ
         cWHSNsMdvabF2/8Z57my6FsO8aCfVMZe6iyaD7srK9SnxXTOrW7j8lnzsmFimtWrvZlv
         I4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=93Uf2Stwj4goOmH4VyhfffFpurBZ1qFSK/p5CDuUoxo=;
        b=q0Hg+SZwmLcoZAQTZcKYetPMy3mtOJ2AylIt2OY+5PPoFQxYGTu0pZQzhqVSUz64f5
         8pH9UVWn55oXrKffv8242XiiTeuBdbCnB8gjS0Gz0kibbCxgbzv38Qs89+FRR9URW1fJ
         szPVgF/sjOVUSj8fsAUC0t0GCCEoFePyRLTucHAoID+kdUm4t5OzwAGw40uDhOKA2NSB
         OWAnQZVrGcIqek4ano60ioqO0EL1JwOQTE4NKpsxAY9BfYiz8UPlmh9CDRf/FU0tuRYm
         ebID+YScLGVSh+KoRfw1b7/rrXEEXbKTRag6+W8inLmwSJRBMbKhe8tXgH6gBqQ6puTX
         csJA==
X-Gm-Message-State: AHPjjUgYZ0YJnoDEXumIhQ5AHIDGoLaKENPXCKSKGhhXGC9TRPxPeviQ
        w2F8bwrfCYp2trnivOo=
X-Google-Smtp-Source: ADKCNb6x9RQoJkF/TXeuhXE1eLl3k4jJxCJ6qHv5eQ4gce67eKIc2TifuzbCkaro5wdmR2co4P7mbg==
X-Received: by 10.84.130.35 with SMTP id 32mr24084063plc.368.1505398665520;
        Thu, 14 Sep 2017 07:17:45 -0700 (PDT)
Received: from [192.168.43.71] ([27.62.157.254])
        by smtp.gmail.com with ESMTPSA id s81sm34468130pfg.162.2017.09.14.07.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2017 07:17:44 -0700 (PDT)
Subject: Re: [PATCH v2] commit-template: change a message to be more intuitive
To:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <<e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>
 <0102015e7b585037-5f88e775-2696-49ec-8dd9-5e1635a34607-000000@eu-west-1.amazonses.com>
 <862e71a1-2dee-4a20-d828-69a0547fa5ec@grubix.eu>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <2480c33b-7e44-5c7c-cd31-feae9168b9dc@gmail.com>
Date:   Thu, 14 Sep 2017 19:47:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <862e71a1-2dee-4a20-d828-69a0547fa5ec@grubix.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 14 September 2017 01:06 PM, Michael J Gruber wrote:
> Kaartic Sivaraam venit, vidit, dixit 13.09.2017 15:05:
>>   void wt_status_add_cut_line(FILE *fp)
>>   {
>> -	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
>> +	const char *explanation = _("Do not modify or remove the line above.\nEverything below will be removed.");
> I don't want to complicate things. But now - due to the repeated usage
> of "remove" - these two sentences seem to be connected by an invisible
> "or else" ("will" vs. "would" not withstanding). i.e. "or else
> everything below will be removed, too", which is wrong. Before, they
> were separated more clearly.

At least I don't think they are connected by an invisible "or else" because
they appear on different lines,

    #

    # ------------------------ >8 ------------------------

    # Do not modify or remove the line above.

    # Everything below will be removed.

    diff --git a/hook-checks/hooks/applypatch-msg b/hook-checks/hooks/applypatch-msg

    new file mode 100755

    index 0000000..a5d7b84

    --- /dev/null

    +++ b/hook-checks/hooks/applypatch-msg

> Also, given all the translations that we have, it seems somewhat strange
> to try and foresee and workaround possible misunderstandings of commonly
> used English phrases.
I thought the translators wouldn't mind this! If they do, then it's 
better to drop
this patch.

---
Kaartic
