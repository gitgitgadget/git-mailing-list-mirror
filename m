Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 13226 invoked by uid 107); 21 Feb 2010 15:23:56 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 10:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab0BUPX1 (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 10:23:27 -0500
Received: from mail-iw0-f177.google.com ([209.85.223.177]:50486 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab0BUPX0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2010 10:23:26 -0500
Received: by iwn7 with SMTP id 7so1601473iwn.4
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 07:23:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ensGU2K3460JQ1cNBdc4O6XbJJJLGCiWKoYtGlOKcdo=;
        b=w0P9QU8LZ5WIjSpilVDRjFTnhVFC3aVBrRf/IvTtbYswr1rH5xO+ClzAVsZCFxooJB
         RfLe2ouWGNjte5rAT8My6B6AbSi2uAZX3/UiwPlst14L7U8AvKnNfRBVPk+6orhHBOu/
         A+KsS1DVVoOUp28JZUrdS2w9QzP367GIxZ0UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JhNOVtkltppKpx2rVYf1zUBgCeh3T6guBLobOmr3vGXjCoMODRUaEPKdRDteO8a6Io
         tSKKHnhcRdLs+NQk0LoT7FB/EA2k6pC3GhWvtEpsw1ltUYXC33D9yf1nyaFgWrbnyt6q
         wRfbI7GnFl+E091ABrsPXbnEI0NcvywlX06uY=
MIME-Version: 1.0
Received: by 10.231.154.68 with SMTP id n4mr1208985ibw.72.1266765803734; Sun, 
	21 Feb 2010 07:23:23 -0800 (PST)
In-Reply-To: <20100221104015.GB5166@localhost>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
	 <1266721708-1060-4-git-send-email-rctay89@gmail.com>
	 <20100221104015.GB5166@localhost>
Date:	Sun, 21 Feb 2010 23:23:23 +0800
Message-ID: <be6fef0d1002210723t2cb55460n4dcc1d27ebef03fd@mail.gmail.com>
Subject: Re: [PATCH 3/7] http-push: remove useless condition
From:	Tay Ray Chuan <rctay89@gmail.com>
To:	Clemens Buchacher <drizzd@aon.at>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Sun, Feb 21, 2010 at 6:40 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> On Sun, Feb 21, 2010 at 11:08:24AM +0800, Tay Ray Chuan wrote:
>> -                     if (push_verbosely || 1)
>> +                     if (push_verbosely)
>>                               fprintf(stderr, "'%s': up-to-date\n", ref->name);
>
> Just a minor nit-pick. If you end up doing a resend, maybe you could change
> the commit message to this one, since you're actually adding a condition
> that was previously disabled, not removing it.

yes, that makes sense..

-- 
Cheers,
Ray Chuan
