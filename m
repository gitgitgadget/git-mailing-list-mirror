X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 15:28:09 +0100
Organization: At home
Message-ID: <elub92$v7q$4@sea.gmane.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <elpvro$rvj$1@sea.gmane.org> <200612140927.27259.andyparkins@gmail.com> <20061214093637.GC1747@spearce.org> <Pine.LNX.4.64.0612141205490.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 14:26:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34506>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvE0d-0000fx-TC for gcvg-git@gmane.org; Fri, 15 Dec
 2006 15:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752634AbWLOOZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 09:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLOOZ5
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 09:25:57 -0500
Received: from main.gmane.org ([80.91.229.2]:49453 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752634AbWLOOZ4
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 09:25:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvE0R-0005Dr-2h for git@vger.kernel.org; Fri, 15 Dec 2006 15:25:47 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 15:25:47 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 15:25:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

> On Thu, 14 Dec 2006, Shawn Pearce wrote:
> 
>> But I'm not sure that git-add should output anything.  Last I checked
>> the 'mv' command in Linux doesn't say "Move 5 files" when I move 5
>> files into a directory.  Likewise I don't think that knowing that
>> 6781 files were added is useful, what if it should have really been
>> 6782 files?  I'm unlikely to know, care, or realize it.
> 
> git-add -v does output added files already.

Ha! Now only get it to accept --verbose as long alternative to -v option,
and add -v/--verbose option to other similar commands (git-mv for example).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

