X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alan Chandler" <alan@chandlerfamily.org.uk>
Subject: Struggling with tangled
Date: Wed, 22 Nov 2006 10:37:19 +0000
Message-ID: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 10:37:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32076>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmpTo-0006Sf-Bp for gcvg-git@gmane.org; Wed, 22 Nov
 2006 11:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755626AbWKVKhV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 05:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbWKVKhV
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 05:37:21 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:51340 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1755626AbWKVKhU (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22
 Nov 2006 05:37:20 -0500
Received: from alan by home.chandlerfamily.org.uk with local (Exim 4.63)
 (envelope-from <alan@chandlerfamily.org.uk>) id 1GmpTj-000235-2n for
 git@vger.kernel.org; Wed, 22 Nov 2006 10:37:19 +0000
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I am trying to sort out a tangled (in the sense that I several branches that 
split a long time ago, but are reasonably close subsets of each other) 
repository of mine using git rebase.  I want to isolate the commits that 
cause the key differences so that I can then easily enhance the code but 
carry forward the variants (using git-rebase again probably). 

I have some questions which are causing me some grief after merge conflicts. 
Can someone help me. 

1) I often edit a merge conflicted file to the state I expect it to be in at 
the end.  This sometimes means that I edit it to a state where no change is 
seen.  git-update-index notices this and doesn't do anything, but when I try 
git-rebase --continue it won't because it says git-update-index has not been 
run.  What am I supposed to do then? [Is the answer git-rebase --skip ?] 

2) Some files get completely munged with conflict resolution markers every 
few lines.  Is there a simple way to say "don't use this file, but use the 
[stage2/stage3] sources of the merge". (ie one of the original inputs to the 
merge - and if so, which one is which) 

3) I sometime hit a merge conflict in a file which I know will actually be 
deleted at the tip of the topic I am rebasing.  Is there a way at this point 
to just tell the conflict resolution to say make this file go away. 

4) I repeat the question I asked in a thread above.  What is the --merge 
switch on git-rebase actually do.  The man page starts talking about merge 
strategies, but there already is a -s switch for that. 

 --
Alan Chandler
alan@chandlerfamily.org.uk
