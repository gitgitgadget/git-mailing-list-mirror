From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Fri, 19 Aug 2011 14:15:42 -0400 (EDT)
Message-ID: <26995656.83614.1313777742247.JavaMail.root@mail.hq.genarts.com>
References: <CAOTq_ptdf3NvoeQXzdABdnU50w1ZwL=wnF6rPJvZpnqcU64-+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuTbp-0007WT-UA
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab1HSSPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 14:15:53 -0400
Received: from hq.genarts.com ([173.9.65.1]:33042 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752187Ab1HSSPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 14:15:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 89089EA2353;
	Fri, 19 Aug 2011 14:15:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wf54MRJX50dE; Fri, 19 Aug 2011 14:15:42 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4C4C2EA2929;
	Fri, 19 Aug 2011 14:15:42 -0400 (EDT)
In-Reply-To: <CAOTq_ptdf3NvoeQXzdABdnU50w1ZwL=wnF6rPJvZpnqcU64-+g@mail.gmail.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179716>

----- Original Message -----
> From: "Conrad Irwin" <conrad.irwin@gmail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
> Sent: Friday, August 19, 2011 2:07:53 PM
> Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
>
> > Should case insensitive matches be added to the tests? This morning
> > I discovered coworkers working on branches foo and Foo thinking they
> > were on the same branch... Rather trivial to clean up, but certainly
> > caused some confusion in the office.
> 
> I can certainly see the use-case, but there's definitely a step-change
> between "this branch has the same name as something else", and "this
> branch is going to confuse you".

Good point.  I'd be curious if any of the msys/cygwin guys can comment on if/when capitalization in branch names becomes technically ambiguous?  I would think unpacked refs on a Windows machine could get complicated...  And I guess factory Macs are all formated case-insensitive as well, so the same problem might apply there.

> When trying to change the code to be
> a warning as Junio suggested, I did think about expanding the
> definition of ambiguous to include things that are merely confusing;
> however it's not clear where to stop (i.e. should we warn about
> <remotename>/<anything>, foo and f00, a branch called " " [the
> non-breaking space]). There's probably an argument for more general
> warning, but I don't think I understand when it should be shown
> well-enough.

Thanks for putting the thought into it, I agree it is a slippery slope.

Stephen
