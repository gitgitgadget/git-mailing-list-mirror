Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC00C2069B
	for <e@80x24.org>; Wed,  3 Aug 2016 14:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbcHCO6e (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 10:58:34 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36632 "EHLO
	mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbcHCO6d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 10:58:33 -0400
Received: by mail-qt0-f182.google.com with SMTP id 52so144836056qtq.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 07:58:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CrUTL5270OQAvSC0r42gtt2XnC5IGuWoLRf0NPAWWik=;
        b=f21cBJGuRfVW+kiOJflT4E1MyKClUsnEGtQUix9IeDUmeHL23pVO5ciT2JxJ5QQO8G
         7gzkIYBsw/nfGGYkFW12qZFVsj0jdfIqADZjF9O//iWKO/di8zYiM7L6ucF1YWE3zGHV
         p/fS8DraEWEkyetCmnCtJkPdq8Hhk+kvGJwK7V1wL9NeS2v0isW26J1f+2OZ/sJunI1k
         WMAz9bvLCLn9JFhkVZl7dx2sGj1RkRvN5Sq0uFTb2X+1v98TE6e8bhFIrO0Wdkmfw7rB
         GQN5jwupQHBM8kHKGIOUprhQobPF/uZLiBWbxmIU4f3a9MNk9ZiGHQNqGTVEgsszp8kP
         Xk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrUTL5270OQAvSC0r42gtt2XnC5IGuWoLRf0NPAWWik=;
        b=kY0bZFzaAwinznRrtIQ+88XW9kxyrpAkHqu+mo6XyGqqrM6KMke9hQVtSjnD5YX8TG
         T11vGqz1OUwgd3aj77E3MKWZcribcJaT4GuPqu0DBNDJSFUWxKII1yN0/G5pm0x6CIzC
         oeuix55lOEpjJ7np0AEdB+shdpQ08o/CuhVcfNl9PHSbwra0H+zrN+rvRAuY36qUkG8R
         duXCqNOKliTbhPj5Zl387fikGzwTkXYwP3Dfs6t6PZ+VPe7XTMyjMJFvP2b5TlW2vA4f
         IETQX/9IYzrOwDD7I8YjsZ7+5c5pAh39sz6didTBG5UBZJ4wycAJMIv6uTMkZzzAFvxL
         PQyA==
X-Gm-Message-State: AEkoouu3ZjtjGCqSYBPFtywr+Lz8ugePIZnn0TYrYkuq9MGr6lIU8e/LPjphythGO7zpRpGe
X-Received: by 10.200.57.34 with SMTP id s31mr259129qtb.49.1470236312388;
        Wed, 03 Aug 2016 07:58:32 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id e33sm4334838qta.47.2016.08.03.07.58.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 07:58:31 -0700 (PDT)
Date:	Wed, 3 Aug 2016 10:58:31 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Git <git@vger.kernel.org>
Subject: [OT] USENIX paper on Git
Message-ID: <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello everyone,

I will be presenting a paper regarding the Git metadata issues that we
discussed at the beginning on the year on USENIX '16. I'm writing To
make everyone in this ML aware that this work exists and to bring
everyone into the loop.

I'm open for feedback and corrections. If anything seems odd imprecise
to the community, I can make an errata in the presentation (at least).
I'll also try to work towards making corrections anywhere if possible;
this is my first publication, so I wasn't sure if it was possible to
share things before they are published. Thankfully, this is OK in
USENIX's book. Here's the link:
http://i2.cdn.turner.com/cnnnext/dam/assets/160730192650-14new-week-in-politics-super-169.jpg

I do mention of work towards fixing these issues in upcoming versions of
Git. This is in reference to the issue with Git tags, although I hope to
continue working on Git in general once I have more time for it. Thanks
again for all the patience reviewing patches and discussing everything.

Thanks!
-Santiago.

P.S. Let me know if anyone is going to USENIX. I'm looking forward to
meeting!

[1] http://thread.gmane.org/gmane.comp.version-control.git/287649 *
I believe it to be this, but gmane seems to be down. 


