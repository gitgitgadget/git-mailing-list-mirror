Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0203820248
	for <e@80x24.org>; Sun, 31 Mar 2019 21:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfCaVtF (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 17:49:05 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46885 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaVtF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 17:49:05 -0400
Received: by mail-wr1-f44.google.com with SMTP id t17so9303859wrw.13
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/4g536bWR3EE4BMdvgxEv+f0rkF2jIRKEn8plNEUNig=;
        b=qs6aWlvMKE/McJfzKRSjiNrRSNZmLssaQRpDgN+SmHyB3h46mjajfMEro0UrIG9iQB
         8QSbTvF9ZQj0iNRmDvtacdE5dxZi7mQy/SjoQ0XXOym4kzs74dO1tA/UECAKvjyTIhXF
         98j+fwZlB58zVmM3vrwmgsBndnawVp8e5Q8r4iogLvKwXDVmXUDbUefLX3YS76qr/pLm
         lUzuG4vSQkIP3k3/VmMOQUvF8Hj9yP2q6Iq5gLUtOtMtBLDk7qK46JkewIik73xa2hYa
         VdS38KJ2QEP3w38bgRcZ4M5dr4Z1DyWHgO68VZFsY9x2smAvH0fNlM3ENbnMxoiHLxyj
         38GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/4g536bWR3EE4BMdvgxEv+f0rkF2jIRKEn8plNEUNig=;
        b=MR9K1818PMG2NNl9H/E6I/Lf4yMzQ3dlJ9rpK35TfHF3ftiom8zCDEqqd8KKB38mzY
         NVPvQQYNvvnr4OJCuQe1RCSDVsP2Mel48381MryYqgyXHaxI5MSVdhx8V88CPA0CGC5R
         Vf6mXkFZNwQjKrg1Vx31bvVAc6OAV1iKRhf9VVzlgf2633djWKBX+1S/OM+OUh9z0Vr4
         MuTFKoq10bEhJAWTlX59mf65vv/+E/hgrr+aZtZdKkfHXqBDEz5w3ToPY/Bw/ZZ078Mx
         S+3pd5oZX53ki056OhNuEpSPjDROynynDiJ83jx6QtmVgVYxEkmX3Pm2czuuK3BAn9M1
         oUNQ==
X-Gm-Message-State: APjAAAVhneZ6IblqSn/y/1csvdx2DjB6q/Fa8Pj9tw5wNJbILK6Y3oyV
        krtPeowI+J8yTYdEsNjcVn0=
X-Google-Smtp-Source: APXvYqwtdghcHrqdLk7b/ds7uv0DpiUn4Xj59ZoInZb9R7fgpCXv0qipqxmygwyEZCQvOVLIeahS0w==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr37219781wrp.39.1554068943188;
        Sun, 31 Mar 2019 14:49:03 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id a23sm6567555wmm.46.2019.03.31.14.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 14:49:01 -0700 (PDT)
Date:   Sun, 31 Mar 2019 22:49:00 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Google "Season of Docs"
Message-ID: <20190331214900.GX32487@hank.intra.tgummerer.com>
References: <8bb78ce0-9b32-7c49-e4aa-ce9f31662627@thingbag.net>
 <572677cc-eef3-345b-e970-cd6cc80e8e96@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <572677cc-eef3-345b-e970-cd6cc80e8e96@iee.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Philip Oakley wrote:
> We mentor Summer of Code projects.
> Perhaps we should be doing something similar for docs.  Now Google are:

One thing that I think is worth highlighting, that I don't think is
clear from the blog post or this email, is that in contrast to Google
Summer of Code, Season of Docs targets experienced technical writers,
rather than students.  Just leaving this here for anyone that's just
reading this email and/or the blog post.
