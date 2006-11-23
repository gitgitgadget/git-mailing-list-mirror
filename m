X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Advice on converting to git from versioning-by-directory
Date: Thu, 23 Nov 2006 11:02:16 +0000
Message-ID: <200611231102.20015.andyparkins@gmail.com>
References: <200611230916.46415.andyparkins@gmail.com> <20061123100757.GB32620@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 11:02:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tTEKGpr3HXhmgWUffxyfP3oPa4hc3NS2e6BvfAzmZbiihpVK6DkVhsSYxRYOTMK3TES0A6HIqcsG6RVvUKcJe9ViF9i3ujiZ87Y+rtKH3c3LbcCR3LS+ZuvFOGXrqQsSp9s5+y/5MAyC48OJfmNMNDXHcDwhbfTIRpanhusoYdA=
User-Agent: KMail/1.9.5
In-Reply-To: <20061123100757.GB32620@coredump.intra.peff.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32136>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnCLd-00071A-2N for gcvg-git@gmane.org; Thu, 23 Nov
 2006 12:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933590AbWKWLCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 06:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933595AbWKWLCZ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 06:02:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:26386 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933590AbWKWLCY
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 06:02:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so406979uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 03:02:23 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr4889712ugm.1164279743610; Thu, 23
 Nov 2006 03:02:23 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id a1sm12910813ugf.2006.11.23.03.02.23; Thu, 23 Nov 2006 03:02:23 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 23 10:07, Jeff King wrote:

> If I understand you correctly, you want to take four branches, each with
> data in version1/, version2/, etc, and make it look like they all had
> data in the project root throughout history. Is that right?

Yes.  In essence I want to move the spatial dimension (directories) into git's 
time dimension (branches).

> If so, cogito's cg-admin-rewritehist can probably do what you want (I
> also posted a script a while back to do this exact thing, and I can dig
> it up if you want).

I will have a look at cg-admin-rewritehist.  After Andy pointed out that they 
were just like traditional svn branches, I'm having good luck using multiple 
runs of git-svn to track each directory as if it were a separate branch.

Thank you for the offer of a script, but don't go to any trouble to find it 
just yet.  I think I have it licked now.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
