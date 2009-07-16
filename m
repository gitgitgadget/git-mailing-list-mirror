From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: mailmap distinguishing names
Date: Thu, 16 Jul 2009 21:43:14 +0400
Organization: St.Petersburg State University
Message-ID: <20090716174313.GA10298@landau.phys.spbu.ru>
References: <85b5c3130907151522x1009a796tced7726d9be4ca7d@mail.gmail.com> <20090716085532.GA8843@landau.phys.spbu.ru> <85b5c3130907161009k64029bd3t23155040728d9d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Thu Jul 16 19:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRUzN-0006qF-Ea
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 19:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbZGPRnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 13:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbZGPRnR
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 13:43:17 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:3092 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbZGPRnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 13:43:16 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 3F20817B668; Thu, 16 Jul 2009 21:43:14 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <85b5c3130907161009k64029bd3t23155040728d9d9@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123410>

On Thu, Jul 16, 2009 at 11:09:06AM -0600, Ondrej Certik wrote:
> Hi Kirill!
> 
> >
> > You just do
> >
> >    Ondrej Certik <...@...>   ondrej.certik  <devnull@localhost>
> >
> >
> > in .mailmap
> >
> > See Documentation/mailmap.txt for details
> 
> Many thanks for help, that's exactly what I want.
> 
> Only I think I am probably doing something stupid, because I can't get
> it to work (I use the latest git from git),
> I put this into the root directory:
> 
> $ cat .mailmap
> Ondrej Certik <...@...>   ondrej.certik <devnull@localhost>
> 
> (if have my real address instead of the ...@..), and:
> 
> $ git shortlog -ns
>   654  Ondrej Certik
>   322  Kirill Smelkov
>   268  ondrej.certik
> [...]
> 
> it still shows ondrej.certik.  I will try to debug it why it doesn't
> work, I think according to the documentation it should work.

It does work with the following mailmap:

    Ondrej Certik <ondrej@certik.cz>    ondrej.certik <devnull@localhost>

before:

$ git shortlog -s | grep -i certik
   654  Ondrej Certik
   268  ondrej.certik


after:

$ git shortlog -s | grep -i certik
   922  Ondrej Certik
