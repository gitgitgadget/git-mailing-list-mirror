X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] merge-recursive: configurable 'merge' program
Date: Tue, 05 Dec 2006 01:01:55 +0100
Organization: At home
Message-ID: <el2cpj$cna$1@sea.gmane.org>
References: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 00:00:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33270>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrNjG-0005rR-JU for gcvg-git@gmane.org; Tue, 05 Dec
 2006 01:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967865AbWLEAAG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967866AbWLEAAG
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 19:00:06 -0500
Received: from main.gmane.org ([80.91.229.2]:59543 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S967865AbWLEAAD
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 19:00:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrNj0-0008M4-70 for git@vger.kernel.org; Tue, 05 Dec 2006 00:59:54 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 00:59:54 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 00:59:54 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sam Vilain wrote:

> For those who like to spawn interactive merge tools on a merge failure
> or otherwise run some kind of script, allow a "merge.tool" repo-config
> option that will take arguments as merge(1) does.

How it goes together with merge-recursive rewrite using built-in merge tool
from xdiff, xdl_merge?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

