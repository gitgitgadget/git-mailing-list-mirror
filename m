From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 17:29:17 +1000
Message-ID: <2cfc403205061100295ca06ed3@mail.gmail.com>
References: <E1DgodI-0003ov-Fl@highlab.com>
	 <7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	 <E1DgyW0-0004PE-Ct@highlab.com>
	 <2cfc403205061023346c03a25b@mail.gmail.com>
	 <87r7f9xsux.fsf@windlord.stanford.edu>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 09:25:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh0MW-0007QW-7u
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 09:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFKH3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 03:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFKH3V
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 03:29:21 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:48612 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261342AbVFKH3R convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 03:29:17 -0400
Received: by rproxy.gmail.com with SMTP id i8so401647rne
        for <git@vger.kernel.org>; Sat, 11 Jun 2005 00:29:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bU8X6q1PmX6WMgK160LC1/Bk/XO9uRv51sbKZd20JhkJs8rNSDpihkiJEsnyh2N4Fyr6Kbo1yN5ecWGejLGUZ158nsqdELLxSxXID8v/W2CfJkZz+BVsdpGT8+mws6OuZgWZacKIBnIb9KXn5RKXElrBTexuS1nNf6tBPMgZC5M=
Received: by 10.39.2.80 with SMTP id e80mr45232rni;
        Sat, 11 Jun 2005 00:29:17 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 11 Jun 2005 00:29:17 -0700 (PDT)
To: Russ Allbery <rra@stanford.edu>
In-Reply-To: <87r7f9xsux.fsf@windlord.stanford.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/11/05, Russ Allbery <rra@stanford.edu> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
> 
> > What is the justification for removing it?
> 
> The conflict with the existing GIT package is painful for distributions.
> Packagers try hard to avoid any file conflicts between packages, since it
> means that both packages cannot be used at the same time, and it turns out
> in discussion on the Debian mailing lists that people actually do use GIT.
> 
> Managing the conflict between two programs that do completely different
> things and are named the same thing is really annoying.
> 

Ah, ok...sorry didn't realise there was a naming conflict.

How about renaming:
    "git" to "g.t"
 
And then explaining the idiosyncratic name in git(7).

jon.
