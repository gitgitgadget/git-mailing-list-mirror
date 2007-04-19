From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 14:48:42 +0200
Message-ID: <81b0412b0704190548x5a26395elc0f42abd17c48100@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	 <200704172239.20124.andyparkins@gmail.com>
	 <1176983993.30690.13.camel@cauchy.softax.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Marcin Kasperski" <Marcin.Kasperski@softax.com.pl>
To: "Marcin Kasperski" <Marcin.Kasperski@softax.pl>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:48:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeW47-00071c-Nx
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031229AbXDSMso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031239AbXDSMso
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:48:44 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:52701 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031229AbXDSMsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:48:43 -0400
Received: by an-out-0708.google.com with SMTP id b33so472382ana
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 05:48:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DJEbJ3g24FONgrTY/k5UWbr9ifq5QOrj2xKaG6fucG+pubXcRP2AuL22ZjkoeqKX/qjxICauXEXJfY+cnEwpupxNDFmzyegxJxRJpumSuSl+f4/M7XAiR3YD03zZ7ExiNuWa4sd+POR5F6Om7ig8BUGCT8k0U7LYYM5qslmgpFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oY40GsdttjCU3B+vtto+FrWLxU4HOIWghYluC1mSdLWJSl5MuGhwwQzqF8a8QBttSIpLeut4zWhoLzj9c4x6O349+mxJl0m4fGRI9Cnn5uLv9WCuUeglWyJy2JcMdpYtNElDydoauQ8rk3wxaAwwyEKEhu0R2hGVp6dd67J/e+I=
Received: by 10.100.201.11 with SMTP id y11mr850240anf.1176986922197;
        Thu, 19 Apr 2007 05:48:42 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 19 Apr 2007 05:48:42 -0700 (PDT)
In-Reply-To: <1176983993.30690.13.camel@cauchy.softax.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45015>

On 4/19/07, Marcin Kasperski <Marcin.Kasperski@softax.pl> wrote:
>
> Let me retype it: I am not complaining. GIT developers are not forced to
> think about win users, or about corporate needs. But if they are, it is
> reasonable to know the problems.
>

Windows (and, by extension, most corporate) users are used to both:
complain and suffer. What they cannot imagine is _doing_ something.
It just does not fit in their heads.

A user feels the need to restrict access to some trees in a git repository?
He'll start looking, asking, and maybe even raving about the missing
feature on some official channel. What never occurs to him is just
implementing it. And he'll be outraged if you suggest it (and, yes, it was
tried. The person felt insulted and is sulking till this day)

Besides, it looks like we need them: the stupid, lazy and numerous
windows users. I sometimes ask myself what for did I try to explain
merging and distributed workflow to my peers? The most reasonable
answer so far: so they don't bother me with their stupid work flow.
Don't like it though: people don't like to be called stupid (or anything
they do), and I happen to like most of them anyway.
And I start coding workarounds (the recent is git-remote, why the
hell must it be coded in perl?)
