From: "J.V." <jvsrvcs@gmail.com>
Subject: stuck and need unstuck (git checkout)
Date: Mon, 25 Mar 2013 11:57:14 -0600
Message-ID: <51508FFA.4080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 25 18:57:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBea-0004Na-6s
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 18:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852Ab3CYR5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 13:57:24 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:48685 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758327Ab3CYR5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 13:57:23 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so3314440dad.29
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=jGHRcTQtj6KSY1onqhaFpCTSdSYmL64k0Uq76ifUZtM=;
        b=BFRPc9GUKzRma2+MA+Wcu+G9BL3f3HZPN3Dkv24dmGoTLdDZoJirymx0s3hB+/WnUm
         T6IxmcHFMttZyhIcIvws6Qdm+H7mxRZPnWSvIscDb40rF6qL2AwV9CvyCtqFwdEDzCV/
         JYHO3zIwlObLHM/Vw3LUnQ7vdT12wHPdboT0BfnYnZEcnjBAN8l4nWTCbhb3wHdmZ+Ky
         mBZ9Y2g8sscC8fgJl9geLx0XMa9hdK91LVvjkHNk0ea1/JVfVCXeuULc6uynLKNnFpPw
         FHYlHKohEnZ9V3oI39y2GaeXLQmR78HJdCRs4p2DGfHgSMyY7OPWn9mpR/enS3uh/pQy
         bYvw==
X-Received: by 10.66.139.166 with SMTP id qz6mr19011068pab.139.1364234242739;
        Mon, 25 Mar 2013 10:57:22 -0700 (PDT)
Received: from [10.16.242.114] ([192.206.100.4])
        by mx.google.com with ESMTPS id rr14sm14195637pbb.34.2013.03.25.10.57.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 10:57:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219052>

I was on a branch (local tracked with remote), and I wanted to checkout 
a remote branch so did:
     $git co myRemoteBranch

and got a message that a lot of jar files were being untracked (files 
were locked).  I had a server running that had some of the jar files 
locked, so it could not update and untracked them all.

What I want to do now is:
     1. switch branches
     2. delete this locally created branch
     3.  re-check out again so all will be well.

I cannot switch branches because it says my untracked files will be 
overwritten.  How do I switch branches? I have no commits to make and 
simply want to go back.  git reset and git stash do not get me there.

thanks

J.V.
