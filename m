X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 19:16:26 +0100
Organization: At home
Message-ID: <ejku76$7pr$1@sea.gmane.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117174446.GB11882@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 17 Nov 2006 18:15:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 46
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31721>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl8Fj-00074R-HQ for gcvg-git@gmane.org; Fri, 17 Nov
 2006 19:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755778AbWKQSPV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 13:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755775AbWKQSPV
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 13:15:21 -0500
Received: from main.gmane.org ([80.91.229.2]:64722 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755778AbWKQSPT (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 13:15:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl8F4-0006wj-BR for git@vger.kernel.org; Fri, 17 Nov 2006 19:15:10 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 19:15:10 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 19:15:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

J. Bruce Fields wrote:

> This has some useful material that fills gaps in the existing
> documentation.  We need to think a little more about the intended
> audience, and about how to fit it in with existing documentation.
> 
> On Thu, Nov 16, 2006 at 05:17:01PM -0500, linux@horizon.com wrote:
>> * A brief digression on command names.

> But the case I'm most interested in is the user whose
> distribution installs git for them, in which case I think the above
> could be distilled down to:
> 
>       - "git-foo" and "git foo" can be used interchangeably.

But it is encouraged (also for example by git-completion.bash) to use 
"git foo" form in command line (because git commands can be not in the PATH,
although usually they are), and "git-foo" form in scripts (if possible).

>> The details are too advanced for this discussion, but the default
>> "recursive" merge strategy that git uses solves the answer by merging
>> a and b into a temporary commit and using *that* as the merge base.
> 
> I'm tempted to ignore any description of the merge strategy, or postpone
> it till later; as a first pass I think it's better just to say "obvious
> cases will be handled automatically, and you'll be prompted for
> comments."  Only other SCM developers are going to wonder how you handle
> the corner cases.

See below...
 
>> * When merging goes wrong
> 
> But yes, I think people could use more help on how to resolve merges.

It would be useful to cover all non-reductible cases of recursive merge
strategy (the default merge strategy for two-head merges) conflicts: 
contents (covered), add/add, rename/modify etc.

So some info about recirsive merge strategy would be useful.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

