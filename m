X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: how to pass ssh options to git?
Date: Thu, 2 Nov 2006 13:27:20 +0200
Message-ID: <20061102112720.GA8469@mellanox.co.il>
References: <20061102110639.G523a966f@leonov.stosberg.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 11:25:05 +0000 (UTC)
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061102110639.G523a966f@leonov.stosberg.net>
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30736>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfagi-0006fY-Bw for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752771AbWKBLYo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbWKBLYo
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:24:44 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:10112 "EHLO
 dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1752771AbWKBLYn (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:24:43 -0500
Received: from mellanox.co.il ([194.90.237.34]) by dev.mellanox.co.il
 (8.13.1/8.13.1) with SMTP id kA2BORoc017295; Thu, 2 Nov 2006 13:24:28 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  2 Nov 2006
 13:27:20 +0200
To: Dennis Stosberg <dennis@stosberg.net>
Sender: git-owner@vger.kernel.org

Quoting r. Dennis Stosberg <dennis@stosberg.net>:
> Subject: Re: how to pass ssh options to git?
> 
> Michael S. Tsirkin wrote:
> 
> > I know, problem is I want to use different options at different times.
> > I could use -F configfile ssh option, but how to pass *that* to git?
>  
> You can set the path of the ssh executable to use with the GIT_SSH
> environment variable.  Create a shell script like
> 
> #!/bin/sh
> exec ssh --your-options-- $*
> 
> and make GIT_SSH point to it.

Thanks, I'll try that.
BTW, just grep for GIT_SSH gets me some more:
GIT_SSH_UPLOAD, GIT_SSH_PUSH, GIT_SSH_PULL, GIT_SSH_FETCH.
None of which appear to be documented.





-- 
