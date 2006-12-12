X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 13:36:16 +0100
Organization: At home
Message-ID: <elm7ji$m6g$1@sea.gmane.org>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 12 Dec 2006 12:34:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34091>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6q3-0000uq-3o for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751262AbWLLMeY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWLLMeY
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:34:24 -0500
Received: from main.gmane.org ([80.91.229.2]:38482 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751262AbWLLMeX
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 07:34:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gu6po-0006GF-9o for git@vger.kernel.org; Tue, 12 Dec 2006 13:34:12 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 13:34:12 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 12 Dec 2006
 13:34:12 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Bahadir Balban wrote:

> When I initialise a git repository, I use a subset of files in the
> project and leave out irrelevant files for performance reasons. Then
> when I need to make changes to a file not yet in the repository, the
> file is treated as new, and if I reset the change or change branches
> the file is gone.
> 
> Is there a good way of adding new files to git as if they had existed
> from the initial commit (or even better, since a particular commit)?
> This way I would only track the new changes I made to an existing
> file.

Generally, it is not possible without rewriting history. In git (in any
sane SCM) commits are atomic; there is no CVS-like bunch of per-file
histories. You can use cg-admin-rewritehist from Cogito (alternate UI
for git)... but as it was said somewhere else git is fast. And the rule
of thumb: check first, then optimize.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

