From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Stop prepending /usr/bin to hooks PATH, or document it very clearly
Date: Sat, 18 Oct 2014 16:49:24 +0200
Message-ID: <20141018144924.GA17925@inner.h.apk.li>
References: <CAFXrp_c+dxafLOO6T=LDd6OxhfpamkJsUc8iBwB-B41z8Htc4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ciro Santilli <ciro.santilli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 17:06:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfVaV-0005HR-Nl
	for gcvg-git-2@plane.gmane.org; Sat, 18 Oct 2014 17:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaJRPGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 11:06:31 -0400
Received: from continuum.iocl.org ([217.140.74.2]:43709 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaJRPGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 11:06:30 -0400
X-Greylist: delayed 1023 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Oct 2014 11:06:30 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s9IEnOC19323;
	Sat, 18 Oct 2014 16:49:24 +0200
Content-Disposition: inline
In-Reply-To: <CAFXrp_c+dxafLOO6T=LDd6OxhfpamkJsUc8iBwB-B41z8Htc4A@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 Oct 2014 13:25:42 +0000, Ciro Santilli wrote:
...
> The problem is that the `/usr/bin` breaks "interpreter version manager
> systems" like RVM, rbenv, virtualenv, etc. since people will write
> hooks like:
> 
>     #!/usr/bin/env ruby
> 
> and the `/usr/bin` ruby will get run instead of the managed one

And that is the right thing to do. What ruby to execute with is
a property of the hook script, not of the virtualenv a user happens
to be in. If you want virtualenvs, you should set up the right one
within the hook script.

...
> - documenting this behavior *very* clearly on `man githooks`

That would still be a good thing to do.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
