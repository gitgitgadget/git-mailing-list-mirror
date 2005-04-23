From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sun, 24 Apr 2005 01:02:38 +0200
Message-ID: <20050423230238.GD13222@pasky.ji.cz>
References: <1114280570.5068.5.camel@mulgrave> <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org> <1114292680.4799.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 00:58:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTZd-0001lg-Pc
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 00:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVDWXCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDWXCu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:02:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51639 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262167AbVDWXCl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:02:41 -0400
Received: (qmail 28535 invoked by uid 2001); 23 Apr 2005 23:02:38 -0000
To: James Bottomley <James.Bottomley@SteelEye.com>
Content-Disposition: inline
In-Reply-To: <1114292680.4799.4.camel@mulgrave>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 11:44:40PM CEST, I got a letter
where James Bottomley <James.Bottomley@SteelEye.com> told me that...
> On Sat, 2005-04-23 at 13:17 -0700, Linus Torvalds wrote:
> > Yeah, yeah, you obviously meant "$?", but the fact 
> > is, your patch is bogus, and I don't trust it. Can you re-send a valid
> > one 
> > (and sign off on it).]
> 
> OK, here it is  .. I have an excuse, honest ... and a note from my mum.
> 
> +	ret=$?
> +	if [ "$6" != "$7" ]; then
> +		echo "ERROR: Permissions $5->$6->$7 don't match merging $src2"
> +		if [ $ret -ne 0 ]; then
> +			echo "ERROR: Leaving conflict merge in $src2"
> +		fi
> +		exit 1
> +	fi
> +	chmod -- "$6" "$src2"
> +	if [ $ -ne 0 ]; then

*cough*

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
