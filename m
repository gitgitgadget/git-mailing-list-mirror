From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git BOF notes
Date: Fri, 21 Jul 2006 09:18:24 -0400
Message-ID: <20060721131824.GC32585@fieldses.org>
References: <20060719230155.GJ13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 15:19:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3uuB-0008IE-Nl
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 15:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWGUNS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 09:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWGUNS1
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 09:18:27 -0400
Received: from mail.fieldses.org ([66.93.2.214]:19080 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750710AbWGUNS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 09:18:26 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1G3utc-0000Ue-Ox; Fri, 21 Jul 2006 09:18:24 -0400
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060719230155.GJ13776@pasky.or.cz>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24049>

On Thu, Jul 20, 2006 at 01:01:55AM +0200, Petr Baudis wrote:
>   (i) We should somehow separate the lowlevel Git commands from the
> highlevel ones meant for user consumption. There's too many of them
> and it is confusing for the users. Similarity with BitKeeper was pointed
> out (and I refrained from mentioning GNU Arch).

The man page already attempts to make this distinction in its command
list, though arguably the order is wrong (it lists the low-level
commands first) and you could argue about some of the choices (git
init-db may be "low level", but it's something everyone probably wants
to see).

"git help" already has an abbreviated list.  What else could we do?

--b.
