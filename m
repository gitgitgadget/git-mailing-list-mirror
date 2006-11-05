X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: git-am vs. git-applymbox
Date: Sun, 05 Nov 2006 13:10:28 +0100
Organization: At home
Message-ID: <eikkaq$au7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 5 Nov 2006 12:10:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30975>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gggpb-0000jN-NP for gcvg-git@gmane.org; Sun, 05 Nov
 2006 13:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965599AbWKEMK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 07:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965855AbWKEMK2
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 07:10:28 -0500
Received: from main.gmane.org ([80.91.229.2]:16785 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965599AbWKEMK1 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 07:10:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GggpG-0000e0-IN for git@vger.kernel.org; Sun, 05 Nov 2006 13:10:10 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 05 Nov 2006 13:10:10 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 05 Nov 2006
 13:10:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

git-applymbox - Apply a series of patches in a mailbox
git-am        - Apply a series of patches in a mailbox

What are the differences between thos two commands, UI-wise and capability
(feature) wise? Which one should I use? Which one do _you_ use?


And why git has yet another set of commands which do the same (well,
git-annotate vs. git-blame "war" was won by git-blame, and git-pickaxe was
born).

By the way, could we standarize somewhat short options for git commands,
like -q for quiet, -v for verbose, -i for interactive, -S for pickaxe
(search in diff), -n for some kind of no-op/do nothing (e.g. --no-commit),
-f for force, -l for list, -k for skip errors/keep working even in the case
of errors? It would be nice to have this in Documentation/API somewhere...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

