X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 13:59:58 +0000
Message-ID: <200612011400.00262.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011216.04555.andyparkins@gmail.com> <20061201123447.GS18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 14:01:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n5zQNevGS4xjcDVVgeRw7mAhowxpn2+dpW8MAGGP3mSwB3+REi3l6oEXqDqwMQqXopNC820RqeM873v+hiVFDRknVfB4eDL5serACZXs80n/885h4CAXIrQAXNo+PiRgZlCdK1mAVo9/4Xzit/VL8eWHC0zSLWfd1Iwh3iJSX3E=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201123447.GS18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32925>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq8wQ-0003lS-E0 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 15:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967383AbWLAOAL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 09:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967359AbWLAOAL
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 09:00:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:59944 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936509AbWLAOAJ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 09:00:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2428898uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 06:00:07 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr7208636ugl.1164981607317; Fri, 01
 Dec 2006 06:00:07 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 59sm25576223ugf.2006.12.01.06.00.04; Fri, 01 Dec 2006 06:00:04 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 12:34, Martin Waitz wrote:

> It is exactly the aim of my implementation to not have any reference to
> something that is not accessible in the supermodule repository.

Okay - I think you've put me right in another reply on this point - the 
submodule commit is in the supermodule; that was the part I hadn't got.

> Yes, you can't separate it my just moving it out of the supermodule,
> but you can always clone the submodule alone.

Ah - now that clarifies things a lot.  The fact that you can't separate it by 
moving it implies lots of things that take away many of my earlier worries.

> have a look at http://git.admingilde.org/tali/git.git/module2.
> If you want to try it out, have a look at t/t7500-submodule.sh on how to
> create submodules.

Thanks.  I will look hard at this :-)  My apologies for bothering you so much 
with all these questions.  I just got a bit interested in it all :-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
