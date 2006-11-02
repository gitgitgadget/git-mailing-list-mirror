X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Rebasing part of a branch
Date: Thu, 2 Nov 2006 11:45:23 +0100
Message-ID: <200611021045.25423.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 10:46:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H7oqdgwjdSyx6FiFCPFAdBs1babCwHvErSRSax8hUVkb94qABDxOLs5wCbrWXuvJMI4pyWMdR2+bCQTKnEjJCBRukpKMtcJ278fG+b5C7LjYavC4v3dKHDzqcuakT9Qeco79Uin/InK0RS7meAtyuBOP9+aMWkKfxm05Cpn/Xy4=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30710>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfa4z-0006L5-U6 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752820AbWKBKpc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbWKBKpb
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:45:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:21012 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752820AbWKBKpa
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:45:30 -0500
Received: by ug-out-1314.google.com with SMTP id m3so85635ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 02:45:29 -0800 (PST)
Received: by 10.67.96.14 with SMTP id y14mr414203ugl.1162464329289; Thu, 02
 Nov 2006 02:45:29 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m1sm1937012uge.2006.11.02.02.45.28; Thu, 02 Nov 2006 02:45:28 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

Is there a way to rebase part of a branch?  For example

                        H---I---J topicB
                       /
              E---F---G  topicA
             /
A---B---C---D  master

And I want:

             H---I---J  topicB
            /
            | E---F---G  topicA
            |/
A---B---C---D  master

Of course,
 
 git-checkout topicB
 git-rebase master

Doesn't work, because the common ancestor is D, which is master, and there is 
nothing to do.

Of course I can cherry-pick, but is there something like

 git-rebase --limit topicA master

Or some git-magic I can work?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
