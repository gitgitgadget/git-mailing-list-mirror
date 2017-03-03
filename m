Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BBB320133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdCCVaI (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:30:08 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34291 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbdCCVaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:30:07 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so13737129pgb.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rejofymlc39Go0oiKZUVjb/47rrxO/GAc/0wE2MQ0G4=;
        b=oI6cx110Sa8N6XR0Wo/Myh8U4BxdmmoPcoDv1lynrBH+VjdwK0CYBAMnjxwgJ2+2WG
         LK5nXvgbcbsTcTyO8SY+1TM7Xohsiw1rTycNBeS98Gy0AQgWGiYMU2q3PehVJIpC6p04
         oI3ePDU4/wQyAJBxlC9Tc970ykICCkYjSJxPAcwqsqg2hEbOLaaJSugnckwyV1MS6wJh
         H8LLUf0RS2ro/qJ/iltPWsFM+IqLeNMGWZSRLVQdsI7yCSlVChOczQyw71YP9Ds/5ni6
         GvpoxNiBdFTzk8pPDsaA5Kvol8Fpor2bJkXy29NPVAaoBICMFp+43ngP6xTC+OF6/WjA
         me7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rejofymlc39Go0oiKZUVjb/47rrxO/GAc/0wE2MQ0G4=;
        b=F2ELyN2mQ5omcJMQbFNrLvr8nr7nBmH1thzQTMEJUqVD8DlKfJZUKsq+AAR0m/802Z
         Y7K9qL9ps0r8hy9tpaTNJG90BV+leNKdCPCgdtNJBB2cTt4zD1b+Rl9DgQduT87j+MHu
         qRd34eNwzKbebxNFgKkPZtG6PuldcmLkkcp9+s0hiGmVWLpdMuNp1WsDRhxIrpP5XQSY
         e9Y950mhSKbtDlhwDn1XXbiMjQxivfHWZ8UXBrj+UJgnaCPyfEbLMckdq7DK/V2J0VPF
         xgrDfl+J9HY8NoHh1h51jZPz9YbyZvcBUcYTZINuMf0iie7y53cH8Y4wo0XlrywqNmN9
         /l2g==
X-Gm-Message-State: AMke39kD4d4GIFGh9CMZci/hcEgdxO0p4Hf9ovuV4+29by2Ci6DQO5dK9xxgJDgyeyNI/A==
X-Received: by 10.84.248.79 with SMTP id e15mr7159989pln.133.1488576518771;
        Fri, 03 Mar 2017 13:28:38 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id 80sm25264444pgd.39.2017.03.03.13.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 13:28:38 -0800 (PST)
Date:   Fri, 3 Mar 2017 13:28:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, davvid@gmail.com
Subject: Re: [PATCH 3/3] Remove outdated info in difftool manpage
Message-ID: <20170303212836.GB13790@arch-attack.localdomain>
References: <20170303115751.GA13225@arch-attack.localdomain>
 <alpine.DEB.2.20.1703031645470.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703031645470.3767@virtualbox>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 04:46:36PM +0100, Johannes Schindelin wrote:
> Hi Denton (or should I address you as Liu?),
Denton is fine, thanks.
> 
> On Fri, 3 Mar 2017, Denton Liu wrote:
> 
> > When difftool was rewritten in C, it removed the capability to read
> > fallback configs from mergetool. This changes the documentation to
> > reflect this.
> 
> Thanks for pointing that out. But that is probably an oversight on my
> part, not an intentional change...
Do you expect to be submitting a patch for this soon? Or, if not, would
it be fine if I went ahead and did it?
> 
> Ciao,
> Johannes
