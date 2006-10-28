X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Move git_get_last_activity subroutine earlier
Date: Sat, 28 Oct 2006 21:20:46 +0200
Organization: At home
Message-ID: <ei0ags$l1l$1@sea.gmane.org>
References: <200610281943.40456.jnareb@gmail.com> <7vvem48dsr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 28 Oct 2006 19:20:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30391>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdtjE-0007Al-6V for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964833AbWJ1TUU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWJ1TUU
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:20:20 -0400
Received: from main.gmane.org ([80.91.229.2]:63706 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S964833AbWJ1TUS (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 15:20:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gdtj1-00078T-43 for git@vger.kernel.org; Sat, 28 Oct 2006 21:20:11 +0200
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 21:20:11 +0200
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 28 Oct 2006
 21:20:11 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Why is this needed?
 
This is purely cosmetic, and originally was to be first patch in series
converting git_summary, git_heads and git_tags to use of git-for-each-ref...
but unfortunately git-for-each-ref lacks sorting on taggerdate OR
committerdate (i.e. use taggerdate if applicable, committerdate otherwise).

I'd rather not have git_get_last_activity between two parse_* subroutines...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

