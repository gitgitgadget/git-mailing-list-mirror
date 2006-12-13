X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document the simple way of using of git-cat-file
Date: Thu, 14 Dec 2006 00:55:43 +0100
Organization: At home
Message-ID: <elq3pa$93b$1@sea.gmane.org>
References: <20061213221841.GB4928@fieldses.org> <20061213232056.11218.67473.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:54:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34266>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudvQ-0004G4-UQ for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751771AbWLMXyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWLMXyJ
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:54:09 -0500
Received: from main.gmane.org ([80.91.229.2]:36952 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751771AbWLMXyI
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:54:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gudv6-0002rV-Fh for git@vger.kernel.org; Thu, 14 Dec 2006 00:53:52 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:53:52 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 00:53:52 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Robin Rosenberg wrote:

> Since you can give a version and a path name to git-cat-file,
> mention it in the man page.

Very nice, with the exception that git cat-file can be used also
for trees and commits (although hit-ls-tree and git-show are usually
used) and for tags, not only for files.

I thought rather about copying last (or two last) entries about
extended sha1 syntax from git-rev-parse(1).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

