X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 21:57:42 +0100
Organization: At home
Message-ID: <ejfutp$cgc$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net> <87wt5wsabs.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 15 Nov 2006 20:57:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31495>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRoZ-00067f-1T for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161503AbWKOU4z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161506AbWKOU4z
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:56:55 -0500
Received: from main.gmane.org ([80.91.229.2]:13005 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161503AbWKOU4y (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:56:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkRoC-00063x-73 for git@vger.kernel.org; Wed, 15 Nov 2006 21:56:36 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 21:56:36 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 21:56:36 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
>On Tue, 14 Nov 2006 16:31:50 -0800, Junio C Hamano wrote:
>>
>> For another example, having a commit command to commit
>> everything by default is disastrous for people who allow their
>> workflows to often be interrupted.
> 
> Workflow-interruption is an important thing to support, but separating
> update-index and commit really doesn't address it nearly as much as I
> would like. The lack of really good workflow-interruption support has
> been one of my longest-running annoyances with git, (perhaps because I
> have a problem with trying to do too many things at once). Git can
> create and change branches fast enough that it really should be able
> to help me better with this. The only missing piece is being able to
> stash the dirty stuff on the current branch, to be able to come back
> to it later. I've talked a bit about what I would like in this area
> before, and I really just need to code it up.

There is git-stash/git-unstash floating somewhere in the archive.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

