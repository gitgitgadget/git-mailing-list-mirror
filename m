Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980B01F858
	for <e@80x24.org>; Wed,  3 Aug 2016 18:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbcHCSC3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:02:29 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35644 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbcHCSCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:02:23 -0400
Received: by mail-qk0-f176.google.com with SMTP id x185so17310050qkc.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 11:02:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uqWSJTh7A9//3DQ9vZyZAAEz4Gp4x5DYGHML64rMb6w=;
        b=SLbrnHApVALvV8fyfIQR/KTZ9DHnQMlnqkAfTvKEf5lsMDrmmgIWC48TOaKsOtR4eV
         zBbMLqXHDlk09RACilLX5o+Tv2206aKH8Tzb5Gf7moC4/FPkYy3NWLL/606+SjpIRo9w
         1/W9o7zOjtkJ3SJqt+7e45iOIN55qwu34HL5DkCNoQZ2B5YQGExrR6e/U1Zq+zYcJCrB
         XN/ZfjTZDLTQvCP4MV5zQdoyOju1lJyNILKhDf01PD+OxN4KEgiNfaaTZyfBKkDxuOyA
         Z7Ur9gJcq87wYPM7IffCneZZMbAJVtDfrQydO8sOxFKlLq4j0YAcNjiw6Jog74pJByTt
         N/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uqWSJTh7A9//3DQ9vZyZAAEz4Gp4x5DYGHML64rMb6w=;
        b=lTr0b39Xf5JQRYAGKzNeoAgF7Hw9ZsAwL/4KyzF/DKNqW1yAFMC4dPT+DNn/tLjDX/
         TfXu3Wvcx30hcknwbTS/q7YEAZBFwKJcHV0fqLSo/9Zu0Vz+yQ03JiDbm4IoF10CQQAH
         7wmU5KJrA+GaMM6GXy8nh+C1guz2PCysEqKPLZ79tVReTjtc/DjhSxqaCSWj+U4SrdjW
         zptH+l83VBdzvhmKjAyGMYAiaoGDikAzZRVMpxFq0kGDS9CcOy1/dxhnr3aPQ8svKei8
         bMjNHnSPSNr3uEpes42OHL/PkuMhcpapv7WKmqTckVkiZdfX43DJqvd0x0NvGAbRg7zE
         agkw==
X-Gm-Message-State: AEkoousDiFNDohGiUCNZYZGPIBiLaTNezsDqYdyL31mMkUIK5mzNjgyLr+jDBnBwbY6xkB8x
X-Received: by 10.55.182.135 with SMTP id g129mr1420696qkf.128.1470247336284;
        Wed, 03 Aug 2016 11:02:16 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id z1sm4718619qkc.40.2016.08.03.11.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 11:02:15 -0700 (PDT)
Date:	Wed, 3 Aug 2016 14:02:15 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Stefan Beller <sbeller@google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803180214.rxz455nlcm5hqn37@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
 <alpine.DEB.2.20.1608031721430.107993@virtualbox>
 <20160803152510.pgcd2edareqdxnmh@LykOS.localdomain>
 <CAGZ79kZPPvi2jpFgu1MZ97gZm=QqBBiZ-XcXUJphm3UzNRP-FQ@mail.gmail.com>
 <20160803172242.5jrd4saq7sga6iql@LykOS.localdomain>
 <CAGZ79kY8knsXEVqfbdoHGdEzOfygVoaZi43jy_yERnx=enuRcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY8knsXEVqfbdoHGdEzOfygVoaZi43jy_yERnx=enuRcA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 10:35:39AM -0700, Stefan Beller wrote:
> On Wed, Aug 3, 2016 at 10:22 AM, Santiago Torres <santiago@nyu.edu> wrote:
> > On Wed, Aug 03, 2016 at 10:14:21AM -0700, Stefan Beller wrote:
> >> On Wed, Aug 3, 2016 at 8:25 AM, Santiago Torres <santiago@nyu.edu> wrote:
> >> >  > share things before they are published. Thankfully, this is OK in
> >> >> > USENIX's book. Here's the link:
> >> >> > http://i2.cdn.turner.com/cnnnext/dam/assets/160730192650-14new-week-in-politics-super-169.jpg
> >> >>
> >> >> While I had a good laugh, I am wondering whether this is the correct link?
> >> >
> >> > Oh my god, sorry, I meant to p, not to ctrl + v. My head is all over the
> >> > place as of late.
> >> >
> >> > Here's the correct link:
> >> >
> >> > http://isis.poly.edu/~jcappos/papers/torres_toto_usenixsec-2016.pdf
> >>
> >> In 4.1 you write:
> >> > Finally, Git submodules are also vulnerable, as they automatically track
> >> > a tag (or branch). If a build dependency is included in a project as a part
> >> > of the submodule, a package might be vulnerable via an underlying library.
> >>
> >> Submodules actually track commits, not tags or branches.
> >>
> >> This is confusing for some users, e.g. the user intended to track
> >> a library at version 1.1, but it tracks 1234abcd instead (which is what
> >> 1.1 points at).
> >
> > I'm assuming that git submodule update does update where the ref points
> > to, does it not?
> >
> > let me dig into this and try to take the necessary measures to correct
> > this
> >
> 
> "git submodule update" updates to the recorded sha1, which I assume is used
> by downstream users. If you are a maintainer and  you want to update the
> library used, you'd be interested in have "git submodule update
> --remote" to update
> the sha1 to the tracking branch, which then exposes the attacks presented.

I see, I just tried to reproduce this, and it seems that, with a simple
git clone --recursive [path], the submodule fetched does not update to
the "malicious ref." You're right.

So, in the end, git submodule update --remote also requires you to
create a new tree, right? Then this attack wouldn't be possible by just
fiddling with the refs if signing is in place, right?

Thanks for clarifying!
-Santiago.
