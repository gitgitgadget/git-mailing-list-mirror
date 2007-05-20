From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 21:17:18 +0200
Message-ID: <20070520191718.GI4085@planck.djpig.de>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com> <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net> <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com> <7vabvzoij8.fsf@assigned-by-dhcp.cox.net> <e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com> <7v1whbmjel.fsf@assigned-by-dhcp.cox.net> <e5bfff550705201156m244e1cf0v7e6b3ab43fa3b47b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 21:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpquF-0001vT-Rg
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136AbXETTRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758474AbXETTRY
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:17:24 -0400
Received: from planck.djpig.de ([85.10.192.180]:1307 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898AbXETTRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:17:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id F191C88060;
	Sun, 20 May 2007 21:17:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8nQ8gD9J3VTC; Sun, 20 May 2007 21:17:18 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id B383A88105; Sun, 20 May 2007 21:17:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e5bfff550705201156m244e1cf0v7e6b3ab43fa3b47b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47892>

On Sun, May 20, 2007 at 08:56:49PM +0200, Marco Costalba wrote:
> On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
> >>               if (offset >= 0) {
> >> +
> >> +                     if (desc->size - oldsize - offset == 0) /* end of 
> >file? */
> >> +                             newsize -= trailing_added_lines;
> >> +
> >>                       int diff = newsize - oldsize;
> >>                       unsigned long size = desc->size + diff;
> >>                       unsigned long alloc = desc->alloc;
> >
> >But we have kept our sources -Wdeclaration-after-statement
> >clean so far
> 
> ??????
> 
> Wie bitte?

man gcc:

-Wdeclaration-after-statement (C only)
   Warn when a declaration is found after a statement in a block.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
