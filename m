X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 12:44:15 +0000 (UTC)
Message-ID: <ei27mu$q9s$1@sea.gmane.org>
References: <200610291122.30852.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sun, 29 Oct 2006 12:44:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: backup.global.cn
User-Agent: pan 0.113 (0.113 is one of Nakata's favorites)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30430>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeA23-0005r8-6t for gcvg-git@gmane.org; Sun, 29 Oct
 2006 13:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965010AbWJ2Mop (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 07:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWJ2Mop
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 07:44:45 -0500
Received: from main.gmane.org ([80.91.229.2]:51851 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965010AbWJ2Moo (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 07:44:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GeA1g-0005nq-OQ for git@vger.kernel.org; Sun, 29 Oct 2006 13:44:32 +0100
Received: from backup.global.cn ([195.224.169.69]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Sun, 29 Oct 2006 13:44:32 +0100
Received: from wildfire by backup.global.cn with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 29 Oct 2006 13:44:32
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sun, 29 Oct 2006 11:22:30 +0100, Jakub Narebski wrote:

> You should be able to check new commitdiff view at
>   http://roke_DOT_dyndns_DOT_info/cgi-bin/gitweb/gitweb.cgi
> (URL mangling courtesy vger banned words list, aaaarrghhh)
> if I didn't screwed something again with firewall, and when my machine
> is up; should be for at least an hour. Check for example:
>   ?p=git.git;a=commitdiff;h=origin
>   ?p=git.git;a=commitdiff;h=161332a521fe10c41979bcd493d95e2ac562b7f
>   ?p=git.git;a=commitdiff;h=e12c095aa69d8aca0326eb11960427d9bf9e2db7
>   ?p=git.git;a=commitdiff;h=82560983997c961d9deafe0074b787c8484c2e1d
> and compare to (for example)
>   http://repo.or.cz/w/git.git?a=commitdiff;h=82560983997c961d9deafe0074b787c8484c2e1d
> or (even older gitweb)
>   http://www.kernel.org/git/?p=git/git.git;a=commitdiff;h=887a612fef942dd3e7dae452e2dc582738b0fb41
> BTW. this gitweb has also my previous "Slight improvement" patch applied.
> 
> Do you like it? What should be changed (code, output, style)?

I think your version looks a lot nicer but I believe that the commit
message area should be in a fixed-point font. In general it won't be a
problem but if anyone should choose to insert a diagram or something else
that assume a fixed-width display - it won't look good.

Anand
