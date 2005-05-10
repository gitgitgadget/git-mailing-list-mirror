From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Renaming environment variables.
Date: Tue, 10 May 2005 02:27:36 +0200
Message-ID: <20050510002736.GJ15712@pasky.ji.cz>
References: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org> <7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net> <20050510001351.GH15712@pasky.ji.cz> <7vzmv4udyx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:20:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIU0-0002ft-Cv
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVEJA1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVEJA1i
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:27:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33422 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261445AbVEJA1h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:27:37 -0400
Received: (qmail 4652 invoked by uid 2001); 10 May 2005 00:27:36 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmv4udyx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 10, 2005 at 02:22:30AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Except that you do not have to specify GIT_OBJECTS and
> GIT_INDEX_FILE separately, that is.  Is it what you are aiming
> for?

Yes. Having less things to specify is better. What if another directory
will be added to the git repository? Everything which wants to work with
something else than .git will be broken just because of this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
