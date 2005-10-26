From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: 0.99.9 on Saturday next week.
Date: Wed, 26 Oct 2005 12:50:34 +0100
Message-ID: <b0943d9e0510260450k624268aav@mail.gmail.com>
References: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net> <tnx64rlrjux.fsf@arm.com>
	 <7virvlh6m5.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0510251033310.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 13:51:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUjnp-0006q6-D8
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 13:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVJZLug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 07:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVJZLuf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 07:50:35 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:2781 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751398AbVJZLuf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 07:50:35 -0400
Received: by xproxy.gmail.com with SMTP id i30so241447wxd
        for <git@vger.kernel.org>; Wed, 26 Oct 2005 04:50:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uBleQmVE+2+qn5DgiVe0LN5B0l9jiznntJ8+LxGTJsOCIfvt4ykhxmZktZas8r7p5FN2+xHte3FDYYR4D2svLZSRiYz8dGzmQwRERQoq+0DjpkzRIx12MbzREKAfSb2ZuOPJueLJA6UYPoAOEtLR9UlBjw6yeZzUyRctgj2l3rQ=
Received: by 10.70.54.6 with SMTP id c6mr405908wxa;
        Wed, 26 Oct 2005 04:50:34 -0700 (PDT)
Received: by 10.70.31.3 with HTTP; Wed, 26 Oct 2005 04:50:34 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510251033310.10477@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10663>

On 25/10/05, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 25 Oct 2005, Junio C Hamano wrote:
> > Catalin Marinas <catalin.marinas@gmail.com> writes:
> > > Since the configuration files use the .ini like syntax, is it OK for
> > > StGIT to use the same file, with an "[stgit]" section?
> >
> > I think that is a reasonable thing to do.
>
> Absolutely. The whole thing was _designed_ to be used that way. Any C user
> should be able to just link against config.o without even bothering with
> the rest of git (the only git-specific thing there should be some naming),
> and any script user can either

I use Python for StGIT and it has support for parsing .ini syntax, no
need to use GIT for this (unless the syntax you chose would diverge
too much).

--
Catalin
