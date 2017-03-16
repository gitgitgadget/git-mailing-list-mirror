Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D9120323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdCPTGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:06:36 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33576 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbdCPTGf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:06:35 -0400
Received: by mail-pg0-f46.google.com with SMTP id n190so29543075pga.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfyZSD1+aVNHfQSKN+HKe4ahK3QmUswPSvMoDJdsxaE=;
        b=qyVQrichN8+uRexYDjW9arEs2w4cqyy5npJbUdiGteSd/11One+Os9AEP3ie5Kr8uC
         OIBo/BxhsNQwE0dOXMSqN7ma8mGV0kcaboobTY/WzjFz5PfPrVuHefz6mcRyhHxMKzlq
         m3v9aSylz1G1VxpNiqu8dpbTN4CrILoPtkx4SbLcCf9a9CuNmv1yJ3uA6i+uOEatkFVH
         vAGwFrSkGLKSaGJXTzcJQCgPiA1eMdtEmMfestz7/U3Um9l7USsv/smVw3sblC9ybDfy
         iAQ52SXcBzsydjP9rdVpv81YJOLn5juct0k/MKV34xjsu+0aeGD5gNWb29GNZBOnJYAc
         H4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfyZSD1+aVNHfQSKN+HKe4ahK3QmUswPSvMoDJdsxaE=;
        b=fCKzHjyfRLYWqlnw62gPSmfh4eIxzcNZNgKtDm6b7XzTLJqvHBuiaPvTjITET3dXnb
         fX/Rl5S+Hhq29zfCKhWeqIflIJ4M2JcpIZ3df6Y6PhrVokUpq+8cDbKGtKgkJLWXNIYL
         M1UmMb2Xj1zB/ZtT/bVu57osuVZqSWZK9y4sKhjcrLCJtVZQxQGADwtd84Q1rCGTpvl7
         KAOJ/ZBw+/iTzZaEtBZrxXDYW6xHegY+0OkCmbDOFSuaobYRZvqQCDHSWWxovKhsLbS9
         tYi+YjS4+Zq9KKC/Rh3uHwaxI828XSP90OJMy1yaYwSeDO4kRlQUjLkHexkzGtyR5aH7
         Dv+Q==
X-Gm-Message-State: AFeK/H3qftIeyCosMJENcsIj+m1MvFrePuf5tpYbycOViTsm9ZNOe1Ju7BpWxXX1qF69Je9U
X-Received: by 10.98.137.152 with SMTP id n24mr12293397pfk.43.1489691193910;
        Thu, 16 Mar 2017 12:06:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:5992:ad5b:4930:50b4])
        by smtp.gmail.com with ESMTPSA id k76sm12040575pfg.42.2017.03.16.12.06.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 12:06:32 -0700 (PDT)
Date:   Thu, 16 Mar 2017 12:06:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        sourav mondal <souravcristiano502@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH]v2 adding built-in driver for javascript
Message-ID: <20170316190631.GA168812@google.com>
References: <20170313200854.6905-1-souravcristiano502@gmail.com>
 <CAP8UFD3toXk36wmJu+EeBnTvCa0yHWqCmQOfoJ0+2QTs8MpB-A@mail.gmail.com>
 <xmqqo9x1aw44.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0Exw4GPeat+xCgJdgd1E0dy0tu8JVpzkq=DnvGWArFDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0Exw4GPeat+xCgJdgd1E0dy0tu8JVpzkq=DnvGWArFDQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/16, Christian Couder wrote:
> On Thu, Mar 16, 2017 at 7:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> On Mon, Mar 13, 2017 at 9:08 PM, sourav mondal
> >> <souravcristiano502@gmail.com> wrote:
> >>> javascript is one of the famous langugae,it's needs a built-in driver.
> >>
> >> Please use "Javascript" instead of "javascript".
> >
> > While we are typo-spotting ;-) Wikipedia seems to prefer to spell it
> > "JavaScript".
> 
> Yeah thanks, and while at it, the "v2" in the subject should be inside
> the square brackets around "PATCH".

You can use the --reroll-count <n> option to format-patch to have format
patch place the v<n> inside the bracketed PATCH section.

-- 
Brandon Williams
