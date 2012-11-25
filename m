From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 04:53:56 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125095356.GA22279@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 10:55:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcYw8-0003bl-Ju
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 10:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab2KYJyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 04:54:49 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42066
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2KYJys (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 04:54:48 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 651554065F; Sun, 25 Nov 2012 04:53:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210343>

Felipe Contreras <felipe.contreras@gmail.com>:
> If your friends jump off a bridge, would you? Yes, using python has
> served them well, but as opposed to what? Other scripting languages? I
> don't think so.

The competition that Python won was *precisely* against other scripting
languages, notably shell and Perl.  Both used to be much more heavily
used in system scripting than they are now.

> What if my extension only supports python 2.7? Or what if my extension
> wants to support 2.0?

I propose that if 2.6 can't support it, then that should be considered
grounds to reject it.

> Yes, they should _if_ they know what version they need. In my
> extensions I really have no idea.

Then you shouldn't submit those extensions to be folded into core git.

> > 3) We should be unconditionally be encouraging extensions to move
> > from shell and Perl to Python.  This would be a clear net gain is
> > portability and maintainability.
> 
> NO! It's up to the developer to choose what language to use,

I agree.  You seem to be raising a lot of straw men.  'Encouragement'
does not equate to beating anyone who makes an unpopular choice over
the head.

I am also not suggesting that the whole git core ought to be hoicked 
over to Python.  I was thinking mainly about extension subcommands, 
not what's in libgit now.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
