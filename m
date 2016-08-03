Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A420E20A8F
	for <e@80x24.org>; Wed,  3 Aug 2016 15:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbcHCPcO (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:32:14 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36490 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbcHCPcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:32:12 -0400
Received: by mail-qk0-f179.google.com with SMTP id v123so73155423qkh.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 08:32:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RYOk10eeTtv7bBB1wwpdt45DR5v4bIwZQcdbRs81pDE=;
        b=Bw30OneBrLkaUoieu1EgaVUVRSGm2jWVsN6aEtKVO0KX6j6mOEQPAsJMybaI17LMqr
         vc0894Fi9EBjkZX3mTS0Cr13g7Wxv6c/MDG2ejLgewIPgm8A+PSBFJ9/LZcp1V6RHgtv
         BRrEpfI4PXUEBMj5o8ohGgRfD2JrL3DYUKj8Q7rm83BSAmc1gUShmeybm9g+wBvtpLSx
         2oENINvir2RPmgXu92gmq/eIQz1TN/O+S0aHaIriRdpKMHa/pmWqC1W0WeI/hlJo1Lo8
         xzOMP/SDJRCzUQCa3wvaW45kXcS1C8L1iW8czJ+QjBmh0y0iNoPhMG6vvon/7DooO6aY
         Qdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RYOk10eeTtv7bBB1wwpdt45DR5v4bIwZQcdbRs81pDE=;
        b=Dv2U9AWdPqPJOr0tDKlla4qh6T3PmeKfHUQA0MzXdDVuJO5fv+PECdJilkJuhTTY06
         cMURRrEYvtZ7RxrEQPctWRUyTBF/1YG3Y9KN9NMraPWmZFOqD/gdtPAqDbnxCWKIQoEK
         CX+zomLvQQX+Fgq4g853CYDyPl/mp7aKYiftBRmjMTwbp1uNoeS0vtXIMMBYwf7mHen4
         mh3jq6YqJH1Q+3Ul1RgufWRnpWojMnpuFyOHVvsrWUbQ9VIgpvoTsOYATtKXjuMu6Jk9
         nzu0FEDRXwgDcawhixRHuvRztvTarLs+Pnvf+9e52tobq18IdUBMLz5NFmbw4rlbswbv
         KgjQ==
X-Gm-Message-State: AEkoouvd99uKUUiemJ5PHykaPIFsSSGJOjrNVlKM24mKcRVJQ+l/fxfiU4jsNeVYpydQ/FRP
X-Received: by 10.55.71.197 with SMTP id u188mr436589qka.97.1470237912450;
        Wed, 03 Aug 2016 08:25:12 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id o67sm4403858qkf.17.2016.08.03.08.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 08:25:11 -0700 (PDT)
Date:	Wed, 3 Aug 2016 11:25:11 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803152510.pgcd2edareqdxnmh@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
 <alpine.DEB.2.20.1608031721430.107993@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608031721430.107993@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

 > share things before they are published. Thankfully, this is OK in
> > USENIX's book. Here's the link:
> > http://i2.cdn.turner.com/cnnnext/dam/assets/160730192650-14new-week-in-politics-super-169.jpg
> 
> While I had a good laugh, I am wondering whether this is the correct link?

Oh my god, sorry, I meant to p, not to ctrl + v. My head is all over the
place as of late.

Here's the correct link:

http://isis.poly.edu/~jcappos/papers/torres_toto_usenixsec-2016.pdf

Thanks!
-Santiago.
