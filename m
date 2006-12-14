X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 13:40:36 +0000
Message-ID: <200612141340.43925.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 13:41:11 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=A78/bW44uJUjPlie2WPjh8TOqOfV0gvXaPGpKtZmWefVegPES0PhbciGJfDSzne5O+PGFacXY7bVEv46P7+pfw1pvJB3hTju95sXlTrwMwrqJXeR1nWJKLczNOe4/vC475AAl8P2BFHndTqXFUgsqibbi3VvozoBjgX3wjNVcSM=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34333>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuqpZ-0005fE-4U for gcvg-git@gmane.org; Thu, 14 Dec
 2006 14:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932723AbWLNNkv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 08:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWLNNkv
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 08:40:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:26975 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932723AbWLNNku (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 08:40:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so501562uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 05:40:48 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr1416797ugl.1166103648248; Thu, 14
 Dec 2006 05:40:48 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 39sm2051290ugb.2006.12.14.05.40.47; Thu, 14 Dec 2006 05:40:47 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I've got a big repository.  I've got two computers.  One has the repository 
up-to-date (164M after repack); one is behind (30M ish).

I used git-fetch to try and update; and the sync took HOURS.  I zipped 
the .git directory and transferred that and it took about 15 minutes to 
transfer.

Am I doing something wrong?  The git-fetch was done with a git+ssh:// URL.  
The zip transfer with scp (so ssh shouldn't be a factor).



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
