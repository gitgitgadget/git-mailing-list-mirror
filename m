X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Sat, 02 Dec 2006 09:57:22 +0100
Organization: At home
Message-ID: <ekrf1q$v72$2@sea.gmane.org>
References: <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org> <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org> <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net> <456ECDAF.4050102@op5.se> <20061130200122.GD10999@thunk.org> <ekndmb$7e9$1@sea.gmane.org> <456FFC10.7060703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 09:00:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 41
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33010>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqQjJ-0004RG-M7 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 10:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162844AbWLBJAN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 04:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162845AbWLBJAN
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 04:00:13 -0500
Received: from main.gmane.org ([80.91.229.2]:40590 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162844AbWLBJAL (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 04:00:11 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GqQj4-0004Nk-Px for git@vger.kernel.org; Sat, 02 Dec 2006 10:00:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 10:00:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 10:00:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:

> ---%<---%<---%<---
> SYNOPSIS
> --------
> 'git-diff' [ --diff-options ] <tree-ish>{0,2} [<path>...]
> 
> DESCRIPTION
> -----------
> Show changes between two trees, a tree and the working tree, a
> tree and the index file, or the index file and the working tree.
> The combination of what is compared with what is determined by
> the number of trees given to the command.
> 
> * When no <tree-ish> is given, the working tree and the index
>    file are compared, using `git-diff-files`.
> 
> * When one <tree-ish> is given, the working tree and the named
>    tree are compared, using `git-diff-index`.  The option
>    `--index` can be given to compare the index file and
>    the named tree.
>    `--cached` is a deprecated alias for `--index`. It's use is
>    discouraged.
> 
> * When two <tree-ish>s are given, these two trees are compared
>    using `git-diff-tree`.
> ---%<---%<---%<---
> 
> This needs an update, I think. I'll look into it on sunday if no-one's 
> beaten me to it.

You might want to use Junio proposal in
  Message-ID: <7vhcwgcf39.fsf@assigned-by-dhcp.cox.net>
  http://permalink.gmane.org/gmane.comp.version-control.git/32853
(and perhaps also my reply to it)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

