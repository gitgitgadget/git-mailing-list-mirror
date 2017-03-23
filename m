Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4DCE20958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbdCWRrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:47:21 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35980 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdCWRrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:47:20 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so126627249pge.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OicENhBXGBnv+Rw4uALq37cMqvgyS1PbYxCVmL+C1t4=;
        b=KPaC03pMU6PsEZBhaLFC5ueZqrj8O+lnADEtrSNuCz0MS02Qwf8c9HYCft/U6Hl6E3
         j34APCqfAhiDtnkKOIjk9o+GNRgDGQDWf1mkDRDNtNfBC/y6srs3+xzZyhXiZj+TLADl
         KIW+OYDR0ELqv5FSVL9dYlXHJUyEnhCpzcvZRSb6ltEg/KVfKOgFJ8EW5qgAbF1KOtvq
         B+CbtgsasrLscUPEruo4j87au4S/QYGKcHk2rnBEoi/FNMWtyLIzt5DLpSAcWmeRDm0G
         gSbQuSQPEHJ0IPrCliZIV96WKPdBSB+vaP/CRI96mo7gcZNyKx88/fZ4SFGnOrPIAai7
         uMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OicENhBXGBnv+Rw4uALq37cMqvgyS1PbYxCVmL+C1t4=;
        b=CiG3+RtQWeTsc1ow1fxrdgd/jKiO8GLj6ooW8GlCrh5ZSGCQEUuNLlmwG63VGTUPa6
         dboiHud0YKDco1cY+f6VbBUin3YS1dv/4gn01xQb77FdAev06yOqv9R84F3lsrck97GE
         eMTLY4L0mv/p4kFck1KbZadAwgJanKusliyZDABnnfjM1tWp+PNCrapPwVPcLEOsSwcC
         Pho/eQPB3ebKFxvtsv4F4Ux/fdcZvWLgztt5RAtC3BIps1VFWhP1TK8K2pk5dlJu/axO
         VSn+tYNwKZXIwN/gk7VYoXJyaz//FvKD1HomdZXCzTHEJAWVmPRMob5e3CFxIeaPFTA+
         fThg==
X-Gm-Message-State: AFeK/H2lHXUWHuai15ok15DoTuZQc1yYhZKypvNf68Rx/UpwQL8t4/UaDvr0ws+4SB/plvDg
X-Received: by 10.99.149.6 with SMTP id p6mr4220703pgd.122.1490291238954;
        Thu, 23 Mar 2017 10:47:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:5cf0:9414:795c:7600])
        by smtp.gmail.com with ESMTPSA id p77sm11519191pfj.99.2017.03.23.10.47.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 10:47:17 -0700 (PDT)
Date:   Thu, 23 Mar 2017 10:47:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: fix missing newline
Message-ID: <20170323174716.GA111250@google.com>
References: <20170323170233.50499-1-bmwill@google.com>
 <alpine.DEB.2.20.1703231839570.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703231839570.3767@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/23, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Thu, 23 Mar 2017, Brandon Williams wrote:
> 
> > When using rebase --interactive where one of the lines is marked as
> > 'edit' this is the resulting output:
> > 
> >     Stopped at ec3b9c4...  stuffYou can amend the commit now, with
> 
> Ugh, I should have caught this. The warning() call implicitly adds a
> newline, the fprintf() doesn't.
> 
> Patch is obviously good.

All good.  If we're keeping score for finding each others bugs, I still
think you're winning :)

-- 
Brandon Williams
