X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: check if a commit is ascendent of a specific commit
Date: Sat, 11 Nov 2006 12:15:13 +0100
Organization: At home
Message-ID: <ej4ba6$oqt$1@sea.gmane.org>
References: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 11 Nov 2006 11:14:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31212>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Giqoi-00089J-QC for gcvg-git@gmane.org; Sat, 11 Nov
 2006 12:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161767AbWKKLO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 06:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161779AbWKKLO2
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 06:14:28 -0500
Received: from main.gmane.org ([80.91.229.2]:43653 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161767AbWKKLO1 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 06:14:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GiqoW-00086y-G8 for git@vger.kernel.org; Sat, 11 Nov 2006 12:14:20 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 12:14:20 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 11 Nov 2006
 12:14:20 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:

> Hi,
> I want to create "git-amend-commit" to be able to amend commits before
> HEAD. So I need to check whether the commit I'm going to amend is
> ascendent of HEAD. Is there any way to check that?

You can only amend topmost commit in any branch. Anything else would
be rewriting history, starting from amended commit upwards in lineage
(parentage).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

