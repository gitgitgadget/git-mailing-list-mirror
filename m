Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32F61FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756330AbcK3Vo3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:44:29 -0500
Received: from mwork.nabble.com ([162.253.133.43]:52820 "EHLO mwork.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756676AbcK3Vo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:44:28 -0500
Received: from mjim.nabble.com (unknown [162.253.133.84])
        by mwork.nabble.com (Postfix) with ESMTP id 93754730D506B
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:56:35 -0700 (MST)
Date:   Wed, 30 Nov 2016 13:56:35 -0700 (MST)
From:   Yojoa <dmoore@vailsys.com>
To:     git@vger.kernel.org
Message-ID: <1480539395581-7657459.post@n2.nabble.com>
Subject: CVSImport - spaces in CVS path
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm in the process of moving an entire collection of cvs modules into git.
I'm working in Mac Yosemite. Everything is working fine except for one
thing. A couple of the CVS modules have spaces in the paths. Below is what
my command line looks like. When the path has spaces I've tried putting it
in single and double quotes and using escape characters.  None of that
matters. I always get a message that it can't read dir/dir/path and then
messages that it can't find the modules "with" or "spaces".  

git cvsimport -v -d :pserver:MYLOGIN:/usr/local/cvsroot/
dir/dir/PathWithNoSpaces/dir    

git cvsimport -v -d :pserver:MYLOGIN:/usr/local/cvsroot/ dir/dir/path with
spaces/dir





--
View this message in context: http://git.661346.n2.nabble.com/CVSImport-spaces-in-CVS-path-tp7657459.html
Sent from the git mailing list archive at Nabble.com.
