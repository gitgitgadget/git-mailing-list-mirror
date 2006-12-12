X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: git-svn breakage
Date: Tue, 12 Dec 2006 13:23:03 +0800
Message-ID: <4b3406f0612112123h13e346d2r5a3b196595bc017a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 05:23:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iCOoaQQNSGbJnC13aLNRy+IiT5ntydaVGm57tw3eCeM1ko9D3fnk2GhNE3N6zjGHraqwCW20AzZh+i5RrcGs1y5RC9bKB892/uvQhAg8fCqXZHjDGSa4S0W5JuQWAl2icw3PoFgb6d93wrhV6i0kdcB7+s6SRZ7qO5bbzQS8zYg=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34062>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu06p-0003EZ-W5 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 06:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751156AbWLLFXI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 00:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWLLFXH
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 00:23:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:35104 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751156AbWLLFXF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 00:23:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1560927uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 21:23:03 -0800 (PST)
Received: by 10.78.149.15 with SMTP id w15mr2313102hud.1165900983560; Mon, 11
 Dec 2006 21:23:03 -0800 (PST)
Received: by 10.78.165.2 with HTTP; Mon, 11 Dec 2006 21:23:03 -0800 (PST)
To: n0dalus <n0dalus+redhat@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

I am trying to use git-svn synchronize git with svn.

When git-fetch failed midway, and resumed later.The git-svn log output
fine, but git-log output only before resumed.

How can I fix it ?

Any help greatly appreciated,

