Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE83A208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 00:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbdIFASl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 20:18:41 -0400
Received: from onethreetwo.vfemail.net ([199.16.11.132]:63494 "EHLO
        vfemail.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752313AbdIFASk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 20:18:40 -0400
Received: (qmail 95725 invoked by uid 89); 6 Sep 2017 00:18:36 -0000
Received: from localhost (HELO freequeue.vfemail.net) (127.0.0.1)
  by localhost with (DHE-RSA-AES256-SHA encrypted) SMTP; 6 Sep 2017 00:18:34 -0000
Received: (qmail 68642 invoked by uid 89); 5 Sep 2017 22:17:32 -0000
Received: by simscan 1.4.0 ppid: 68638, pid: 68640, t: 0.1015s
         scanners:none
Received: from unknown (HELO smtp102-2.vfemail.net) (172.16.100.62)
  by FreeQueue with SMTP; 5 Sep 2017 22:17:32 -0000
Received: (qmail 25313 invoked by uid 89); 5 Sep 2017 22:17:32 -0000
Received: by simscan 1.4.0 ppid: 25307, pid: 25310, t: 0.0638s
         scanners:none
Received: from unknown (HELO localhost) (d2FmZmxlY29kZUBvcGVubWFpbC5jYw==@172.16.100.93)
  by 172.16.100.62 with ESMTPA; 5 Sep 2017 22:17:32 -0000
Date:   Tue, 05 Sep 2017 22:17:32 +0000
Message-ID: <20170905221732.Horde.QL8bINNPhkH82YmIiqhsUY9@vfemail.net>
From:   wafflecode@openmail.cc
To:     Torsten =?utf-8?b?QsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: Empty directories in Git: Current guidance for historical
 commits?
References: <20170905124743.Horde.bgYg8gUhE6ubSHtPAr3lCGl@vfemail.net>
 <f8ed8f0b-a2e1-9e7a-bf79-2b7629b838f2@web.de>
In-Reply-To: <f8ed8f0b-a2e1-9e7a-bf79-2b7629b838f2@web.de>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Quoting Torsten Bögershausen <tboegi@web.de>:

>> Is just dropping a ".gitignore" or "README" file in the empty  
>> directories during
>> conversion still the most reasonable approach?
>
> A .gitignore will, but may cost 0.001% CPU time when running "git status".
> I have seen systems that create a file called ".empty" in every directory.
>
>> If so, is there a way to do this
>> automatically during the conversion using "git svn" or the like?
>
> Not what I am aware of.
> And even if, the .empty files need to be removed, once the directory is
> removed.
> And we don't have logic for that, as far as I know.
>

So upon re-reading the git-svn docs, there apparently _are_  
"--preserve-empty-dirs" and "--placeholder-filename=<filename>" options.

I'm not sure how I missed these.  :-/

If I understand correctly, it sounds like exactly what I want.  i.e. a  
placeholder file being added (and tracked) to each empty folder.  Are  
there known issues or limitations to be aware of?


Thank you,
David


-------------------------------------------------

ONLY AT VFEmail! - Use our Metadata Mitigator to keep your email out of the NSA's hands!
$24.95 ONETIME Lifetime accounts with Privacy Features!  
15GB disk! No bandwidth quotas!
Commercial and Bulk Mail Options!  
