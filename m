X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: git-fetch fails with error code 128
Date: Thu, 14 Dec 2006 23:08:43 +0000
Message-ID: <200612142308.45376.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 23:11:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZMCb0Jx2UFHAD2Yxp7gJ2xgAz9q6oA/K5ckt9jZnWCtJJDoPlhCSNNoerajMHLFdpPuJ5WzWgY589Sgv0CySxYwwDrm2rdlIiFhRCPvCvAlsgfqlbmZXSxZC5P0anfsQqAz6QeP2M83ewl1yzR8ETelYCQxdsuUajbQr8hcOsdo=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34431>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guzje-0007rU-2o for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751762AbWLNXL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWLNXL1
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:11:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:43673 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751762AbWLNXL0 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 18:11:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so649990uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 15:11:26 -0800 (PST)
Received: by 10.67.21.11 with SMTP id y11mr102964ugi.1166137885934; Thu, 14
 Dec 2006 15:11:25 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id k30sm3292133ugc.2006.12.14.15.11.25; Thu, 14 Dec
 2006 15:11:25 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

This is with my big "every linux patch" repository that I talked about in 
another thread.  To bring you up to speed:

 1. Made repository
 2. Made a zip of the .git directory
 3. Copied the zip elsewhere
 4. Extracted it into a temporary directory
 5. Went to an out-of-date version of this repository
 6. Used git-fetch to update it.

This gave me the following output:

$ git fetch
remote: Generating pack...
remote: Done counting 189146 objects.
remote: Result has 186566 objects.
remote: Deltifying 186566 objects.
remote:  100% (186566/186566) done
Unpacking 186566 objects
fatal: failed to apply delta
fatal: unpack-objects died with error code 128
Fetch failure: /home/andyp/projects/temp/.git

What does that mean?  I ran fsck --full on the source repository, but it's 
made no difference.



Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
