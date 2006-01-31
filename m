From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 00:51:43 -0800
Message-ID: <7vvew03hls.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<43DDFF5C.30803@hogyros.de> <7v64o18qn4.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80601310037s58989b26s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 09:51:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3rEr-00020u-42
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 09:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWAaIvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 03:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWAaIvp
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 03:51:45 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:16546 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750704AbWAaIvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 03:51:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131084850.HYQL17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 03:48:50 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80601310037s58989b26s@mail.gmail.com>
	(vagabon.xyz@gmail.com's message of "Tue, 31 Jan 2006 09:37:38 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15304>

Franck <vagabon.xyz@gmail.com> writes:

> I built my public repository from a cautorized one and everybody who
> is pulling from mine is aware of the lack of the full history but they
> actually don't care. If someone is pulling from my repo, he actually
> wants to work on my project which do not need any old thing...

Mind writing up a howto on the topic?

 - How things are set up using the current tool.
 - How others initially clone from you.
 - How others update (pull) from you.
 - What are the pitfalls you and others need to avoid
   (i.e. operations that involve old history)

I brought this up, because lack of official support of shallow
cloning was cited as one of the showstopper for a project that
once considered switching to git but didn't, from a mailing list
research.
