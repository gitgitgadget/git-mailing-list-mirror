From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 16:56:47 +0200
Organization: At home
Message-ID: <ehao3e$2qv$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<200610172351.17377.jnareb@gmail.com>	<4535590C.4000004@utoronto.ca>	<200610180057.25411.jnareb@gmail.com>	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>	<20061018053647.GA3507@coredump.intra.peff.net>	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>	<20061018185225.GU20017@pasky.or.cz> <eh76np$trg$1@sea.gmane.org> <BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE> <4538D724.5040508@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Fri Oct 20 16:57:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gavoa-0004wh-NS
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992637AbWJTO5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992639AbWJTO53
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:57:29 -0400
Received: from main.gmane.org ([80.91.229.2]:45719 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S2992637AbWJTO52 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 10:57:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GavoC-0004sm-2R
	for git@vger.kernel.org; Fri, 20 Oct 2006 16:57:16 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 16:57:16 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 16:57:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29484>

Aaron Bentley wrote:

> Sean wrote:
> 
>> Petr already mentioned that the data currently shown in the email
>> text isn't really useful.
> 
> In Bazaar bundles, the text of the diff is an integral part of the data.
>  It is used to generate the text of all the files in the revision.

I thought that the diff was combined diff of changes.
 
> Bazaar bundles were designed to be used on mailing lists.  So you can
> review the changes from the diff, comment on them, and if it seems
> suitable, merge them.

If you have only mega-diff, you can comment only on this mega-diff.
It is more usefull for changes which have natural mult-commit history,
to review and comment on each of commits/patches in series _separately_.

>> Although that might just make the email bigger for not a lot of
>> gain.
> 
> It's my understanding that most changes discussed on lkml are provided
> as a series of patches.  Bazaar bundles are intended as a direct
> replacement for patches in that use case.

As _series_ of patches. You have git-format-patch + git-send-email
to format and send them, git-am to apply them (as patches, not as branch).

I was under an impression that user sees only mega-patch of all the
revisions in bundle together, and rest is for machine consumption only.

cg-bundle doesn't have this "mega-diff", but has shortlog (does bzr
bundle has shortlog/log of changes contained therein?) and diffstat
was planned.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
