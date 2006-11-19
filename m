X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: gitk feature request: --goto
Date: 18 Nov 2006 22:32:15 -0500
Message-ID: <20061119033215.6916.qmail@science.horizon.com>
NNTP-Posting-Date: Sun, 19 Nov 2006 03:32:36 +0000 (UTC)
Cc: linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31824>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GldPw-0005Tf-5X for gcvg-git@gmane.org; Sun, 19 Nov
 2006 04:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755778AbWKSDcS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 22:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbWKSDcS
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 22:32:18 -0500
Received: from science.horizon.com ([192.35.100.1]:39208 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S1755778AbWKSDcR (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 22:32:17 -0500
Received: (qmail 6917 invoked by uid 1000); 18 Nov 2006 22:32:15 -0500
To: git@vger.kernel.org, paulus@samba.org
Sender: git-owner@vger.kernel.org

I was just writing beginner-level instructions for looking at a specific
commit in gitk ('double-click on the "SHA1 ID" box to selet the contents,
type "5401f304" in its place, and click "goto"'), and it dawned on me that
it would be easier to look at a given commit in context if there was a
--goto <commit-ish> option as well as the usual filtering options.

It might be a nice feature for "git bisect visualize" to preselect the
currently-being-tested commit, for example, rather than making the user
look for the "bisect" head.

And it seems like such a trivial thing to add, I figured I'd ask.

(You can add some highlight options as well, if you feel ambitious,
although I can't think of a use for them right now.)


Oh... when we add the option to have HEAD point to a non-head, it might
be nice to add a green box or other symbol for HEAD, too.  Just one more
