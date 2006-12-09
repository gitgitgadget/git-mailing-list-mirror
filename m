X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Sat, 09 Dec 2006 01:07:32 +0100
Organization: At home
Message-ID: <elcujo$g61$1@sea.gmane.org>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com> <200612082310.24140.Josef.Weidendorfer@gmx.de> <m2lkli9bwv.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 9 Dec 2006 00:06:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33775>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gspjl-00012K-4r for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947554AbWLIAGA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947549AbWLIAF4
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:05:56 -0500
Received: from main.gmane.org ([80.91.229.2]:59154 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947543AbWLIAFX
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 19:05:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GspiT-0003Ki-Cv for git@vger.kernel.org; Sat, 09 Dec 2006 01:05:21 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 01:05:21 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 09 Dec 2006
 01:05:21 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Seth Falcon wrote:

> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
>> On Friday 08 December 2006 21:45, Luben Tuikov wrote:
>>> This is how perforce does it*, and while it is useful, git is NOT perforce,
>>> and I agree with Junio and Jakub.
>>
>> However, the idea itself is not bad. AFAIK, cogito does it this way.
>> It could be done as separate command, e.g. "git add --interactive",
>> and would only update the index.
> 
> I think such a feature could be quite useful and it would seem to be
> an easy thing to provide in an optional or configurable fashion so
> that those that don't like it could avoid it.  
> 
> Spelling out a bunch of files spread around your tree for update-index
> can be annoying.  Some way of marking a list seems natural.  Maybe
> that is a separate issue.

Perhaps git-commit should also accept --exclude=<pattern> option?
Would that help?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

