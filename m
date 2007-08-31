From: "Robert Newson" <robert.newson@gmail.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 17:25:23 +0100
Message-ID: <46aeb24f0708310925n707244d0nf8f58efda0145ac@mail.gmail.com>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	 <7vveav21uv.fsf@gitster.siamese.dyndns.org>
	 <20070831152153.GA30745@muzzle>
	 <7vfy1z1y9u.fsf@gitster.siamese.dyndns.org>
	 <46aeb24f0708310918u29fa5d17r9878658e68702fca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:25:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9JK-0002kp-Fi
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbXHaQZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932834AbXHaQZZ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:25:25 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:60680 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864AbXHaQZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:25:24 -0400
Received: by nz-out-0506.google.com with SMTP id s18so650307nze
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 09:25:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dZvSQy4PrVAOvLT7Xee0ECwNsE7pf9IiTMDf3xqrqOV1CIUanikupyWb/z78WP0/T4XZEq7C8Lm/JdYxX9UH8HJy2Z49Ddw0whznPEboFr9FiZE/mEVECToykyBCusDF4b3UquU/CqjCsf/KygziPkHuS04x3c4lrkJ/kL1b+MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qkAOmnCFow91IQ+BA5NJ8hNoBpi6MKSPnU1ff8MCj8JfnRHpFtXtJhYwq9r2N9RfXjsmjV/MkAPpYGjO5xAWvfZFpFonMD3Gao3hysHjHr4+6b0u7ZfB9PldPJWnOq2OSW4Q251bphgFsQoniSKyskvwqH6qQNjz8NCeAgsGXII=
Received: by 10.115.106.7 with SMTP id i7mr1003941wam.1188577523489;
        Fri, 31 Aug 2007 09:25:23 -0700 (PDT)
Received: by 10.115.19.3 with HTTP; Fri, 31 Aug 2007 09:25:23 -0700 (PDT)
In-Reply-To: <46aeb24f0708310918u29fa5d17r9878658e68702fca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57183>

Confirmed, if I switch 'true' to 'auto', the problem goes away. It's a
side-effect but an ugly one.

On 8/31/07, Robert Newson <robert.newson@gmail.com> wrote:
> I have these settings in ~/.gitconfig;
>
> [color]
>         branch = true
>         diff = true
>         pager = true
>         status = true
>
> not a problem in 1.5.2.4.
>
> On 8/31/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> >
> > > This could be a sign of a bigger problem.
> > >
> > > Does git-log read .git/config and that could potentially change
> > > its default output format?  A quick scan of the docs say "no".
> >
> > "diff.color = always" could break it I would imagine...
> >
>
