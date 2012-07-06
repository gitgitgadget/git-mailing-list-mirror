From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Fri, 06 Jul 2012 12:39:02 +0200
Message-ID: <7497704.pUs9jgNDKQ@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <20120702110741.GA3527@burratino> <20120706003023.GA15387@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 12:43:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn600-00015t-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 12:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933200Ab2GFKmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 06:42:46 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50424 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964828Ab2GFKmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 06:42:43 -0400
Received: by bkwj10 with SMTP id j10so4213761bkw.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=gjhxHcxeecm82ezaUWeIlrDPx0DSP6dIAAiEc5JqN4A=;
        b=EaWnyxejCSFwj8T721MzQUtGA29H+2+HKpry2EHpOUBJCTVfQyfjB5FAXqrnVc/F2v
         Zo1D8A+GM82P9HldBhr+Q4qKmsYr076iG2iIoa5+aOjJBsgHCq3byTvVCdFd7zynJLKa
         fcjjsHFyVH6ovqKRE5gtvWn44vuw0RSW0KxzIX5JLBroVEe//vgT9zP5jul/7z+zHSHb
         5ZcJVbMQtyJLno4iG62fPzKG5IbVrt+nqO2POILxdec99kdGGGK3ZhwS3p3Em/T+7piB
         UnyVZjOjJo4BR33gOVUl2+FwbYd07IAvrUgzoLhJ2u3vl0OPNIO166W1gsTXMMFxUiDQ
         RTpA==
Received: by 10.205.134.133 with SMTP id ic5mr6693532bkc.15.1341571362077;
        Fri, 06 Jul 2012 03:42:42 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id 25sm1771375bkx.9.2012.07.06.03.42.39
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 03:42:40 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120706003023.GA15387@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201108>

Hi Jonathan!

Thanks for your review! I will come up with a new version later after finishing 
some other feature.. 
Now I've done all exams (last 2 yesterday :) ) and submissions and commit 
myself to git and gsoc much more.

On Thursday 05 July 2012 19:30:24 Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> > Florian Achleitner wrote:
> >> Experimental implementation.
> > 
> > Ok, so this adds a new program named "remote-svn".  How do I build it?
> > What does it do?  Will it make my life better?
> 
> [...]

I need to emphasize that it is in no way something complete and truely useful.
It's a starting point for the rest of my project. It will change.
Your review will help to make it a good basis!

> 
> I forgot to say: thanks for working on this!  I hope my comments are
> not demoralizing.  They are meant in the opposite vein --- if I
> expected you to be a one-time contributor then I would just take what
> is useful from the patch and let it be, but I would be happy to see
> more changes from you in the future so I gave some hints to explain
> how.
> 
> The next step is to work with the list to figure out what a second
> version of the patch should do, and then to send that with something
> like "RFC/PATCH v2" in the subject line to clarify that it supersedes
> this one.

I will come back to that soon..

> 
> If you have any questions about the review or the codebase in general,
> please don't hesitate to ask.  Especially, if you get stuck on
> something and documentation is unhelpful, please do complain. :)
> 
> Hope that helps,
> Jonathan

Florian
