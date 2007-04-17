From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 2/7] Documentation: clarify git-checkout -f, minor editing
Date: Tue, 17 Apr 2007 09:58:12 -0400
Message-ID: <20070417135812.GE11907@fieldses.org>
References: <9733.45415336571$1176698256@news.gmane.org> <7v4pngyk9n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 15:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdoCJ-0002vs-Jq
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 15:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbXDQN6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 09:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbXDQN6O
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 09:58:14 -0400
Received: from mail.fieldses.org ([66.93.2.214]:39457 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754377AbXDQN6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 09:58:13 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdoCC-00044U-AZ; Tue, 17 Apr 2007 09:58:12 -0400
Content-Disposition: inline
In-Reply-To: <7v4pngyk9n.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44767>

On Sun, Apr 15, 2007 at 10:13:08PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@citi.umich.edu> writes:
> 
> > "Force a re-read of everything" doesn't mean much to me.
> >
> > @@ -38,7 +38,8 @@ OPTIONS
> >  	Quiet, supress feedback messages.
> >  
> >  -f::
> > -	Force a re-read of everything.
> > +	Proceed even if the index or the working tree differs
> > +	from HEAD.
> >  
> 
> While this is definitely better, I think it still is not clear
> why the command needs an option to proceed.
>
> Not proceeding is about preventing local changes from getting
> lost, and the option is a way to allow it to overwrite and lose
> any local change.

OK, I agree; does the patch in the following message look like an
improvement?

> Other than that, and your "From: " line (did you change your
> config or switch machines?)

Whoops, yes, I was sloppy about setting up a new laptop--apologies.

> on the first three commits, I find all the changes very sensible.

Thanks.--b.
