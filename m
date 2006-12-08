X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Trouble with git-svn when upstream svn URL changed
Date: Fri, 08 Dec 2006 09:43:37 -0800
Message-ID: <m21wnai8qe.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 17:43:59 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=KoPPV2UE6BFAus/Hmrcx9wGsdMGig9qxFDYEulWWVNFb7/VFJsIk13YG7F9eXV9KqTELooYN3kNOJsdhhrrrmFf9eIRaOoNQUrALwkrursH7EybXQeoPw1RDtQW0YCXpkr3b+olyv8dixP36+JH4MUfoHpiauRmJkbLKURVCoF8=
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33714>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsjlA-0002g9-R4 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 18:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758219AbWLHRnk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 12:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbWLHRnj
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 12:43:39 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:43535 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758219AbWLHRni (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 12:43:38 -0500
Received: by an-out-0708.google.com with SMTP id b33so157187ana for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 09:43:38 -0800 (PST)
Received: by 10.100.107.2 with SMTP id f2mr4653139anc.1165599818185; Fri, 08
 Dec 2006 09:43:38 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 14sm5291466wrl.2006.12.08.09.43.36; Fri, 08 Dec 2006 09:43:37 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

One of the repositories I have been tracking with git-svn was
reorganized and the path that I have been tracking is now in a new
location.

I was hoping that the following would work:

   git clone orig new
   cd new
   git svn rebuild $NEW_URL

I also tried 

   git svn rebuild --remote $NEW_URL

This have some output that looked reasonable (svn rev nums and git
sha1's).  But git svn fetch does nothing and I don't seem to have any
of the new content.  Am I using this incorrectly?

I guess I can create a fresh git repos using git-svn init and then
fetch all of my dev branches from the original repository.

git version 1.4.4.1.g03c8-dirty (no changes to git-svn)

Thanks,

