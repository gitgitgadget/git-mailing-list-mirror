X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: v2.6.11 tag in kernel tree
Date: Wed, 29 Nov 2006 23:02:23 -0500
Message-ID: <9e4733910611292002o289dc4d1u7bde2d457fa97d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 04:02:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YVg/P5z7BxontNt8mu9E5wzayJJscJ7nHJu23/O0/FowHYSWdb999VYzJ3e2261+KcPR58Bvjo+Vw0GDI3mun8yV/4MW+K32Y/KLyTSPZ1pvm6phUWr/DvlOnOCind1+U9f3wOLuqYt3afv69RvfcR8RRDYpRZQrq952T4lXWXA=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32701>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpd85-00055P-6s for gcvg-git@gmane.org; Thu, 30 Nov
 2006 05:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758404AbWK3ECZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 23:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758464AbWK3ECZ
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 23:02:25 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:52803 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1758404AbWK3ECY
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 23:02:24 -0500
Received: by py-out-1112.google.com with SMTP id a29so1585965pyi for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 20:02:24 -0800 (PST)
Received: by 10.35.20.14 with SMTP id x14mr5538694pyi.1164859343893; Wed, 29
 Nov 2006 20:02:23 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Wed, 29 Nov 2006 20:02:23 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Using this tree git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

These two tags appear to be pointing to a tree instead of a commit.
v2.6.11
v2.6.11-tree

I'm trying to check out v2.6.11 so that I can figure out the changes a
vendor made to it.

jonsmirl@jonsmirl:/extra/linux$ git checkout -b microcross v2.6.11
Cannot switch branch to a non-commit.

I can checkout the other tags without problem.

What's the secret to checking out 2.6.11?

-- 
Jon Smirl
