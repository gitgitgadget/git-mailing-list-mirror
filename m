X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Sat, 28 Oct 2006 16:00:28 +0200
Organization: At home
Message-ID: <ehvnob$tmj$1@sea.gmane.org>
References: <7vlkn3kn65.fsf@assigned-by-dhcp.cox.net> <200610270937.11368.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 28 Oct 2006 14:01:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30377>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdojs-0005Bq-LE for gcvg-git@gmane.org; Sat, 28 Oct
 2006 16:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751662AbWJ1OAl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 10:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbWJ1OAl
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 10:00:41 -0400
Received: from main.gmane.org ([80.91.229.2]:3477 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751662AbWJ1OAl (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 10:00:41 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GdojB-0004yc-QU for git@vger.kernel.org; Sat, 28 Oct 2006 16:00:02 +0200
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 16:00:01 +0200
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 28 Oct 2006
 16:00:01 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> prune_object() in show_only mode would previously just show the path to the
> object that would be deleted.  The path the object is stored in shouldn't be
> shown to users, they only know about sha1 identifiers so show that instead.

This allowed to 'rm -f' [some] of what git-prune -n shows.

Did anybody used that? I don't know...

> Further, the sha1 alone isn't that useful for examining what is going to be
> deleted.  This patch also adds the object type to the output, which makes it
> easy to pick out, say, the commits and use git-show to display them.

Well, you can always use git-lost-found. Perhaps it would be better to add
-n option to git-lost-found to not create refs in $GIT_DIR/lost-found/
directory.

Sorry for being late with that suggestion.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

