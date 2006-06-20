From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH (fixed)] git-svn: fix --rmdir when using SVN:: libraries
Date: Mon, 19 Jun 2006 22:53:33 -0700
Message-ID: <20060620055333.GA17674@hand.yhbt.net>
References: <11507645052855-git-send-email-normalperson@yhbt.net> <11507651751452-git-send-email-normalperson@yhbt.net> <7vbqso7him.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 07:53:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsZBB-0002S1-Mz
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 07:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWFTFxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 01:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWFTFxe
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 01:53:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:9872 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S965056AbWFTFxe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 01:53:34 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 709EE7DC022; Mon, 19 Jun 2006 22:53:33 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqso7him.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22166>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Makefile: automatically run new tests as they appear in t/
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >
> > Oops, I left out the Makefile change in the other patch,...
> 
> Yeah, I was wondering about that.
> 
> > ... had the new
> > test file as +x
> 
> Shouldn't they be executable?  It is not a big deal, because you
> run them via $(SHELL), though...

Yes, I prefer to use $(SHELL) instead.  Makes it easier to test with
different shells without mucking /bin/sh

-- 
Eric Wong
