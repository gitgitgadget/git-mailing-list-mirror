X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git-diff opens too many files?
Date: Mon, 20 Nov 2006 17:12:13 +0700
Message-ID: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 10:12:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l9C1UK9DnD2l+QZRjzdvImd3ZCDxN9igkHk1dRQV9q7JMH7SHoZQIxCyKRfDqimGdbfG5xf1VOBgabPpr7Zn4VaU2C/ReLhS8jXI96Y/+2G1gqsyvpEF1xJKOcGrdreI0Rby73A2T+HC5S96KfczA0T69zRnGhl5WsJ3zy5LQc8=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31895>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm68P-0005E7-TB for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965589AbWKTKMP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965591AbWKTKMP
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:12:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:30757 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S965589AbWKTKMO
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:12:14 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2293402nfa for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 02:12:13 -0800 (PST)
Received: by 10.78.23.16 with SMTP id 16mr4990340huw.1164017533194; Mon, 20
 Nov 2006 02:12:13 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Mon, 20 Nov 2006 02:12:13 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I got this error in a quite big (in files) repository:
error: open("vnexpress.net/Suc-khoe/2001/04/3B9AF976"): Too many open
files in system
fatal: cannot hash vnexpress.net/Suc-khoe/2001/04/3B9AF976

The repository contained about 67.000 files and probably all were modified.
git version 1.4.4.rc1.g2bba
-- 
