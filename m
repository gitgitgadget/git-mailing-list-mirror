X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Restore a single file in the index back to HEAD
Date: Thu, 26 Oct 2006 16:41:09 +0100
Message-ID: <200610261641.11239.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 15:41:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JCyXLQsvTEudbvT8bHmrPMT74YW7JBPCza0ukhia2UbJZ/N8U2BOMxtmzJEtuzm6Ggm1y+6NfD1rIY6C43PM+2JOWDFXKaXSCzQU4ZPgNZz66RcxajXawjhjkatEkdWKvu/2IiItMfV3aMWu+14htQzshc+WZZcIuCJX0RRsjZg=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30229>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd7M8-0000l7-QM for gcvg-git@gmane.org; Thu, 26 Oct
 2006 17:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423580AbWJZPlR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 11:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423582AbWJZPlR
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 11:41:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:14168 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423580AbWJZPlQ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 11:41:16 -0400
Received: by ug-out-1314.google.com with SMTP id 32so402678ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 08:41:15 -0700 (PDT)
Received: by 10.67.27.3 with SMTP id e3mr3058981ugj; Thu, 26 Oct 2006
 08:41:14 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m1sm1892582uge.2006.10.26.08.41.14; Thu, 26 Oct 2006 08:41:14 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I have something like this:

# On branch refs/heads/newmaster
# Updated but not checked in:
#   (will commit)
#
#   modified:   oops/file1
#   modified:   good/file2
#   modified:   good/file3
#   modified:   good/file4

i.e. the index has been updated to hold oops/file1

If I then didn't want to commit oops/file1, how do I restore the HEAD 
oops/file1 back to the index without doing a full reset?

What I'm wishing for is a per file reset...

 git-reset --mixed HEAD oops/file1

(I realise that the above is crazy, but I hope it's explaining what I want).

When I do a git checkout -f oops/file1; I get

"git checkout: updating paths is incompatible with switching branches/forcing
Did you intend to checkout 'oops/file1' which can not be resolved as commit?"



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
