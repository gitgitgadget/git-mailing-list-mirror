X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: rebase fails but not sure why
Date: Thu, 23 Nov 2006 00:30:01 +0000
Message-ID: <200611230030.01236.alan@chandlerfamily.org.uk>
References: <200611230026.58936.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 00:30:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200611230026.58936.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32113>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn2Tm-0007jd-97 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 01:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932164AbWKWAaG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 19:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757229AbWKWAaG
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 19:30:06 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:36589 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1757228AbWKWAaD (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22
 Nov 2006 19:30:03 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gn2Ta-00041V-RW for git@vger.kernel.org; Thu, 23 Nov 2006 00:30:02 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 23 November 2006 00:26, Alan Chandler wrote:
> I have now got to a point where the following error occurs during a rebase.
>
> fatal: empty ident  <alan@chandlerfamily.org.uk> not allowed
> Commit failed, please do not call "git commit"
> directly, but instead do one of the following:

I had run 

git rebase --merge --onto b1 b2 b3

I aborted it and ran 

git rebase --onto b1 b2 b3

and it works!

-- 
Alan Chandler
