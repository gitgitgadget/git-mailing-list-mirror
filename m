X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Mon, 20 Nov 2006 23:37:54 +0100
Organization: At home
Message-ID: <ejtal6$p8s$1@sea.gmane.org>
References: <200611202201.45521.jnareb@gmail.com> <20061120222812.GE12285@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 22:37:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 39
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31946>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmHlP-0007HR-NT for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966590AbWKTWhP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966417AbWKTWhP
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:37:15 -0500
Received: from main.gmane.org ([80.91.229.2]:34959 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966590AbWKTWhN (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:37:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmHl3-0007D4-Ff for git@vger.kernel.org; Mon, 20 Nov 2006 23:36:58 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 23:36:57 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 23:36:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

J. Bruce Fields wrote:

> On Mon, Nov 20, 2006 at 10:01:44PM +0100, Jakub Narebski wrote:
>
>> I have used StGit (wonderfull tool) to manage patches on git branch 
>> gitweb/web. Unfortunately, I have named stg branch the same as git 
>> branch. When removing stg branch (I wanted to remove 
>> heads/base/gitweb/web) using "stg branch --delete gitweb/web" it 
>> deleted also git branch when I wanted to remove only the StGit managed 
>> indicator.
> 
> You probably actually had to "stg branch --delete --force", didn't you?

Nope. "stg branch --delete gitweb/web"

> What you want is "stg commit".

No. Whole stack was committed, I wanted only get rid of
heads/base/gitweb/web (of StGit managed branch indicator).

>> Perhaps that is correct behavior... but certainly unexpected.
> 
> I think "stg branch --delete" is pretty clearly named and documented....

I thought it delete only stg branch, refs/base/gitwbe/web, and not
refs/heads/gitweb/web.
 
> The idea I guess was to make it possible to use stgit (and only stgit)
> for everything, and never type a git command.  It might have been better
> to make stgit only manage patch series, and admit that people should use
> git for the rest.  Then it might work more like you expect.

Yes, I expected to use StGit as a kind of preprocessing (branch preparation)
for git.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

