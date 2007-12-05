From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: * [BUG] "git clean" does not pay attention to its parameters
Date: Wed, 5 Dec 2007 11:50:05 +0100
Message-ID: <20071205105005.GA6961@uranus.ravnborg.org>
References: <200712050654.lB56scKk000311@mi0.bluebottle.com> <7veje1zibm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 11:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izro2-0004td-S1
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbXLEKsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 05:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbXLEKsT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:48:19 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:52296 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616AbXLEKsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 05:48:18 -0500
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 5D622801C6C;
	Wed,  5 Dec 2007 11:48:16 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id D4565580D2; Wed,  5 Dec 2007 11:50:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7veje1zibm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67136>

On Tue, Dec 04, 2007 at 11:55:41PM -0800, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@bluebottle.com> writes:
> 
> > In a repository with LaTeX documents, I tried to see what *.aux files are left behind after formatting, by running "git clean -n" with the latest git (1.5.3.7-1005-gdada0c1):
> >
> >   % git clean -n '*.aux'
> >
> > This however showed more than just '*.aux' files.  With the released version 1.5.3.6, the output is correctly limited to the files that match the pattern.
> 
> Yuck.  People actually use git-clean?

git clean -d -x is my friend.
It it a great way to delete all my temporary files named 'kurt', 'fisk', 'viggo', 'x*' etc.

	Sam
