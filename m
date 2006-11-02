X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Doug Reiland" <dreiland@gmail.com>
Subject: git and branches newie questions
Date: Thu, 2 Nov 2006 12:02:42 -0500
Message-ID: <6844644e0611020902tc6251f7i2eda0d3fc82e0502@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 17:03:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qLyML9obKwA74z4HNkkOPYRLo1nIea52Nutwm8RtPzE3/+XS/9EgST+UWtKDQqvmV87KPuvop1GnwXhlRBgK4qh0uw4LHAmBq1ayuKE3EhTnOkeIpiEZT+BsuVl2K+lY9Hs10Hou4VMFQIDv258m8IKt2lKpS0SOpNt8UCv4lOk=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30760>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gffxz-0005IL-Gn for gcvg-git@gmane.org; Thu, 02 Nov
 2006 18:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751067AbWKBRCo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 12:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWKBRCo
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 12:02:44 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:28235 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1751067AbWKBRCn
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 12:02:43 -0500
Received: by py-out-1112.google.com with SMTP id a73so134410pye for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 09:02:42 -0800 (PST)
Received: by 10.35.62.1 with SMTP id p1mr1279328pyk.1162486962121; Thu, 02
 Nov 2006 09:02:42 -0800 (PST)
Received: by 10.35.34.17 with HTTP; Thu, 2 Nov 2006 09:02:41 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I need some suggestions for the best way to setup my repositories.

I have a linux repository cloned right from Linus.
I want to create 2 additional branches in this repository:
   internal_current and internal_testing

I want to use internal_current to make modifications to the main Linux
branch for an internal project.

I want other users to clone/pull/push changes to the internal_current branch.

I want to use internal_testing as a branch to merge and test the
latest Linux branch with changes made to internal_current. Once this
testing is complete, merge the changes into internal_current.

That is the best way to do this. I am open to use cogito. I have
messed up this merging process just about each time, and I want to get
a stable process before I open this up to other users.

Also, I can't figure out permissions. I have setup the allow_users
hook in .git/hooks/update. My repository is "owned" by gate_keeper. My
user login is dreiland. I push changes back to the gate_keeper
repository and stuff under .git gets owned by me. Now, I log as a
gate_keeper to get a Linus update or perform the internal_testing
merges and things fail because it is owned by dreiland.

