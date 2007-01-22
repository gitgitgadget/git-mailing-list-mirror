From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Insert ACTIVESTATE_STRING in Git.pm
Date: Mon, 22 Jan 2007 17:07:26 +0100
Message-ID: <81b0412b0701220807x284bcbfeo7e67599424451587@mail.gmail.com>
References: <81b0412b0701220632t50ad42c4ucb0ebae140a9706a@mail.gmail.com>
	 <20070122154429.GG18276@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 22 17:07:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H91hk-0000WP-D8
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 17:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbXAVQH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 11:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbXAVQH3
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 11:07:29 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:36870 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbXAVQH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 11:07:28 -0500
Received: by an-out-0708.google.com with SMTP id b33so404966ana
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 08:07:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ft3I+h3ZaV+eUb9tO86Gs+i8Im8HVgH461RiCP8956O2pSu/Yz/ccLJjvAbafKJruhU85pwSPjUYpByf+xyOl8sl9X+Gow2Q4Esl4nSLFcWPSXHKqEpzNKZxPnhcFLLnd4xyjHkqCw0FkSI9goVDmhJYlD2+3cN/0QL0RopkTKA=
Received: by 10.49.41.18 with SMTP id t18mr6869731nfj.1169482046788;
        Mon, 22 Jan 2007 08:07:26 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 08:07:26 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20070122154429.GG18276@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37421>

On 1/22/07, Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Jan 22, 2007 at 03:32:28PM CET, Alex Riesen wrote:
> > Also add "git" to the pipe parameters, otherwise it does not work at all, as
> > no git commands are usable out of git context.
> >
> > ---
> >
> > This is not enough to make it work on ActiveState. It's just to
> > fix obvious TODOs, which should help someone to get it going.
> > The other problems are:
> > - tie refuses to bind a handle class activestate_pipe to a scalar $fh
> >   (a patch follows)
> > - there are some unexplained warnings about uninitialized values
> > - cygwin-windows pathname conversion (not fixable at all)
> >
> > perl/Git.pm |    7 ++++---
> > 1 files changed, 4 insertions(+), 3 deletions(-)
>
> Cool.
>
> Acked-by: Petr Baudis <pasky@suse.cz>
>
> Perhaps ACPIPE could use some comment in the code but that's just vain
> nitpicking.

Will do, with a sign-off this time.
