X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Workflow example for remote repository use of GIT
Date: Tue, 28 Nov 2006 09:08:49 -0600
Message-ID: <89b129c60611280708x10a9c42fia23e6b7770971838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 15:09:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ptxi2ZpSpUjpOs5N9d/d1MsbzKBjnemAItMBU1WDKK+UZ26tZ2ZLMFYNqIQEpiT6y63nCrsl4Sn2Cygmyxj9j/k6TVfDOn6KflXItYCBZH2u2kOgKfVJN9yur1qLdzgOE75rDhwR4jKtfv4NHk8L1RvP03IA2WQn2K3dG9sC3sI=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32532>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4Zq-0001gr-CS for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934539AbWK1PIv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758684AbWK1PIv
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:08:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:11606 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758683AbWK1PIv
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:08:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1500349uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 07:08:49 -0800 (PST)
Received: by 10.78.127.3 with SMTP id z3mr992611huc.1164726529347; Tue, 28
 Nov 2006 07:08:49 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Tue, 28 Nov 2006 07:08:49 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I have been trying to set-up a workflow for developers in my group
using GIT. I came up with this simplified flow.  Do you all see any
problems with this approach?

Thanks,

Sean



Always work out of master

  git checkout master

Getting The Latest Upstream Code into master

  git pull origin master

Create a topic branch for your development work

  git checkout -b <new topic branch name>

Do your development in the topic branch

  edit/debug/test

Committing Changes

  git commit -a

Switch back to master

  git checkout master

Update the master branch from origin again

  git pull origin master

Now Merge your topic branch

  git pull . <topic branch to merge into current branch>

How do I push my changes to the original repository?

  git push origin master

-- 
