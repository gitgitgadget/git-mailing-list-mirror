From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 01:09:23 +0100
Message-ID: <20051111000923.GF30496@pasky.or.cz>
References: <1124832796.23795.9.camel@dv> <200511110026.18324.Josef.Weidendorfer@gmx.de> <20051110234029.GE30496@pasky.or.cz> <200511110056.54476.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 01:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaMTx-0003qB-VV
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 01:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKKAJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 19:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVKKAJ1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 19:09:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16556 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932259AbVKKAJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 19:09:26 -0500
Received: (qmail 26800 invoked by uid 2001); 11 Nov 2005 01:09:23 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200511110056.54476.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11539>

Dear diary, on Fri, Nov 11, 2005 at 12:56:54AM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> Still I think my reasoning holds: cg-clone is also used locally, thus
> cloning a repository on which you probably are working on, too.

Yes, that's a valid point, but I still think for the usual case
defaulting to HEAD is the right thing to do. But it wasn't described
in the documentation and that's indeed a bug - fixed now.

> If I want to branch off from master, I can use cg-clone to start a new
> development branch. I suppose this is the suggested Cogito way, from
> the README; and it makes Cogitos usage so simple, even with multiple
> development branches: by using a cloned repository for each branch.

Yes, this is the recommended workflow. Well, if you plan to switch
branches randomly in your "central private repository", better explicitly
specify #master in the offsprings. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
