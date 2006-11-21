X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Tue, 21 Nov 2006 11:48:30 +0100
Message-ID: <200611211148.30937.jnareb@gmail.com>
References: <200611202201.45521.jnareb@gmail.com> <ejuj2a$2ot$1@sea.gmane.org> <tnx1wnxxfu3.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 10:47:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZKq6O8Z4adSLj/adUyHhOXXFDVaDNEOxsIpDu5VBHTXHfIC+hEhtYuqpULFCk965kOkqNgNKJJ2p34PuXNpXSzzXNfmucTw44DvWVy5HUtiApbCAsWecdtw9Rrgtzu8RUIC7hCnzXumYdVzgx13nplZa26HABNIm94f23+y5JKc=
User-Agent: KMail/1.9.3
In-Reply-To: <tnx1wnxxfu3.fsf@arm.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31984>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmT9k-0006CX-1E for gcvg-git@gmane.org; Tue, 21 Nov
 2006 11:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030840AbWKUKrH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 05:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030843AbWKUKrH
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 05:47:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:44346 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030840AbWKUKrE
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 05:47:04 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1464726ugc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 02:47:03 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr903789ugl.1164106022825; Tue, 21
 Nov 2006 02:47:02 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id x26sm9183746ugc.2006.11.21.02.47.02; Tue, 21 Nov
 2006 02:47:02 -0800 (PST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

>> By the way, why "stg branch --delete" doesn't remove reflog? Not that I'm
>> complaining, because it sure saved some work when resurrecting branch, and
>> I didn't loose reflog info.
> 
> Reflogs came into GIT after the StGIT branch command and never looked
> at them in detail. And maybe it should not touch the reflog info,
> especially for situations like this, unless GIT has a mechanism for a
> trash bin (StGIT has one for patches - .git/patches/<branch>/trash/ -
> but undocumented)

Well, I'm asking because "git branch -D" deletes also reflog. So I'm
worrying if StGit works with packed refs (although one usually do not
pack branches/heads, only tags).
-- 
Jakub Narebski
