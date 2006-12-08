X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Fri, 8 Dec 2006 12:10:00 -0800
Message-ID: <f2b55d220612081210u6ec3e95ciec6665a6b5e6a827@mail.gmail.com>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
	 <20061206192800.GC20320@spearce.org>
	 <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
	 <20061206194258.GD20320@spearce.org>
	 <20061206195142.GE20320@spearce.org> <45781639.1050208@op5.se>
	 <e5bfff550612081034q5e4c0c93s3512fce2f11b1fab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 20:10:14 +0000 (UTC)
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aiA2UHha3acSTJ+X0hpBAFR0xE19UqWJ/cWmULXZGQvNgtlpyabe22W3DwREds8NIrbfbjHXf8ExmFStVdiCfTckxCgC5xh+1Nss217MAFcz1EJMlH1jR9Bd59l1QThCI28bfP36M/IkTWItRtykl6uitgjN98VEXmRUMxCrcpg=
In-Reply-To: <e5bfff550612081034q5e4c0c93s3512fce2f11b1fab@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33736>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsm2s-0006LL-OI for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946372AbWLHUKH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946478AbWLHUKG
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:10:06 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:50309 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1946428AbWLHUKC (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 15:10:02 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1130196wra for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 12:10:00 -0800 (PST)
Received: by 10.90.50.1 with SMTP id x1mr4673893agx.1165608600747; Fri, 08
 Dec 2006 12:10:00 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Fri, 8 Dec 2006 12:10:00 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

There is a very handy solution to this problem called "tmpfs".  It
should already be mounted at /tmp.  Put tmp.txt there and your problem
will go away.

Cheers,
