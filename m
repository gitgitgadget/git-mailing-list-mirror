From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Fri, 16 Nov 2007 00:49:29 +0800
Message-ID: <46dff0320711150849l5b7dc6a3y6b625e45a3117d4f@mail.gmail.com>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
	 <4738784F.7010106@viscovery.net>
	 <46dff0320711120835h31166370k64e9c92e9cf3432c@mail.gmail.com>
	 <47388344.6010008@viscovery.net>
	 <8c5c35580711120947s246f192coa3796ac6541a28d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IshuY-0007SZ-H9
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759584AbXKOQtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 11:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759295AbXKOQtc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:49:32 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:63586 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758336AbXKOQta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 11:49:30 -0500
Received: by an-out-0708.google.com with SMTP id b36so116974ana
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Th4TEfJWlG2fmEupQ1v9BXs6l/TBpq29rOp50WjgKRo=;
        b=Uxy+lSLJc5tDxRwh9xB3LSOK26f5LM9sna9PX0hCF+moyp8rlf2mVTKbXxyBEIH7FGHOMteoygQhDK/2XMWOhq10+6MFHw28C9d00+vrbgh1xrmdM/VwSjGIlz3JOWsBWskik0xtc/nYnN7CFwCW6nBZnyO9/23wMpjhW7bEBLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EmKKaDJlYzER74vxmiHRttxZ8ieU8R2zV1O3DePioqJmgfwYPn+x8KEbt4pT4y8ioCYK/LnUhh2fUQ/emsCJQuOaz6fEj1/I2OpfNOG2wK4sofF4uSL21LDaI+O3Rdw7QUKX4M07IsT0QhZ0bP68+sbrd1lT+QvjRxYJBHht4JY=
Received: by 10.100.211.8 with SMTP id j8mr1068535ang.1195145369999;
        Thu, 15 Nov 2007 08:49:29 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Thu, 15 Nov 2007 08:49:29 -0800 (PST)
In-Reply-To: <8c5c35580711120947s246f192coa3796ac6541a28d7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65138>

On Nov 13, 2007 1:47 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Nov 12, 2007 5:45 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > Ping Yin schrieb:
> > > On Nov 12, 2007 11:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > >
> > >> But at this time git-commit is about to be made a builtin, and since your
> > >> implementation contains a lot of non-portable constructs ($'', >&) and a new
> > >> dependency on awk (and, hence, has little chances of being accepted), I
> > >> suggest that you stay tuned, and implement this in the forth-coming
> > >> builtin-commit.c.
> > > Implement this in shell scripts is just a piece of cake, but not so
> > > easy in builtin-commit.c.
> >
> > I'm with you. But git-commit.sh is a dead horse, no matter how hard you beat it.
> >
> > BTW, maybe you can keep the log generation in a helper script,
> > git-status--submodulesummary, and invoke that from builtin-commit.c. This
> > way you get both: integration and ease of implementation.
>
> Sorry for repeating myself, but IMVHO this belong in git-submodule.sh:
> It can be useful as a standalone command, we get all submodule-related
> commands isolated in a single place, and builtin-commit.c can of
> course exec git-submodule to get the summary.
>
OK. I'll reconsider it and reimplement it when i have time.



-- 
Ping Yin
