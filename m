X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: How to complete t/README file?
Date: Fri, 3 Nov 2006 19:50:06 +0100
Message-ID: <200611031950.06242.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 18:49:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TP3kYPE/GPEGuR3Hj0FbAkJxdbPEDhRO1jzAl+tXUC1xhzF6rLXdxTaywNeg6qOuKWCBKtAPBXETGggsJLFah8HJw5VaxnAiX4LOCmO5FZ8DOlSfOsM4R4aWugUZ2sXZXtCB0mSEy0eU5cse2KQUGzQqa6pSqaWFNHSR9aP2kLs=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30873>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg46w-00074x-DR for gcvg-git@gmane.org; Fri, 03 Nov
 2006 19:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753456AbWKCStr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 13:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbWKCStr
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 13:49:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:5319 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753456AbWKCStq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 13:49:46 -0500
Received: by ug-out-1314.google.com with SMTP id m3so487611ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 10:49:45 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr3189197ugi.1162579785218; Fri, 03
 Nov 2006 10:49:45 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 59sm1303893ugf.2006.11.03.10.49.44; Fri, 03 Nov
 2006 10:49:44 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

How to complete family numbering in t/README? Curently we have:

-- >8 --
First digit tells the family:

        0 - the absolute basics and global stuff
        1 - the basic commands concerning database
        2 - the basic commands concerning the working tree
        3 - the other basic commands (e.g. ls-files)
        4 - the diff commands
        5 - the pull and exporting commands
        6 - the revision tree commands (even e.g. merge-base)
        7 - the porcelainish commands concerning the working tree
-- >8 --

But there are tests which have 8 or 9 as first digit:

	8 - annotate, blame, pickaxe
	9 - send-email, git-svn

8 seems to be porcelanish "archeology" (analysis, interrogators) 
commands, 9 seems to be interfaces (to email, to svn). Do you have idea 
how to name those families?

P.S. Do I understand correctly that gotweb tests would eblong 
to familiy 9 of tests?
-- 
Jakub Narebski
