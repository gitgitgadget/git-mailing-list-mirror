X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: GIT - error: no such remote ref refs/heads/TestBranch
Date: Tue, 19 Dec 2006 14:33:07 -0600
Message-ID: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 20:33:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r9DA46EG37HsSwAkbuJ3hIwNugLdoVWtLd8c0N7UgV9jb6meaZ8ZLew9uKSFqyESUbvIvzpHIc/a4nG1MNg9OTaTh9YSDk5vXkA0LCNVRKGkrllYihf7b0ULmWTxUVlTqByct7A1sfn9H87NyQ9Z46H+Ed+2k/1HOG3C/H11fAI=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34850>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwleF-00027k-CT for gcvg-git@gmane.org; Tue, 19 Dec
 2006 21:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932935AbWLSUdK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 15:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932891AbWLSUdK
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 15:33:10 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:42284 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932935AbWLSUdJ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 15:33:09 -0500
Received: by an-out-0708.google.com with SMTP id b33so595740ana for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 12:33:09 -0800 (PST)
Received: by 10.78.47.15 with SMTP id u15mr4268866huu.1166560387474; Tue, 19
 Dec 2006 12:33:07 -0800 (PST)
Received: by 10.78.179.5 with HTTP; Tue, 19 Dec 2006 12:33:07 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I was wondering if someone could help me.  I had a branch on our
remote GIT server called TestBranch.  I logged into the Remote server
and ran:

<from remote server>
git branch -D TestBranch

But in my local clone:

kelleys@oifig:~/Work/kernel$ git pull origin
kelleys@git.example.com's password:
error: no such remote ref refs/heads/TestBranch
Fetch failure: git+ssh://git.example.com/data/git/proj/kernel/mh.git
kelleys@oifig:~/Work/kernel$

Any ideas how to correct this?

