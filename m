From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Python extension commands in git - request for policy change
Date: Mon, 26 Nov 2012 09:32:03 +0100
Message-ID: <20121126083202.GA29437@shrek.podlesie.net>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <20121125214139.GA29465@shrek.podlesie.net>
 <20121125224728.GD6937@thyrsus.com>
 <CAMK1S_g2jpa+VqnuzhNaBNkC5bJHwbEy1iP-=sG29FFKmjTjpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 09:32:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcu75-0000mN-Lp
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 09:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab2KZIcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 03:32:08 -0500
Received: from [93.179.225.50] ([93.179.225.50]:60199 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754385Ab2KZIcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 03:32:07 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 1A26850F; Mon, 26 Nov 2012 09:32:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAMK1S_g2jpa+VqnuzhNaBNkC5bJHwbEy1iP-=sG29FFKmjTjpw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210425>

On Mon, Nov 26, 2012 at 10:40:00AM +0530, Sitaram Chamarty wrote:
> On Mon, Nov 26, 2012 at 4:17 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> > Krzysztof Mazur <krzysiek@podlesie.net>:
> >> What about embedded systems? git is also useful there. C and shell is
> >> everywhere, python is not.
> >
> > Supposing this is true (and I question it with regard to shell) if you
> > tell me how you live without gitk and the Perl pieces I'll play that
> > right back at you as your answer.
> 
> gitk is unlikely to be used on an embedded system, the perl pieces more so.

Currently even perl is used only for few very high level commands that
are not really needed there. I think that python is ok for pieces
that use perl now, but I think that it shouldn't be used for
basic porcelain commands. I also don't think that we should prefer
python over other languages and especially I don't think that some
existing code should be rewritten to python.

Even if python is really better, I think that the natural migration is
much better.

> 
> I have never understood why people complain about readability in perl.
>  Just because it uses the ascii charset a bit more?  You expect a
> mathematician or indeed any scientist to use special symbols to mean
> special things, why not programmers?
> 

Because some perl programmers really create write-only code, but the
maintainer can just reject that code. It's not the language that
create non-readable code, but the programmer. I think that the perl
code in git is readable, at least is parts I've seen.

Krzysiek
