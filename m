X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: unmark after committing with git.el
Date: Wed, 06 Dec 2006 13:58:06 +0100
Organization: At home
Message-ID: <el6eku$vg7$3@sea.gmane.org>
References: <4576BB0B.9010200@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 13:00:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33452>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrwNf-0005fa-O8 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 14:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760578AbWLFNAI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 08:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760579AbWLFNAI
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 08:00:08 -0500
Received: from main.gmane.org ([80.91.229.2]:46509 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760578AbWLFNAG
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 08:00:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrwNW-00080h-EE for git@vger.kernel.org; Wed, 06 Dec 2006 14:00:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 14:00:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 14:00:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> in the usual workflow, I mark a few files, and then commit, and then
> mark another few for commit.
> 
> This patch removes the need to unmark between commits. 

This should be in commit message.
 
> 
> From ad694b33e033e3638043cd2d2970e6248beecb91 Mon Sep 17 00:00:00 2001
> From: Han-Wen Nienhuys <hanwen@xs4all.nl>
> Date: Wed, 6 Dec 2006 13:41:09 +0100
> Subject: [PATCH] git.el: unmark files in after committing.
> 
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>

But this break I think PCL-CVS behaviour compatibility. By the way,
[Backspace] should unmark all files.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

