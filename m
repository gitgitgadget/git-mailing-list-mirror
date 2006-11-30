X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 15:30:49 +0000
Message-ID: <200611301530.51171.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301449.55171.andyparkins@gmail.com> <20061130152011.GM12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 15:31:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jU5eVTbZlQJXr1Z/sR6ET9hYYYfjVGlef2pnxJoJcXR3aO+Y+AUEhC5oJSCnwHdlatBZJhF7ZiXAIKqcggh40ht1s2Facj0jIwIa9fQSTYsiuE/X0ngExAgmMH01184T42TdDV4sZK439YUOMwRvNw1PFM7+2nnh6hmrFiRJJuA=
User-Agent: KMail/1.9.5
In-Reply-To: <20061130152011.GM12463MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32753>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpnsL-0003Je-Qp for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030511AbWK3Pa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWK3Pa5
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:30:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:56733 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030511AbWK3Pa4
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:30:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2145058uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 07:30:55 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr5541053ugm.1164900655352; Thu, 30
 Nov 2006 07:30:55 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id i39sm19891915ugd.2006.11.30.07.30.54; Thu, 30 Nov 2006 07:30:54
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 15:20, Sven Verdoolaege wrote:

> You can work on the submodule independently.

It's not independent if any part of it is in the supermodule.

> > some of the development of the submodule is contained in the supermodule
> > then it's not a submodule anymore.
>
> On the contrary, that's exactly what a submodule is supposed to be.

I don't think so.  I think it's just made some complicated normal repository.

> How are you going to checkout the right commit of the lixcb repo if
> you didn't store it in the supermodule ?

Well, I know what the commit is /that/ was all that was stored.  So I 
(actually supermodule-git does):

cd $DIRECTORY_ASSOCIATED_WITH_SUBMODULE
git checkout -f $COMMIT_FROM_SUPERMODULE

Obviously, this is grossly simplified.  It also requires that HEAD be allowed 
to be an arbitrary commit rather than a branch, but that's already been 
generally agreed upon as a good thing.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
