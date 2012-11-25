From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 00:18:09 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125051809.GA3670@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 06:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcUk0-0001Kg-BS
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 06:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab2KYFTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 00:19:03 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:40233
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab2KYFTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 00:19:01 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 93AA74065F; Sun, 25 Nov 2012 00:18:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210331>

Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> These may apply to other languages as well. Where do we draw a line?

I'm in favor of the general policy of avoiding scripting languages
other than the top three most widely deployed.  At the moment that
means shell, Python, Perl; on present trends, in a few years Perl
(dropping in popularity) might be passed by Ruby on the way up.

Or, to put it another way, I'm *not* actually arguing that we ought
to encourage extension commands in Guile or Haskell or whatever else
the in-language-of-the-week is.  It would be bad for maintainability 
to fragment git's codebase that way.

What I'm arguing is that the tradeoffs within the group {C, shell, Perl,
Python} have changed in ways that favor Python as it has become more
stable and widely deployed.  So instead of grudgingly allowing a few
Python extensions in through a back door we ought to be encouraging
more use of it.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
