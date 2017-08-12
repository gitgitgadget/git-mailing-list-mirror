Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1742D208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbdHLRBk (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 13:01:40 -0400
Received: from mout.web.de ([217.72.192.78]:49892 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751400AbdHLRBj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 13:01:39 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5wrF-1dR6L221aj-00xud5; Sat, 12
 Aug 2017 19:01:37 +0200
Date:   Sat, 12 Aug 2017 19:01:36 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Soul Trace <S-trace@list.ru>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git am sometimes unable to apply git format-patch output
 file
Message-ID: <20170812170136.GB21045@tor.lan>
References: <a6e69bd1-b91f-3150-c3a6-9378793e5e43@list.ru>
 <20170812162023.GA21045@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170812162023.GA21045@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:t2KZJvlu3PwCNUi9ai3m+TY/qxW+P+SghQgijmz99/4bn7YWfa/
 ne7jGBB6WaJ9QxxTb860IwpQFzXEhvx5zTudB4kJyEv9RueHnJ8VEmjsQ4X5U91gljPVPhK
 hW1FdRfMV9C5tRwYa9i+e1KYVq4TcwlAbkmhA8VwlfE9sEgdUQI5A9eSTS6BTRN+2w7D2J6
 qu/Y8L9TbYHMS+a6QyWxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PBnGqRtTe48=:ojBiIU74sErcwKVLcHe1PO
 oCKKX6YLMUXzbkkvb0JqZvvfktxyiPj0sJvXPwaLgpGUVaXWjr637R/1Xo0MT6NioGIlsOXmV
 YqkEFIA+iIanG1WhC/mzfg+RXOW1zKaKOe8T8dUeeMEFwWCa3IRyonRRck/dqCS1OwZuVZkqt
 o7rQcsbzmwEgs+gHSmS547mV/KsOSFuqU7I2OcmrrfCna3yZ4JJxekYmjfwVyHFzCJaVpoM/G
 WWye1OgkUsGjmQ2K/AhBBLVHKKD4ygf5rfMil4bg18QTMzTp+SQKwU3/2T7d5+XXDoDHKsPsN
 mnX68ll0vWbOLpI9SDYQYYa1XGD06qgLSs++uwmPFrOOuc3nMKsUEazAMfPVebd3Kpwutmqjs
 Y9RmgvOvw4cJ/ES1YV2vjWOCjzxJ8D6EWQUPxperiYHsLo7iPm15H6AR8wWuODXNppoJ0QR6p
 zRsphOSmTrHyrwN7S8kMN2I/yZB14ZxOEn2Fp2ogyL4ali/RJ4x6GuNrS5Y04JXg55SOn30pE
 +n0/BdKMd9NauTlJ08O+kLBkw1pTI0CMbBLJ74Jlw2SflQImmF6CJ+7pwoLtRG5xTmF8ZLaVG
 +kXACI+Z1iOcbEEU66l6A3xbEolZHgpzJQdAWnWLkCUYr45kNSB6c2QTxpOJeJyceEU2LJ+kU
 cshCQ+Owh1ZviPH0eSnY/wpCvNHdac/S/K4guqjIkX0GONs15nx/P5LI/uHj5BXu+fpyJygig
 4owe/SjihajtKIarwwfNdQv68GWQ7f/PL6NVMKjL4hdS6u+X/bNUEeC7GpgUCWI+U+JyPLFuJ
 SGLOEb1W3FVsxpdaNzQFFZXxTTl8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 06:20:23PM +0200, Torsten Bögershausen wrote:
> On Sat, Aug 12, 2017 at 07:02:59PM +0300, Soul Trace wrote:
> > Hello.
> > 
> > Using git i have found that git am command may sometimes fail to apply patch
> > file which was created by the git am command.
> > 
> > 
> > Steps to reproduce:
> 
> Excellent, thanks so much for the detailed bug report.
> This kind of information is really appreciated.
> 
> Why did I say excellent ?
> Because I am working on a patch, which -should- fix exactly this kind of issues.
> I send out a patch earlier this day, but it doesn't fix your issue, even if it should.
> I hope to have a fix soonish.

I need to correct mysef, a litte bit, this doesn't seem to be a bug, but a feature.
There are 2 things to be noticed:
- The xml file has been commited with CRLF
- git am strips the CR (because they -may- have been added by a mail program)

There are 2 different solutions:
a) Use git am --keep-cr
b) "Normalize" the xml file(s), and commit them to have LF in the repo,
    they can still have CRLF in the work tree, if needed.
    This is done by
    echo "*.xml text" >>.gitattributes
    touch *.xml
    git add *.xml .gitattributes
    git commit -m "Normalize xml files"


If you really need the xml files with CRLF, use this line instead:
    echo "*.xml eol=CRLF" >>.gitattributes

HTH
/Torsten
