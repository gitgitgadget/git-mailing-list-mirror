X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 07 Nov 2006 16:50:59 +0100
Organization: At home
Message-ID: <eiq9vm$l7c$1@sea.gmane.org>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com> <45507965.3010806@peralex.com> <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 7 Nov 2006 15:52:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31073>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhTEu-0005lI-Sx for gcvg-git@gmane.org; Tue, 07 Nov
 2006 16:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752470AbWKGPvU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 10:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbWKGPvU
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 10:51:20 -0500
Received: from main.gmane.org ([80.91.229.2]:37017 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752470AbWKGPvT (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 10:51:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GhTDu-0005V5-Qq for git@vger.kernel.org; Tue, 07 Nov 2006 16:50:52 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 16:50:50 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 07 Nov 2006
 16:50:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alex Riesen wrote:

>> So the problem is probably memory fragmentation.
> 
> probably.
> 
>> You might have more joy if you allocated one HUGE chunk immediately on
>> startup to use for the pack, and then kept re-using that chunk.
> 
> Well, it is not _one_ chunk. The windows/cygwin abomin...combination
> may take an issue with this: it seem to copy complete address space
> at fork, which even for such a small packs I have here takes system
> down lightly (yes, I tried it).

Perhaps planned mmapping only parts of packs would help there.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

