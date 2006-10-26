X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 13:25:59 +0200
Message-ID: <45409B47.8090402@op5.se>
References: <453536AE.6060601@utoronto.ca>	<200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca>	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>	<vpq4ptz2uh8.fsf@ecrins.imag.fr>	<453DAC87.8050203@research.canon.com.au>	<Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>	<Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>	<Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>	<Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>	<20061025084810.GA26618@coredump.intra.peff.net> <7v3b9cnlx7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 11:26:32 +0000 (UTC)
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	David Rientjes <rientjes@cs.washington.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <7v3b9cnlx7.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30192>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd3NB-0003rN-2T for gcvg-git@gmane.org; Thu, 26 Oct
 2006 13:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752142AbWJZL0F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 07:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbWJZL0F
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 07:26:05 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:47243 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752142AbWJZL0C (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 07:26:02 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 45FE86BE17; Thu,
 26 Oct 2006 13:26:01 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id B87D86BD3A; Thu, 26 Oct 2006 13:25:59 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> 
>  - Learn the itches David and other people have, that the
>    current git Porcelain-ish does not scratch well, and enrich
>    Documentation/technical with real-world working scripts built
>    around plumbing.
> 

Isn't this how git has been developed since day one, more or less? If a 
command is missing, it gets added as a shell-script. I agree with you on 
the "pipes from this sent here does this, and look how useful it is" 
lectures are gone since many commands were rewritten. Otoh, they're gone 
because they now instead provide examples on how to interface with the 
libified parts of git, so it's not a loss per se, just a switch in what 
it teaches.

I also agree with David that shell is much more fun to muck around with 
and prototype in, because you see results to much faster. However, since 
our plumbing is so rock-solid (and getting extended with --stdin options 
to more and more commands), I see no reason why we shouldn't have a "how 
to extend git" with the old shell-based porcelain scripts up somewhere 
at the web. Perhaps it would kill two birds with one stone and increase 
the addition of new utilities to git, while at the same time keeping the 
already rewritten commands in C.

Btw, the old shell-versions still work with the new plumbing (well, 
mostly anyways). They just have problems with filenames and revisions 
with spaces and special chars and things like that, same as they've 
always had.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
