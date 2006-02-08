From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Wed, 08 Feb 2006 15:57:56 -0800
Message-ID: <7vu0b9mmij.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 00:58:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zD6-0001IP-Jh
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 00:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWBHX6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 18:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWBHX6x
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 18:58:53 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30149 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422665AbWBHX6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 18:58:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208235623.HQUG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 18:56:23 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 8 Feb 2006 15:44:58 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15767>

Linus Torvalds <torvalds@osdl.org> writes:

> So it would be much nicer if gitweb had some alternate approach to showing 
> merge diffs. My suggested approach would be to just let the user choose: 
> have separate "diff against fist/second[/third[/..]] parent" buttons. And 
> one of the choices would be the "conflict view" that git-diff-tree --cc 
> gives (I'd argue for that being the default one, because it's the only one 
> that doesn't have a "preferred parent").

I have something very rough, but I will be sending them out
anyways.
