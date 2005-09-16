From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH/RFC] Build a shared / renamed / "stable" version of the library?
Date: Fri, 16 Sep 2005 23:10:41 +0200
Message-ID: <20050916211040.GU7646@kiste.smurf.noris.de>
References: <pan.2005.09.16.12.37.14.736570@smurf.noris.de> <7vmzmcj1eo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: David Roundy <droundy@abridgegame.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 23:14:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGNVu-000424-Lm
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 23:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVIPVMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 17:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVIPVMj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 17:12:39 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:46993 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751293AbVIPVMj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 17:12:39 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EGNTn-0002cy-Cn; Fri, 16 Sep 2005 23:11:32 +0200
Received: (nullmailer pid 3374 invoked by uid 501);
	Fri, 16 Sep 2005 21:10:41 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzmcj1eo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8733>

Hi,

Junio C Hamano:
> Matthias, I think you are solving a wrong problem.  More
> precisely, solving problems in a wrong order.
> 
I've since looked a bit more closely at the "library" code, and ...
well, you're obviously right. :-/

> can read many blobs without spawning git-cat-file for each of
> them, but that is about how far you could go.

Precisely that was the first application I needed the library for. ;-)

> Don't get me wrong.  I would really want to see the guts of git
> libified and SWIG'ed.  That would help not just your Python
> thing but also StGIT and Fredrik merge (both are Python), as
> well as gitk (tcl/tk) and gitweb (Perl).  I would not even mind
> seeing all the git barebone Porcelain redone in Python once we
> go in that direction, ditching the shell scripts we currently
> have.
> 
You and me both...

> *5* Maybe we would want separate git_init_cache,
> git_init_objects, ... and be able to mix and match them.  Maybe
> not.  
> 
Makes sense. First steps would probably be to invent "struct
git_repository" and "struct git_cache" data structures. Fun. ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
INSIDE, I have the same personality disorder as LUCY RICARDO!!
		-- Zippy the Pinhead
