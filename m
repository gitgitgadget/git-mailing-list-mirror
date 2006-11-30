X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 16:08:27 +0000
Message-ID: <200611301608.28560.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301530.51171.andyparkins@gmail.com> <456EFDDE.9010705@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 16:08:48 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nwDpaE/wiRKKHnjRc0R3uAG4aD5VrI0Uf9LQZH+g2iNUNXLeMN2LUuEOxeT612pSJa4cF3C4aQq61NvOZPMDVAdMjWRBIQNUvSVRAlETU3emeoK3OZyxqQoV047EPQycEC9IG3ZsgwHju8MD75f/6sd9qvHfXjxM81r9SPXuBMk=
User-Agent: KMail/1.9.5
In-Reply-To: <456EFDDE.9010705@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32765>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoSl-0004xk-5D for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030648AbWK3QIf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbWK3QIf
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:08:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:55201 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030648AbWK3QIf
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:08:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2157113uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 08:08:33 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr5650207ugj.1164902912525; Thu, 30
 Nov 2006 08:08:32 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e1sm23926258ugf.2006.11.30.08.08.31; Thu, 30 Nov 2006 08:08:31 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 15:50, Andreas Ericsson wrote:

> > Obviously, this is grossly simplified.  It also requires that HEAD be
> > allowed to be an arbitrary commit rather than a branch, but that's
> > already been generally agreed upon as a good thing.
>
> It has? We're not talking supermodule specific things anymore, are we?

Not entirely, although I think it's going to be handy for submodules.  It was 
in a thread about remotes branches.  By allowing checkout of any commit 
rather than only those that have a ref/heads/ entry, you effectively have a 
read-only checkout.  You obviously couldn't commit to a repository like this, 
because HEAD wouldn't point at anything that is changeable.  It would be very 
easy to just git-branch from there and start work though.

I think it's going to be necessary for the submodule work, because without it 
the supermodule will have to create it's own temporary branches in the 
submodule in order to checkout an arbitrary commit.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
