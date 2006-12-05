X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding spell checker to GIT
Date: Tue, 05 Dec 2006 17:12:44 +0100
Organization: At home
Message-ID: <el45lt$ibr$1@sea.gmane.org>
References: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 16:11:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33352>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grcsx-0006pT-D0 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 17:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968412AbWLEQLH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 11:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968413AbWLEQLH
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 11:11:07 -0500
Received: from main.gmane.org ([80.91.229.2]:59138 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968412AbWLEQLF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 11:11:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Grcsf-00057A-QB for git@vger.kernel.org; Tue, 05 Dec 2006 17:10:53 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 17:10:53 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 17:10:53 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Deepak Barua wrote:

> Hi All,
>          I am just thought of a idea to integrate a spell checker with
> git so that when we check in the code the code comments are spell
> checked before being put into the tree,maybe have a optimized
> dictionary search.

> what about this...? is it appropriate ...?

As an example pre-commit/commit-msg hook? Take for example distributed
with git example of pre-commit hook ensuring that patch is whitespace
clean, and commit-msg hook which removes duplicated signoff lines.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

