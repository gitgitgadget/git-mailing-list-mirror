Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1FB208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 09:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbdHTJKS (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 05:10:18 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37972 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdHTJKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 05:10:17 -0400
Received: by mail-pg0-f48.google.com with SMTP id m133so1712862pga.5
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=yq2uesO7I2P77srE2sljNDknLfqxiY8jngI1BfXEep0=;
        b=kcqV37Dg2QEWe0QwEmxuGbqoncyG/Xw1pYoFwjIb3MXvPNpTh5Et2zbgFYXv7EtFOR
         rgfdHhKDFpDp40PhTywTyr8jK7HF5BwfEizx/p/5Hu2j1Zld1WrT7mGgMWlLEJZKy6op
         +xIV+ux6Hon3EVHO4H1bCvIchrRb7FWp+GLHdtYtHFAqIpqPKQudRQWX//cllTc1J724
         7u21HGNw/3H3qXa92iQldWmSkB7fnmgAkl1dG6tpl1wTbT0K5FwihhQLM7vnWZewPdWe
         9i1g2NGTDkIJtPZf+Ac18KZRp46EfgMGUFdKsMCddodAEv4RRiNuhNFsG9hlcVSCaVOV
         bryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=yq2uesO7I2P77srE2sljNDknLfqxiY8jngI1BfXEep0=;
        b=OGem97Y4krjCRJELzcVBnKu2/7Ofy4Dye46BgAiweZeo3/AzD/IRlC9eGqMi+wMpBC
         MDnDghHi0S5SrZw1IxDbRB1ae6kJA9wY24WuZGkKr9rROevJHqjQaDIdAb8cSUbdrcJQ
         w587x/J9yoVLMvRwyqag9QY4O4nqNtFNPXalevRCJvjSwtABtoTzTuexoRvAYgBuLFqO
         yLJsz+h7NSkEx10aEyE9UVfS4TO4i0cJaVoaV4QWQREDOWHMCWpH1SuS6rIO0oS1Oev4
         4Vv/OcyeBuAcJmJtpT6byTLCo/FYNl05tWZChn2W46z4dTNQyDfnLWdbYn0v1SQdsdTR
         yuBQ==
X-Gm-Message-State: AHYfb5gnDIAE/lEUGlzKkIOKlbOj+2Jv4jtuX2YiYtds83H+PxeFSgBH
        T7/drVOYqTH1Ej0iPYc=
X-Received: by 10.98.74.194 with SMTP id c63mr3097451pfj.227.1503220216767;
        Sun, 20 Aug 2017 02:10:16 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id p28sm1908516pfi.166.2017.08.20.02.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Aug 2017 02:10:16 -0700 (PDT)
Message-ID: <1503220271.5824.9.camel@gmail.com>
Subject: Re: Git *accepts* a branch name, it can't identity in the future?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
In-Reply-To: <829ac9ed-857d-84bf-2374-6a36b1d0aff1@kdbg.org>
References: <1503215489.5824.4.camel@gmail.com>
         <829ac9ed-857d-84bf-2374-6a36b1d0aff1@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 20 Aug 2017 14:41:11 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-08-20 at 10:20 +0200, Johannes Sixt wrote:
> It is not Git's fault that your terminal converts an invalid UTF-8 
> sequence (that your script produces) to �. Nor is it when you paste that 
> character onto the command line, that it is passed as a (correct) UTF-8 
> character.
> 

You're right. I just now realise how I missed the line between "what's
seen by us" and "what's seen by the program".


> Perhaps this helps (untested):
> 
> $ git branch -m done/$(printf '\x93')doc-fix done/dic-fix
> 

This one helped, thanks.

-- 
Kaartic
