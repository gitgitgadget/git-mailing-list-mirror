X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 02:23:04 +0100
Message-ID: <eibh94$t7n$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 01:23:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30679>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfRIa-0000Cm-Oj for gcvg-git@gmane.org; Thu, 02 Nov
 2006 02:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423132AbWKBBXN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 20:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423133AbWKBBXN
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 20:23:13 -0500
Received: from main.gmane.org ([80.91.229.2]:30888 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423132AbWKBBXM (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 20:23:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfRIM-0000B5-HI for git@vger.kernel.org; Thu, 02 Nov 2006 02:23:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 02 Nov 2006 02:23:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006 02:23:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


hi,

the convention to use a 'g' in the output of git-describe, eg.

   [lilydev@haring lilypond]$ git describe --abbrev=39
   lilypond_2_9_7-g47778d2297276484c861fc7536da13feb2d5fe8


is confusing: the g is also a hex digit, and without reading the manual 
carefully, you'd think this is the commit g4777.

Proposal: why not use

   tag#sha1

or some other non-hex character.

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
