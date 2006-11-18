X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Possible but in gitweb
Date: Sat, 18 Nov 2006 18:35:12 +0100
Organization: At home
Message-ID: <ejng62$k2m$1@sea.gmane.org>
References: <4d8e3fd30611180858xf28e958g8511f2eb68d53848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 18 Nov 2006 17:34:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 47
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31779>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlU4y-0002W1-ED for gcvg-git@gmane.org; Sat, 18 Nov
 2006 18:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755215AbWKRReI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbWKRReI
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 12:34:08 -0500
Received: from main.gmane.org ([80.91.229.2]:49291 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755215AbWKRReF (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 12:34:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GlU4n-0002TO-Um for git@vger.kernel.org; Sat, 18 Nov 2006 18:34:01 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 18:34:01 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 18 Nov 2006
 18:34:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:

> Hi all,
> I'm playing with a repo hosted by repos.os.cz and I think I faced a
> bug (Pasky confirmed that this should be reported here as a bug).
> 
> My repo has two branches,
> * master
>   html
> 
> Master contains a text file while html contains his conversion in html
> done via asciidoc.
> 
> I need to URLs that point to the top of the branches in order to have
> an easy way for linking the documentation to external portals.
> 
> This link points to HEAD, so top of master:
> http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob_plain;f=LinuxKernelDevelopmentProcess;hb=HEAD
>
> Browsing the repo I reach the following URL
> http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;hb=HEAD
> that is not accessible.
Because HEAD is master, not html, and there us no such file in master branch?

But all the following links
 http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;hb=html
 http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess;hb=master
 http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess;hb=HEAD
works

You can use
 http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git/html:/LinuxKernelDevelopmentProcess.html
or
 http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git/html:LinuxKernelDevelopmentProcess.html
(and there is remote possibility that links would work, too)

> Looks like is not possible to obtain a link to the top of a branch
> different from master.

It is possible, but you must specify the branch.

P.S. Please reply also to git mailing list...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

