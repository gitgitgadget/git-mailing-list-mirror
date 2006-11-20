X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Mon, 20 Nov 2006 23:57:16 +0100
Organization: At home
Message-ID: <ejtbph$tod$1@sea.gmane.org>
References: <200611202201.45521.jnareb@gmail.com> <20061120222812.GE12285@fieldses.org> <ejtal6$p8s$1@sea.gmane.org> <20061120224800.GF12285@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 22:56:39 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31951>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmI3k-0003GM-UB for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966875AbWKTW4K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966644AbWKTW4K
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:56:10 -0500
Received: from main.gmane.org ([80.91.229.2]:36550 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966450AbWKTW4H (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:56:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmI3X-0003D6-Rg for git@vger.kernel.org; Mon, 20 Nov 2006 23:56:03 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 23:56:03 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 23:56:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

J. Bruce Fields wrote:

> On Mon, Nov 20, 2006 at 11:37:54PM +0100, Jakub Narebski wrote:
>> J. Bruce Fields wrote:

>>> The idea I guess was to make it possible to use stgit (and only stgit)
>>> for everything, and never type a git command.  It might have been better
>>> to make stgit only manage patch series, and admit that people should use
>>> git for the rest.  Then it might work more like you expect.
>> 
>> Yes, I expected to use StGit as a kind of preprocessing (branch preparation)
>> for git.
> 
> The multiple-porcelains idea seems like a mistake to me--it'd be fine if
> you're just adding new features on the side, but who wants to learn
> entirely different sets of commands, with subtly different syntax,
> semantics, and feature sets, for doing the same thing?

I don't think so. StGit seems that way because it mainly adds new feature:
patch management. But it can be used both as standalone SCM (like Quilt),
or as a tool to manage patches in branch (rebase/cherry-pick on steroids).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

