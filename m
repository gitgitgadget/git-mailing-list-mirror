X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Tue, 21 Nov 2006 11:07:31 +0100
Organization: At home
Message-ID: <ejuj2a$2ot$1@sea.gmane.org>
References: <200611202201.45521.jnareb@gmail.com> <b0943d9e0611210126x493848d9xae006af835fc62c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 10:10:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31982>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmSa5-0006iy-6Z for gcvg-git@gmane.org; Tue, 21 Nov
 2006 11:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030813AbWKUKKR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 05:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030814AbWKUKKQ
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 05:10:16 -0500
Received: from main.gmane.org ([80.91.229.2]:41650 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030813AbWKUKKP (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 05:10:15 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GmSZm-0006eD-VF for git@vger.kernel.org; Tue, 21 Nov 2006 11:10:03 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 11:10:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 11:10:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:

> On 20/11/06, Jakub Narebski <jnareb@gmail.com> wrote:

>> When removing stg branch (I wanted to remove
>> heads/base/gitweb/web) using "stg branch --delete gitweb/web" it
>> deleted also git branch when I wanted to remove only the StGit managed
>> indicator. Fortunately I was able to recover the branch from reflog, as
>> StGit didn't delete reflog with deletion of git branch.
>>
>> Perhaps that is correct behavior... but certainly unexpected.
> 
> I've never thought anyone would see a different meaing for the
> "branch" command. What you wanted to do was the reverse of the "init"
> command. Maybe something like "uninit" or a "--uninit" option to
> "branch".

Yes, that is what I wanted. "stg branch --unmanage" or something like that.

By the way, why "stg branch --delete" doesn't remove reflog? Not that I'm
complaining, because it sure saved some work when resurrecting branch, and
I didn't loose reflog info.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

