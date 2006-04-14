From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Solaris test t5500 race condition
Date: Fri, 14 Apr 2006 13:53:17 +0200
Message-ID: <20060414115317.GA5191@bohr.gbar.dtu.dk>
References: <20060414031759.GA9524@bohr.gbar.dtu.dk> <7vhd4wvhyq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 14 13:53:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUMrc-0001DX-5t
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 13:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWDNLxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 07:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWDNLxV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 07:53:21 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:40132 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932397AbWDNLxV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 07:53:21 -0400
Received: (qmail 6791 invoked by uid 5842); 14 Apr 2006 13:53:17 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhd4wvhyq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18688>

On Thu, Apr 13, 2006 at 10:34:05PM -0700, Junio C Hamano wrote:
> "Peter Eriksen" <s022018@student.dtu.dk> writes:
> 
> >     Generating pack...
> >     Done counting 3 objects.
> >     Deltifying 3 objects.
> >       33% (1/3) done^M  66% (2/3) done^M 100% (3/3) done
> >     Total 3Unpacking , written 33 objects          <------------
> >      (delta 0), reused 0 (delta 0)
> >     11fa2f0cb58ed7f02dbd5ac75ed82a53fae62a7b refs/heads/A
> 
> Hmph.  Not good.  Before the writer managed to flush the report
> the reader has already decoded the header and reports the number
> of objects it is going to unpack.
...
> -- >8 --
> [PATCH] t5500: test fix

With the patch it doesn't complain anymore.  There are many other 
problems with the tests on Solaris though.

Peter
