From: Junio C Hamano <junkio@cox.net>
Subject: Re: repo-config needs a prefix.
Date: Thu, 10 Aug 2006 02:51:08 -0700
Message-ID: <7v8xlwx6k3.fsf@assigned-by-dhcp.cox.net>
References: <44DAFE34.50701@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 11:51:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB7C7-00020e-8n
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 11:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWHJJvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 05:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWHJJvL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 05:51:11 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63976 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161114AbWHJJvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 05:51:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810095109.JWMS6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 05:51:09 -0400
To: Robert Shearman <rob@codeweavers.com>
In-Reply-To: <44DAFE34.50701@codeweavers.com> (Robert Shearman's message of
	"Thu, 10 Aug 2006 10:36:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25177>

While I do agree that it would be better to give nicer message
when running "git-fetch" in bogus places, I do not know if your
patch is the right fix.  Especially, I am not sure if this
change meshes well with this fix a few months ago.

commit 4d599e6bb46d6ef3276425af34922fdbf3aac473
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Thu May 25 08:22:42 2006 -0700

    bogus "fatal: Not a git repository"
    
    I was just testing that "git ls-remote" change by Junio, and when you're
    not in a git repository, it gives this totally bogus warning. The _target_
    obviously has to be a git repository, but there's no reason why you'd have
    to be in a local git repo when doing an ls-remote.
