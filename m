X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 16:26:33 +0100
Organization: At home
Message-ID: <eluemi$gc0$1@sea.gmane.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 15:24:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 66
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34514>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEvS-0000mE-D8 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752734AbWLOPYk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbWLOPYj
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:24:39 -0500
Received: from main.gmane.org ([80.91.229.2]:38495 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752734AbWLOPYj
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 10:24:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvEvF-0001CR-Tb for git@vger.kernel.org; Fri, 15 Dec 2006 16:24:29 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 16:24:29 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 16:24:29 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

By the way, could you use slightly smaller number of columns? TIA.

> On Thursday 2006 December 14 10:21, Junio C Hamano wrote:

>> But you never communicate with your own git repository using the
>> SHA-1 object names when talking about commits you made recently
> 
> How's this then:
> 
> $ git commit
> $ git commit
> $ git commit
> $ git reset HEAD^^^
> 
> "AGGGHHHHHH!  I meant HEAD^^"
> 
> At this point I start running "git-prune -n | grep commit" and some liberal 
> use of git-show to try and find the hash of the object so I can do
> 
> $ git reset --hard HASH_OF_OBJECT_I_STUPIDLY_ORPHANED

That is what reflog is for. By the way, is core.logAllRefUpdates set
to "true" (or "heads") by default now?

Although I'm not against

  $ git commit -v
  Revision XXXXXXXXXXXXXXXXXX successfully added.
 
Notice -v/-verbose option.

>> So I do not think "git commit" is a valid example.  I also agree
>> with Shawn that "git add" that says 6781 files were added is
>> pointless.
> 
> Okay.

And git-add has -v option (although not --verbose).

>>> I've always thought that programs that needed an expert/beginner split
>>> were badly designed.
>>
>> There probably is a truth in that.  Let's not add verbosity
>> unnecessarily.
> 
> My habit is always to be overly verbose in program output; however, I realise 
> that not everybody likes that.  None of these things cause me any difficulty 
> in my use of git.  However, my Dad also is an engineer, but he's not so 
> comfortable with VCS; for him almost every part of git is a mystery.  
> Commands that run and don't say anything are confusing because he didn't 
> really know what they were /meant/ to do; he's just got a set of recipes that 
> he knows to type.  He's probably an extreme case, and not a good model for 
> typical user - on the other hand, I would say that if he can use it, then it 
> is officially newbie-friendly. :-)

It would be nice to have some generic place in git config to specify
default options to git commands (at least for interactive shell). It
cannot be done using aliases. Perhaps defaults.<command> config variable?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

