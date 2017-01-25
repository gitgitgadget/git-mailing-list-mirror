Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53171F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 16:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdAYQ7M (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 11:59:12 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37026 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdAYQ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 11:59:11 -0500
Received: by mail-wm0-f53.google.com with SMTP id c206so41330983wme.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=d3lGyBLBh69oPqkLJPsEq3CKAxB8RbEzVYsutkrix7I=;
        b=l3Isj6quCCDDFTYxrNVmU5Tk2eBDJD5cmrpxx6+MsePXG39ANDxUrj2cTccND+PgUf
         KqwPyuvSE45ndezXM6FH5pmU64emx4sp+x52pnOaV4OyzXZzIkZPyBCp52p/AYKPOxrS
         2hR4umT9ohtgjgiJfHvll+yOIQYmjoXdQZ/6oLAcACDjh31yqjn+8RfLGGqBn6rWUBf1
         L1V9qpkZakgyueiheg/TFoEfdse6Nry5u9l9ymaK15Nk0rfU1MDOIf6+9d9GRgKHAY2S
         mqgbkCtTwK0U0pHD4Nq57skGmeweDPLUpPl9e8z2qjD3be/2OR3jXldIYH8uGPSI5wAu
         KwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=d3lGyBLBh69oPqkLJPsEq3CKAxB8RbEzVYsutkrix7I=;
        b=m/8Yx07TXPBN9lWnijd4Qo0Pt5Tf0TnRfHlrmghIvPaLhMrnmojKTyuDhZtNcrKaX3
         QeXPHtoGF4Vmq+akWP07piSqUTGhLiwhAylIFC/C9D2Dt5JAJ+5v4VvCjV9+VAc7oc5p
         G7yLENS6428DOV2uNwySf5Nk20pLXFRFDuQhS05pwd3VoJl4AJRBPW/Y59Y27sN22yjm
         5VAAU6scQrjM+HbleQvdkOqwBzQsDhULoxMPdIGbaTLNb7tujZzZ25d63fWLtqvAEscL
         +m//2k4PfpcHcO/EcqxQqwm1i/HvEQC/t4BufFWhxen6lgpAdvg+D1nHBe8DIB21lzzf
         Ffrw==
X-Gm-Message-State: AIkVDXLw0I+fhCyrM7mWqkryOSAh9AtvzSTU9dKwAPkMVEEHGchUjvquY/D6hEkrTq0FVg==
X-Received: by 10.223.179.26 with SMTP id j26mr24916439wrd.126.1485363539609;
        Wed, 25 Jan 2017 08:58:59 -0800 (PST)
Received: from [161.111.219.63] ([161.111.219.63])
        by smtp.gmail.com with ESMTPSA id 18sm25867740wrb.14.2017.01.25.08.58.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 08:58:59 -0800 (PST)
To:     git@vger.kernel.org
From:   Jordi Durban <jordi.durban@gmail.com>
Subject: git clone problem
Message-ID: <ef188364-ccd2-e7f5-3c06-62afca79f8d3@gmail.com>
Date:   Wed, 25 Jan 2017 17:58:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all! Not sure if that will reach the goal, but let's it a try.

I have a problem with the git clone command: when I try to clone a 
remote repository with the following:

git clone --recursive https://github.com/whatever.git

what I actually obtain is a copy of my own files in the current directory.

I mean:

In the current directory:

$ls

-rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
-rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl

$git clone --recursive https://github.com/whatever.git WHATEVER

$ls

-rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
-rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl

-rwxr-xr-x 1  1,6K set  5 13:05 WHATEVER

$ls WHATEVER

-rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
-rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl

I am really confused with that.

Any help will be appreciated. Thank you

