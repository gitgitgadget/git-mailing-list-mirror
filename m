From: Stephen Bash <bash@genarts.com>
Subject: Re: Prompt for merge message?
Date: Thu, 6 Oct 2011 16:15:38 -0400 (EDT)
Message-ID: <21983420.46542.1317932138649.JavaMail.root@mail.hq.genarts.com>
References: <201110061851.p96Ipfui016139@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Todd A. Jacobs" <nospam+listmail@codegnome.org>,
	git@vger.kernel.org
To: in-gitvger@baka.org
X-From: git-owner@vger.kernel.org Thu Oct 06 22:15:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBuMC-0001QC-R9
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab1JFUPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 16:15:47 -0400
Received: from hq.genarts.com ([173.9.65.1]:4044 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755456Ab1JFUPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:15:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 5A96015C801A;
	Thu,  6 Oct 2011 16:15:45 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JYWbh1VkGJA; Thu,  6 Oct 2011 16:15:38 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id BD0A315C8001;
	Thu,  6 Oct 2011 16:15:38 -0400 (EDT)
In-Reply-To: <201110061851.p96Ipfui016139@no.baka.org>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183022>

----- Original Message -----
> From: in-gitvger@baka.org
> Sent: Thursday, October 6, 2011 2:51:41 PM
> Subject: Re: Prompt for merge message?
>
> In message <20111006182534.GA13628@vfa-6h>, Jacob Helwig writes:
> 
> On Thu, 06 Oct 2011 10:49:02 -0700, Todd A. Jacobs wrote:
> 
> > I often find myself using "--no-ff -m foo" for merging short-lived
> > branches, because the merge commit usually needs to say something
> > about having finished a feature rather than referring to a branch
> > that
> > will be deleted shortly anyway. However, it's a little annoying to
> > have to always write the commit message on the command-line,
> > especially in cases where a more expository multi-line message would
> > be useful.
> 
> "git merge --no-ff --no-commit branch_foo && git commit" ?
> 
> While not ideal, you can use a multi-line message on the command line.
> I do it all of the time. Popping up an editor like in the separated
> workflow is more user friendly.
> 
> ----------------------------------------------------------------------
> git merge --no-ff -m "My feature is very complex
> 
> It requires multiple lines to explain.
> 
> Or perhaps I am too verbose." branch_foo
> ----------------------------------------------------------------------

And not so helpful if you want to use the --log option to pre-populate the merge message (which I often run into).

Thanks,
Stephen
