From: Eric Wong <normalperson@yhbt.net>
Subject: Re: contrib/ status
Date: Tue, 4 Jul 2006 14:56:43 -0700
Message-ID: <20060704215643.GA31763@localdomain>
References: <200607030156.50455.jnareb@gmail.com> <200607030202.55919.jnareb@gmail.com> <7vodw7zgt2.fsf@assigned-by-dhcp.cox.net> <e89ock$gks$1@sea.gmane.org> <7vslljwiat.fsf@assigned-by-dhcp.cox.net> <7vmzbrwi3c.fsf_-_@assigned-by-dhcp.cox.net> <20060703080625.GB29036@hand.yhbt.net> <7vbqs6pfhi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 23:56:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxssy-00047H-Gk
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 23:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWGDV4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 17:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWGDV4q
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 17:56:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:12963 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932273AbWGDV4p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 17:56:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BEBBE7DC021;
	Tue,  4 Jul 2006 14:56:43 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  4 Jul 2006 14:56:43 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqs6pfhi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23319>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> Junio C Hamano <junkio@cox.net> writes:
> >> 
> >> > ... the
> >> > things under contrib/ are not part of git.git but are there only
> >> > for convenience....
> >> 
> >> This reminds me of something quite different.  I am getting an
> >> impression that enough people have been helped by git-svn and it
> >> might be a good idea to have it outside contrib/ area.
> >
> > That would be great.  IMHO, it puts git in a position to supplant
> > centralized SVN usage one developer at a time, making it easier
> > to make a gradual transition to git.  Of course, there's also svk
> > in a similar position...
> 
> OK, then let's give a few days (it's a long weekend extendeding
> into July 4th in the US) to let others from the list chime in,
> and then please help me migrate your test scripts and Makefile
> pieces into the toplevel project.

Ok, I'll have a patch ready by then.  I'm not sure which number family I
should take for the tests, 8xxx and 9xxx don't have any rules for their
use, but the [89]0xx area seems taken.  Would naming them 91xx be good?

Also, the tests can be extremely slow since they rely on svn, so there
will be a way to skip the tests if users are not interested.

-- 
Eric Wong
