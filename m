From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Pull is Mostly Evil
Date: Fri, 2 May 2014 23:12:52 +0100
Organization: OPDS
Message-ID: <B2C7522180DD4894BB18B91CAFD35FF9@PhilipOakley>
References: <5363BB9F.40102@xiplink.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Marc Branchaud" <marcnarc@xiplink.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 03 00:12:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLhR-0000mz-3s
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbaEBWMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:12:53 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:26564 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813AbaEBWMw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 18:12:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlJVAIYXZFMCYJ6l/2dsb2JhbABZgwZfA4hpvB8FAQIBDIECF3SCIAUBAQQBCAEBLh4BARURBgIDBQIBAxUBCyUUAQQaBgcXBgESCAIBAgMBiCgMq3iebI8HgnaBFQSJTIY4hTaWZYM1PA
X-IPAS-Result: AlJVAIYXZFMCYJ6l/2dsb2JhbABZgwZfA4hpvB8FAQIBDIECF3SCIAUBAQQBCAEBLh4BARURBgIDBQIBAxUBCyUUAQQaBgcXBgESCAIBAgMBiCgMq3iebI8HgnaBFQSJTIY4hTaWZYM1PA
X-IronPort-AV: E=Sophos;i="4.97,974,1389744000"; 
   d="scan'208";a="459481362"
Received: from host-2-96-158-165.as13285.net (HELO PhilipOakley) ([2.96.158.165])
  by out1.ip03ir2.opaltelecom.net with SMTP; 02 May 2014 23:12:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247993>

From: "Marc Branchaud" <marcnarc@xiplink.com>
Sent: Friday, May 02, 2014 4:37 PM
> (Apologies for not CCing all the folks who've participated in the 
> "Pull is
> Evil" thread -- I couldn't find a good branch of that thread for this 
> message.)
>
> OK, so maybe "git pull" is just Mostly Evil.  People seem to have 
> found many
> different ways to make it work for them.
>
> But in reality "git pull" has become a chimera that confuses a large 
> number
> of new users, and that experienced users either avoid entirely or 
> customize
> to give them a convenient shorthand for working in their particular
> environment.  As a tool for new git users, it just doesn't seem to be
> achieving its goals.
>
> I think the git project as a whole would benefit if it started to 
> treat "git
> pull" as an advanced command, in the sense that it needs to be 
> configured by
> an experienced user in order to make it correctly follow a project's
> workflow.  Once it's configured properly, "git pull" is a powerful 
> tool that
> gives users an easy way to do complex things.  In that sense, it may 
> be
> appropriate for a project to tailor "git pull" as it likes, then teach 
> its
> own users to use the command.
>
> However, when it comes to teaching people how to use git qua git, "git 
> pull"
> should be the last thing they learn about, because it's only after you
> understand various basic git concepts that you can configure "git 
> pull" to do
> the right thing.
>
> To that end, I suggest that pull's default behaviour should be to do
> *nothing*.  It should just print out a message to the effect that it 
> hasn't
> been configured, and that the user should run "git help pull" for 
> guidance.
>
I tend to agree.
The hard part is making sure folk have enough prior learning to make a 
choice that their will fit their real needs.

> It'll take quite a bit of time, but I think that if we change our 
> attitude
> towards "git pull" and take this unconfigured-by-default approach, 
> then in a
> few years the entire git ecosystem will be in a better place.
>
> M.
> --
Philip
