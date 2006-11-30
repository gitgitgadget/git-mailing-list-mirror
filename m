X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 16:20:11 +0100
Message-ID: <20061130152011.GM12463MdfPADPa@greensroom.kotnet.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <200611301255.41733.andyparkins@gmail.com> <456EE3F1.5070101@b-i-t.de>
 <200611301449.55171.andyparkins@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 15:20:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200611301449.55171.andyparkins@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32752>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpnhz-0000a6-Rj for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030375AbWK3PUP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWK3PUP
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:20:15 -0500
Received: from psmtp09.wxs.nl ([195.121.247.23]:9120 "EHLO psmtp09.wxs.nl")
 by vger.kernel.org with ESMTP id S1030375AbWK3PUN (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:20:13 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by psmtp09.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0J9J000KVULNQ4@psmtp09.wxs.nl> for
 git@vger.kernel.org; Thu, 30 Nov 2006 16:20:12 +0100 (MET)
Received: (qmail 17980 invoked by uid 500); Thu, 30 Nov 2006 15:20:11 +0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, Nov 30, 2006 at 02:49:53PM +0000, Andy Parkins wrote:
> How are these commits any different from just having one big repository?  If 

You can work on the submodule independently.

> some of the development of the submodule is contained in the supermodule then 
> it's not a submodule anymore.

On the contrary, that's exactly what a submodule is supposed to be.

> Why bother with all the effort to make a separation between submodule and 
> supermodule and then store the submodule commits in the supermodule.  That's 
> not supermodule/submodule git - that's just normal git.

[..]

> myproject (git root)
>  |----- src
>  |----- doc
>  `----- libxcb (git root)
> 
[..]
> 
> Submodules will solve this problem.  In the future I'll be able to check out 
> any commit of myproject and it will automatically checkout the right commit 
> from the libxcb repository.

How are you going to checkout the right commit of the lixcb repo if
you didn't store it in the supermodule ?

