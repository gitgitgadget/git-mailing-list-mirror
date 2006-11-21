X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: git-show --stat on first commit
Date: Tue, 21 Nov 2006 13:41:47 +0000
Message-ID: <200611211341.48862.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 13:42:11 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aLJ8Q4sWGNh+t9rdEEEigNdzdtG45Xk2MIVTYSHUS4VGpryM71zUDK9N44TuGD4akaNH5pVyqOhwPHZJU2zJj5elHylhFGue1Y5TsY4HvmUh6yxfQPm88uW1fmvsZnGPh+05MqShAOx5v29M6dloikSkdOU0znLxqkxj4y7mVjM=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31988>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmVsr-0005Rt-Uq for gcvg-git@gmane.org; Tue, 21 Nov
 2006 14:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965811AbWKUNly (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 08:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965843AbWKUNly
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 08:41:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:18221 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965811AbWKUNlx
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 08:41:53 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1511530ugc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 05:41:52 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr1065578ugj.1164116511988; Tue, 21
 Nov 2006 05:41:51 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e1sm10094282ugf.2006.11.21.05.41.51; Tue, 21 Nov 2006 05:41:51 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I'm sure this one will be known about already.  git-show --stat on the the 
first commit doesn't show anything.  I assume it's because git-diff-tree has 
nothing to diff against (although shouldn't that be an everything-new diff?).

Given the above; does anyone have a suggestion for what I could use as a 
replacement?  Even just a list of the new files would be useful.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
