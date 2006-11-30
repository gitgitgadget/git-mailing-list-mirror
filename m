X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Francis Moreau" <francis.moro@gmail.com>
Subject: How to prepend data when formatting patches ?
Date: Thu, 30 Nov 2006 15:16:22 +0100
Message-ID: <38b2ab8a0611300616j54a9f8ase9b4f1c305b7c22b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 14:16:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EL92E2gAEhcfCNdmAgmjA1kWQfDenzhR04w6f3cP5zPFk6VOymk8lrI4JxbQ5yZrjmifIwJglAgjVjue/GaDmollbH/GoPGY64bZNsmzAKCyptnbpfxFFgDLPE/jm1Uq6NgPebts39nFwnCgMv5D7SuinLwViGyLrndoMr7c0Qw=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32748>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpmiB-00005x-MO for gcvg-git@gmane.org; Thu, 30 Nov
 2006 15:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936424AbWK3OQY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 09:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936425AbWK3OQY
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 09:16:24 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:13408 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S936424AbWK3OQY
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 09:16:24 -0500
Received: by wr-out-0506.google.com with SMTP id i7so990872wra for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 06:16:23 -0800 (PST)
Received: by 10.90.120.13 with SMTP id s13mr3594969agc.1164896183019; Thu, 30
 Nov 2006 06:16:23 -0800 (PST)
Received: by 10.90.55.9 with HTTP; Thu, 30 Nov 2006 06:16:22 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi

I'd like to add to all patchs created by "git-format-patch" command
the following line:

        From: xxx.yyy <foo@crazy.com>

I took a look to the command options and git's hooks but I don't find
a solution to this problem.

Is there any tricks to do this ?

thanks
-- 
