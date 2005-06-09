From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add support reading default options from conf file
Date: Thu, 9 Jun 2005 10:32:43 +0200
Message-ID: <20050609083243.GD29665@pasky.ji.cz>
References: <20050609010056.GA9084@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Holmsand <holmsand@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 12:13:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgIP3-0007L8-NY
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 10:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVFIIcq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 04:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVFIIcq
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 04:32:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34540 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262330AbVFIIco (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 04:32:44 -0400
Received: (qmail 7230 invoked by uid 2001); 9 Jun 2005 08:32:43 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050609010056.GA9084@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 09, 2005 at 03:00:56AM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Reply-To: 
> In-Reply-To: <42A754D5.10705@gmail.com>
> 
> Dan Holmsand <holmsand@gmail.com> wrote Wed, Jun 08, 2005:
> > - Automatic color if the COGITO_AUTO_COLOR environment variable is set.
> 
> [ This has been discussed before. Default arguments. The 'new' cg
>   wrapper makes this very easy. Not as smart as your env variable
>   handling tho'. ]
> 
> The default options are read only for Cogito calls going through the new
> cg wrapper which makes it trivial to 'overwrite' them by just calling
> cg-COMMAMD.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

No, this is the wrong way. The 'cg' wrapper must not really do anything
special on its own. It's not a _replacement_ for direct calling of the
cg-scripts, it's just an aid for people who don't want to get used to
it. So please do this in cg-Xlib.

Also, I'd prefer the config file to be something like ~/.cgrc. I want to
reserve the .conf file for something more sophisticated. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
