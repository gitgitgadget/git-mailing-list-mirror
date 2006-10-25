X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 11:32:44 +0200
Organization: At home
Message-ID: <ehnauq$ou8$1@sea.gmane.org>
References: <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> <20061025084810.GA26618@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 25 Oct 2006 09:32:51 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 42
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30040>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcf7m-0006vW-Re for gcvg-git@gmane.org; Wed, 25 Oct
 2006 11:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423152AbWJYJce (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 05:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423153AbWJYJce
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 05:32:34 -0400
Received: from main.gmane.org ([80.91.229.2]:4528 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423152AbWJYJcd (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 05:32:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gcf7V-0006t4-Jg for git@vger.kernel.org; Wed, 25 Oct 2006 11:32:22 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 11:32:21 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 25 Oct 2006
 11:32:21 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

David Rientjes wrote:

> On Wed, 25 Oct 2006, Jeff King wrote:
> 
>> I don't understand how converting shell scripts to C has any impact
>> whatsoever on the usage of git. The plumbing shell scripts didn't go
>> away; you can still call them and they behave identically.
>> 
>> Is there some specific change in functionality that you're lamenting?
>> 
> 
> No, my criticism is against the added complexity which makes the 
> modification of git increasingly difficult with every new release.  It's a 
> pretty limited use case of the entire package, I'm sure, but one of the 
> major advantages that I saw in git early on was the ability to tailor it 
> to your own personal needs very easily with some simple shell knowledge 
> and enough C that was required at the time.
> 
[...]
>> Is there something you used to do with git that you no longer can? Is
>> there a reason you can't ignore the newer commands?
> 
> Functionality wise, no.  But in terms of being able to _customize_ my 
> version of git depending on how I want to use it, I've lost hope on the 
> whole idea.  It's a shame too because it appears as though the original 
> vision was one of efficiency and simplicity.  I would say that git-1.2.4 
> is my package of preference with some slight tweaking in the branching 
> department.

Ahah! So you miss the old script version of git commands, which you could
easily modify, tailoring it to your needs, isn't it? Well, if you don't mind
keeping your clone of git repository lying around somewhere, you can always
resurrect old shell version of some git command, e.g.
  $ git cat-file -p v1.2.4:git-prune.sh > $(git --exec-path)/git-prune.sh
change its name and modify as you used to do.

Are there any old commands which stopped working?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

