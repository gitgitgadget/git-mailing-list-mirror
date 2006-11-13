X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Mon, 13 Nov 2006 18:36:14 +0100
Message-ID: <81b0412b0611130936i6d5fe595y4ee3c7bf9c372eab@mail.gmail.com>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
	 <Pine.LNX.4.63.0611131333000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0611130934u67f4da98rd39412b07f2169c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 17:36:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O9qJQM+g0kyA+2q+D8yvgmmDJbHpHEayW0jFEMizGZMBT509+/jYj1zODKiKa2gGtJAxlw6muKGvhmcb2MoOldbrh/rg/y8r2oz5ABIJuGhJfN20cH3qXkEGnSLwcFnL58AW+z5p+UT4dChWBfwoN5lyNnA4qC0iFGINmqSCqvw=
In-Reply-To: <81b0412b0611130934u67f4da98rd39412b07f2169c0@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31304>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjfjI-0004RQ-6L for gcvg-git@gmane.org; Mon, 13 Nov
 2006 18:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755252AbWKMRgR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 12:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755285AbWKMRgR
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 12:36:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:54253 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755252AbWKMRgQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 12:36:16 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1146627ugc for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 09:36:15 -0800 (PST)
Received: by 10.78.203.13 with SMTP id a13mr6478780hug.1163439375045; Mon, 13
 Nov 2006 09:36:15 -0800 (PST)
Received: by 10.78.135.19 with HTTP; Mon, 13 Nov 2006 09:36:14 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

oh, damn. Sorry for the appended copy. It's behind a broken corporate
