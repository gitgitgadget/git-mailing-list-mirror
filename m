X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH qgit] Change also tag marks when changing graph size
Date: Tue, 24 Oct 2006 20:41:21 +0200
Message-ID: <200610242041.22230.Josef.Weidendorfer@gmx.de>
References: <e5bfff550610240947i30bc3fc0x49710e4cbb0f0556@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 24 Oct 2006 18:42:08 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <e5bfff550610240947i30bc3fc0x49710e4cbb0f0556@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcRDq-0001R5-OB for gcvg-git@gmane.org; Tue, 24 Oct
 2006 20:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161161AbWJXSlz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWJXSlz
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 14:41:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:7600 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161161AbWJXSly (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 14:41:54 -0400
Received: (qmail invoked by alias); 24 Oct 2006 18:41:50 -0000
Received: from p5496B1B5.dip0.t-ipconnect.de (EHLO noname) [84.150.177.181]
 by mail.gmx.net (mp023) with SMTP; 24 Oct 2006 20:41:50 +0200
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On Tuesday 24 October 2006 18:47, Marco Costalba wrote:
> When changing graph size with CTRL+ and CTRL-
> update also tag/branch marks.
> 
> Also little cleanup.
> ---
> 
> Hi Josef,
> 
>   please tell me if you are working on the same files, in this case I
> will step back and wait you to finish your patch series and eventually
> resubmit this one at the end.

No, that is fine. Currently, I have not much time.
Just curious: What did you expect next in my patch series? :-)

Now that everything is drawn directly, the question is what to do with
the new flexibility. E.g. we _could_ implement different
graph drawing algorithms next to the original qgit one,
e.g. mimicking gitk.
However, the highlighting functionality in gitk is really good, and I can
imagine changing the background and color of lanes/commits according to
e.g. ancestor/descendent from/to the nearest tag/branch head.

