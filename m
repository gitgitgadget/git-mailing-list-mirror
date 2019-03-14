Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD4320248
	for <e@80x24.org>; Thu, 14 Mar 2019 17:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfCNRAf (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 13:00:35 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:43918 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfCNRAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 13:00:35 -0400
Received: by mail-yw1-f52.google.com with SMTP id j66so4976537ywc.10
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Jnu2HVjW+EDlWPj38rol4kljf3FSzyxdBRLCqCDfJmo=;
        b=mlkEQD2YIAIHuoVWLG6PqFDf1Kr2+fJQm8igHF9nwSqM/XKxdNB3DY1F/YphXsu5mP
         PsXWG11Tol3WhXu0Yku6Si2rcI4RxKer6SgmnxAuV3MYu5oAb9k0Wp6x9PX9QekaXIX+
         KsaK0AV38O/RUScBk47p99J5azdCwS/ztxGz/3Okd9Yx6XFctj9YirhDpnThNgXqwysY
         IUOYSn6ICcyK2aQm/C1orjHGT3I4glAsm+3HwGr5j6wxNUogdgjigzbSkAOXKRLjpdPH
         KVAB1DXrJsFzqWbyxudVXDqSuVDvE6V7a2lFjSoIlDGaUxcbJnv+6w+54lpC1salD+xu
         Ztuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jnu2HVjW+EDlWPj38rol4kljf3FSzyxdBRLCqCDfJmo=;
        b=AG7xbuxWbcTFtQsmAUr6pVHCVjWX+mfbCBdCpyKqhpBPrvpkI52YSdbwrre/tkEO6Y
         +fP+lSCuPHSBFTJIHLjFYDpPVw9qG/03rv7fjaswQCIK1tmCs5258lZrAYSqyzEQTWFd
         nBsYDjEF4dUIxdr3vkyk4SdT0CjSRUAs1YPHo7Tfw+PZU9NNHK7duOtL+F5yQ3FnE1Ss
         KIBYyIJmJ4Dnom6mlA1UvkwmtL8pvvcWRF8AYwhQbSdF4NPFT0Qj6ZLTFrYFk/LOM7eN
         403Sd7ndH5NkcLvKnlDvgaM8JyBAW7NEBOK0eRNsDtLdQ3iHBPk1N70tQmZNEyyWvb6a
         to5w==
X-Gm-Message-State: APjAAAVFarTFjU9hMUPIfDuByQC65keZsLDWt1NQ3AOO9tbb4ERsglZO
        0Hei+PVfbw3QA27LavnDOtniidGq
X-Google-Smtp-Source: APXvYqxJ6z3mjTB9f5OGbQEdKsjffNjQzsXdMtJZgoL4fTeCU5T8KGaaDQu0sZMI5RFtkj+XZSVpew==
X-Received: by 2002:a81:7a0b:: with SMTP id v11mr16513295ywc.127.1552582834138;
        Thu, 14 Mar 2019 10:00:34 -0700 (PDT)
Received: from [192.168.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 206sm5024047yws.95.2019.03.14.10.00.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 10:00:33 -0700 (PDT)
Subject: Re: straw poll: git merge conference location
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190313205539.GA30425@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c0912b7f-6a83-c211-e50d-158322e3f300@gmail.com>
Date:   Thu, 14 Mar 2019 13:00:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190313205539.GA30425@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/2019 4:55 PM, Jeff King wrote:
> We're looking at doing it in North America, but there are two specific
> questions:
> 
>   - is there preference between East Coast vs West Coast?

I have no preference here.

>   - preferences between Canada and US?

There should be serious consideration for Canada only because visa issues
may prevent some participants from traveling into the US. I know that
some academic conferences have moved from US to Canada (even after already
being scheduled for a US location) due to recent changes and general
volitility in visa policies. Perhaps I'm making a big deal about something
that doesn't affect any contributors that would join us, so I hope that
anyone concerned about this can speak up (or contact Peff privately).

Thanks,
-Stolee
