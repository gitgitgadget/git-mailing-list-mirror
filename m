From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sun, 19 Jun 2005 10:18:45 +1000
Message-ID: <2cfc403205061817181e4d6d5e@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 02:13:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjnR3-0000M5-HE
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 02:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVFSASr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 20:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVFSASr
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 20:18:47 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:18091 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262209AbVFSASq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2005 20:18:46 -0400
Received: by rproxy.gmail.com with SMTP id i8so249662rne
        for <git@vger.kernel.org>; Sat, 18 Jun 2005 17:18:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uy4LCqcLqRTFd7tBOUQbHPSenNSRD+YXYpIiP0EXPo98Ld9pTEPRC8/LBKQuSxTmQR8PymqpYNmeLFQTROPvPqNNLKcl7Xiu0nyPIeRbC4VSicZR2QxD3H1VbUHNInYzwQJ3FoTstH7LEPNgg5gPHsaeIYeRgGL6hCeXrTkDeDU=
Received: by 10.38.88.14 with SMTP id l14mr1652867rnb;
        Sat, 18 Jun 2005 17:18:45 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 18 Jun 2005 17:18:45 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/18/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Ok, I just added a feature to "git-rev-list" that I hereby nominate to be
> the coolest feature ever, namely the "--bisect" flag, which basically
> tries to split the list of revisions in two, and prints out just the "most
> middle" commit.
> 

Perhaps in answering this question, you can help me understand the
intended behaviour of your bisection algorithm a little better. The
question is this: for your purposes, given a rev-list output, why not
simply use the literal middle element of the outputed list?

jon.
