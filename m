X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 12:02:07 +1300
Message-ID: <46a038f90612181502y3e2a41cds7f16113ad0270f31@mail.gmail.com>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	 <86r6uw9azn.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	 <86hcvs984c.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
	 <8664c896xv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 23:03:09 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ooBntUNqJ7/EPtt/JTSyMavEaxa7vxPR3Oa0j4PQZGdhRPSxr9HkAQECQpiulQqPneytjxguROhToj+bEJBZAmohuQKnvPDrwNAqpsJAHvIN3JnI3SDJbE7+kH7HxEk59SdPbFjEEtYtjuvd087bkjak0UcMvoNRqEbZh9opLMQ=
In-Reply-To: <8664c896xv.fsf@blue.stonehenge.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34756>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwRUs-0006W5-Dv for gcvg-git@gmane.org; Tue, 19 Dec
 2006 00:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754663AbWLRXCL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 18:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbWLRXCK
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 18:02:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:7371 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1754663AbWLRXCJ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec
 2006 18:02:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2081838nfa for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 15:02:08 -0800 (PST)
Received: by 10.49.43.2 with SMTP id v2mr4590144nfj.1166482928153; Mon, 18
 Dec 2006 15:02:08 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Mon, 18 Dec 2006 15:02:07 -0800 (PST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

On 18 Dec 2006 14:26:36 -0800, Randal L. Schwartz <merlyn@stonehenge.com> wrote:

> Linus> You're running this under OS X, aren't you? It's a pig of an OS, but
> Linus> "almost one hour" vs "25 seconds" is still unreasonable.
>
> I agree!

Me too -- but entirely possible. Disk IO is specially painful on OSX.
Stat calls are horrid. Using Arch (which abused stat calls to no end)
many ops would take 50x-100x longer on OSX than on Linux. A large
unpacked repo with git is a real pain -- and packing it can take
hours.

Once you are packed it's sweet, but large repos are a pain to deal
with. You won't impress anyone with performance over a linux kernel
repo -- starting up gitk can take a long time. Stat-heavy stuff like
git-diff is noticeably slower under OSX.

Have you got a linux partition you can boot into to get comparative timings?

[This is part of the reason I am migrating my OSX machine to Linux
fulltime, now that it seems that mergedfb+randr will let me switch to
dual monitors "hot".]

cheers,


