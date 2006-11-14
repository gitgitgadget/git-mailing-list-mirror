X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 15:53:18 +0100
Organization: At home
Message-ID: <ejcl6l$bo0$1@sea.gmane.org>
References: <20061114134958.5326.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 14 Nov 2006 14:54:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31347>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjzfH-0000NR-Hm for gcvg-git@gmane.org; Tue, 14 Nov
 2006 15:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965899AbWKNOxH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 09:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965886AbWKNOxH
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 09:53:07 -0500
Received: from main.gmane.org ([80.91.229.2]:27074 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965899AbWKNOxF (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 09:53:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GjzeO-00008n-SJ for git@vger.kernel.org; Tue, 14 Nov 2006 15:52:36 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 15:52:36 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 14 Nov 2006
 15:52:36 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:

> One thing I noticed is that with ref logs, you've just re-invented the
> CVS problem of associating history with a name.  If you want to rename
> a branch (say, from "mischacks" to something suitable for publication),
> do you rename the log or not?  It's a less virulent form, but it seems
> like the same disease.

Well, it would be nice to have command to rename branches (with its reflog)
and to rename tags (even in their packed format).

[...] 
> Then you could check out an arbitrary version without any of the annoyance
> above; I could "git checkout tags/foo" or even "git checkout deadbeef~3".
> I wouldn't be on a current branch (which would necessitate changing
> "git branch" output), so HEAD would simply contain an object ID directly
> rather than being a symlink/symref.

And what would happen if you want to checkout other branch? Where the ID
in the HEAD would go to? HEAD just _has_ to be reference to _branch_.
 
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

