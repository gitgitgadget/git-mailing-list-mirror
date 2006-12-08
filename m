X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 08 Dec 2006 14:55:11 +0300
Message-ID: <4579529F.9030401@Intel.com>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 11:56:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 10
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33691>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GseL0-0002NY-2h for gcvg-git@gmane.org; Fri, 08 Dec
 2006 12:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S938057AbWLHL4A (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 06:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938055AbWLHLz7
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 06:55:59 -0500
Received: from main.gmane.org ([80.91.229.2]:42073 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425425AbWLHLze
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 06:55:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GseK5-0006x0-DH for git@vger.kernel.org; Fri, 08 Dec 2006 12:55:26 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 12:55:25 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 12:55:25 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio Hamano wrote:
> +Instead of staging files after each individual change, you can
> +tell `git commit` to notice the changes to the tracked files in
> +your working tree and do corresponding `git add` and `git rm`
> +for you.  

This part is confusing as hell to anyone having any experience
with either CVS, SVN, Hg or Monotone, as doing "corresponding `git add`
and `git rm`" commands automatically will be interpreted as adding
untracked files automatically, which is not the case here.
