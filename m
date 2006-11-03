X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-format-patch little gripe
Date: Fri, 3 Nov 2006 12:37:52 -0800 (PST)
Message-ID: <20061103203752.26472.qmail@web31810.mail.mud.yahoo.com>
References: <20061103185026.GA28566@coredump.intra.peff.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 3 Nov 2006 20:38:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VY3LovGDCoNrxWAo4+5437q0zTtN2vgOKiMjVvfljAS68dhtyrXmQne9evY7ydTgPo1vOjaHuUN/0/jHdd+rbSZzb60a25AQEFxVLJrmevaBEZKfc4Ov73lj5WwiNj6EJT6E0DwkcGHlqsXTCXRdaygDdo2D+RgNtxshKyDAN1Y=  ;
X-YMail-OSG: hxz4p94VM1kG0da9mKgiTnKKy4VNhjaYTPUJjSSflF4JyTnbbaCRbDGjnMtqsVIR4A--
In-Reply-To: <20061103185026.GA28566@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30883>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg5nZ-0004tG-7L for gcvg-git@gmane.org; Fri, 03 Nov
 2006 21:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753492AbWKCUhx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbWKCUhx
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 15:37:53 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:11099 "HELO
 web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1753492AbWKCUhx (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 15:37:53 -0500
Received: (qmail 26474 invoked by uid 60001); 3 Nov 2006 20:37:52 -0000
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Fri,
 03 Nov 2006 12:37:52 PST
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

--- Jeff King <peff@peff.net> wrote:
> For my own workflow, I don't want to have to pick the commit out of
> rev-list (or log) output. I want to find it and hit a button to say "OK,
> now mail this patch." So I put _all_ of my patches into an mbox, and
> then browse them with mutt. Sort of a poor man's patch browser, but then
> I'm ready to jump into mailing them immediately.
> 
> I use the following script:
> 
> #!/bin/sh
> root=${1:-origin}
> git-format-patch -s --stdout $root >.mbox
> mutt -f .mbox
> rm -f .mbox
> 
> And then in mutt, I use this macro to bind 'b' to editing the full
> message w/ headers:
> 
> macro index b ":set edit_headers=yes<enter><resend-message>:set edit_headers=no<enter>"
> 
> I know that may be useless if you're not using mutt, but I just wanted
> to stimulate some discussion among patch submitters about how they
> actually do it. I'm not sure how configurable tig is, but it shouldn't
> be too hard to add something like this to it.

That's very cool!

   Luben
