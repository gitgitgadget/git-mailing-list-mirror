From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Fri, 15 Jan 2010 16:34:19 +0100
Message-ID: <20100115153419.GA12982@vidovic>
References: <4B4F6000.4070005@sofistes.net> <20100114195234.GA26684@coredump.intra.peff.net> <7vljg0bfox.fsf@alter.siamese.dyndns.org> <20100114203928.GA26883@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 16:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVoC8-0001ap-Op
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 16:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab0AOPef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 10:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702Ab0AOPef
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 10:34:35 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:65137 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab0AOPee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 10:34:34 -0500
Received: by ewy1 with SMTP id 1so143899ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8byfCshqhhyJxsCelb4X2CdGY0u6e/MxVixGH5EPADU=;
        b=p+Kvvz+LrVIU9f4kioeffqq585Aa35XAA80UkV4d8M6rEPn+LKVBvn7nael7G0RUr5
         ISKQNhrwcxxvvXOkq1FM2CoPG6MmEitRhuTpmW7etbmYKwuQyKjKkGbJN4ClbgeG1NRK
         /68Iolgc/sZ1cjdBSTvt24AVcQ2dV1BvP7GCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bVutvaZwIhsfZsEgdOkH7l036OTKdt0yhhaA6+LivC7LNdn4cPAHkdE6+BRIORMf7+
         FJiMuCHu5HvuUIDxmlJuTbrNtOTfLlTU4XOuVrB/oTPKhuNu5UV2N6C3VGztM56lifsV
         05Jl+OPaFvRm4175Kyiv6GI+GuRbgyjC24B0Y=
Received: by 10.213.102.133 with SMTP id g5mr2518231ebo.43.1263569664810;
        Fri, 15 Jan 2010 07:34:24 -0800 (PST)
Received: from @ (91-165-137-43.rev.libertysurf.net [91.165.137.43])
        by mx.google.com with ESMTPS id 14sm377348ewy.7.2010.01.15.07.34.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 07:34:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100114203928.GA26883@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137074>

The 14/01/10, Jeff King wrote:

>   1. Most programs don't take their own globs. Without knowing that git
>      can do so, there is no reason to discover it in this instance. I
>      can see searching the manpage for options, but not for a discussion
>      of globbing behavior.
> 
>   2. They would have to know that using a git-glob will magically change
>      the error-checking behavior.

Not sure. This isn't a Git-particular issue.

Users may hit this with a lot of other unix tools (sed, grep, find,
etc). So, we can expect either
  they already know the issue;
or
  they are discovering it using Git.

Most of the tools I talk about do have a manual section about globbing.
Users could learn globs with Git too and expect the same behaviour
somewhere else.


-- 
Nicolas Sebrecht
