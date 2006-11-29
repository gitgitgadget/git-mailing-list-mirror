X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: gitk with arguments fails on OSX
Date: 29 Nov 2006 07:04:29 -0800
Message-ID: <864psixpj6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 15:04:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.6; tzolkin = 13 Cimi; haab = 19 Ceh
Original-Lines: 22
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32641>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpQzD-0004zS-KB for gcvg-git@gmane.org; Wed, 29 Nov
 2006 16:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967395AbWK2PEb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 10:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967396AbWK2PEb
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 10:04:31 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:57670 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S967395AbWK2PEa (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 10:04:30 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id E737B8FB81 for <git@vger.kernel.org>; Wed, 29 Nov
 2006 07:04:29 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 30089-01-92 for <git@vger.kernel.org>; Wed, 29 Nov 2006 07:04:29 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 56D818FBA5;
 Wed, 29 Nov 2006 07:04:29 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Using the native "wish", gitk fails on OSX 10.4 if given any arguments.
For example, the failure for "gitk --all" is:

    localhost.local:~/MIRROR/git-GIT % gitk --all
    Error in startup script: unknown option "-state"
        while executing
    ".bar.view entryconf 3 -state normal"
        invoked from within
    "if {$cmdline_files ne {} || $revtreeargs ne {}} {
        # create a view for the files/dirs specified on the command line
        set curview 1
        set selec..."
        (file "/opt/git/bin/gitk" line 6298)

What is -state ?  What version of tk does it require?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
