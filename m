X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: git fetch --reference?
Date: Tue, 14 Nov 2006 16:38:26 -0800
Message-ID: <f2b55d220611141638k5f4a0aeas1a43301e4b40bf59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 00:38:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D5y8LvU0oqWzWW1DYCh9uVSqJsGfhp3UGDEkxz2P2YPheWtLoCDMQ1tHCID3Upib9/L+uajFGF7PJMonmZ5kv4lwJO7DjNEaxYTN5X/5FHoT4aTmuyQriBAbDSCMI0ncIQjVR/VIXdw3etuD3yWY5w5Lwx1gIVmqlwioveJQd5o=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31396>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk8nP-0000XI-GS for gcvg-git@gmane.org; Wed, 15 Nov
 2006 01:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966545AbWKOAi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 19:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966543AbWKOAi2
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 19:38:28 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:11854 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S966545AbWKOAi1
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 19:38:27 -0500
Received: by wx-out-0506.google.com with SMTP id s7so15434wxc for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 16:38:27 -0800 (PST)
Received: by 10.90.105.19 with SMTP id d19mr1845298agc.1163551106979; Tue, 14
 Nov 2006 16:38:26 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Tue, 14 Nov 2006 16:38:26 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

When setting up a working area for kernel integration for a new
embedded target, I generally do a "git clone --reference" so that the
new area has its own repository (and its own branch structure) but
most of the blobs come from a local reference copy.  But now that I'm
integrating bits from several non-trivially divergent trees (mtd-2.6,
netdev-2.6, linux-2.6.16.y, etc.), it would be nice to avoid
re-downloading blobs for these additional remote branches, which are
also available in the local reference copy.  Is it feasible to
implement "git fetch --reference" for this purpose?  Or is there a
better way to manage this sort of integration effort?

Cheers,
