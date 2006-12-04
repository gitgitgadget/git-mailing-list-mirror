X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Seeing added and removed files between two tree states
Date: Mon, 04 Dec 2006 17:25:45 +0000
Organization: Insert Joke Here
Message-ID: <1165253146.32764.3.camel@okra.transitives.com>
Reply-To: kernel-hacker@bennee.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 17:26:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.6.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33204>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrHZo-0003Xx-2r for gcvg-git@gmane.org; Mon, 04 Dec
 2006 18:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756325AbWLDRZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758405AbWLDRZ5
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 12:25:57 -0500
Received: from mx.transitive.com ([217.207.128.220]:41289 "EHLO
 pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1756325AbWLDRZ4 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4
 Dec 2006 12:25:56 -0500
Received: from [192.168.1.82] (helo=okra.transitives.com) by
 pennyblack.transitives.com with esmtp (Exim 4.50) id 1GrHPk-0003Sx-MC for
 git@vger.kernel.org; Mon, 04 Dec 2006 17:15:37 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

In there a way to see just what files where added between two points in
the tree? I want something better than parsing the diffstat.

I thought git-ls-files -ad comittish..comitishb would do the trick but
it seems not.

-- 
Alex, homepage: http://www.bennee.com/~alex/
... at least I thought I was dancing, 'til somebody stepped on my hand.
-- J. B. White
