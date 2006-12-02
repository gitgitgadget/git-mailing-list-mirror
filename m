X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Request: Adding -q/--quiet option to git-cat-file
Date: Sat, 02 Dec 2006 22:32:33 +0100
Organization: At home
Message-ID: <eksr9n$s2c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 21:31:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33057>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqcRp-0008Ql-UG for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162494AbWLBVa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162497AbWLBVa7
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:30:59 -0500
Received: from main.gmane.org ([80.91.229.2]:36513 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162494AbWLBVa6 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:30:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqcRW-0008NP-Uo for git@vger.kernel.org; Sat, 02 Dec 2006 22:30:43 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 22:30:42 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 22:30:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The only "committag" gitweb implements now is linking the full 40-char sha
of a commit to a "commit" view. This requires checking the type of object
given by sha1... but git-cat-file -t writes errors to stdout if the object
does not exist. I'd rather not use additional call, using git-cat-file -e,
or using 'string' version of magic "-|" open to redirect stdout to /dev/null
(as it is additional fork anyway).

What I need is an option -q/--quiet to git-cat-file to forbid printing error
messages to stderr... but it looks like it would be easier to add it
universally for all commands, or add it to git wrapper.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

