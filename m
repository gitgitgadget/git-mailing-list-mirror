From: Petr Baudis <pasky@suse.cz>
Subject: Re: Better cooperation between checkouts and stashing
Date: Tue, 2 Feb 2010 12:04:16 +0100
Message-ID: <20100202110416.GN9553@machine.or.cz>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
 <4B674E36.40708@web.de>
 <76c5b8581002011444t4f955fcdrd1f582f5c043f705@mail.gmail.com>
 <20100202013647.GM9553@machine.or.cz>
 <4B67FDEC.80005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 12:04:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcGYa-0002xv-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 12:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab0BBLEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 06:04:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:38099 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab0BBLEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 06:04:20 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id A7CF786202A; Tue,  2 Feb 2010 12:04:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B67FDEC.80005@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138711>

On Tue, Feb 02, 2010 at 11:26:52AM +0100, Markus Elfring wrote:
> 
> > For better or worse, There Is More Than One Way To Do It in Git. ;-)
> >   
> 
> Do you see also a need for improvements in the cooperation between the
> functions "checkout" and "stash"?
> Would it be useful to combine them into a single command on demand to
> make the switching of branches without committing
> changes a bit more convenient?

I personally prefer to tell Git explicitly what to do when I'm
checkouting a different branch, and have a habit of checking what kind
of uncommitted changes I have all the time (and I think it's a good
habit ;-), so I have no problem with explicitly stashing before
checkouting different branch if I need to.

The thing is, I use multiple branches less than I should. If I used them
more, I'd probably be simply using stash much less than making temporary
commits and possibly cleaning them up later instead. (But if you get
really used to sensibly separating commits, you end up actually adjusting
your programming process subconsciously in a way to lend to the
appropriate commit sequence naturally.)

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
