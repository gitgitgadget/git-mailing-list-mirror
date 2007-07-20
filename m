From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Thu, 19 Jul 2007 21:29:38 -0700
Message-ID: <7vbqe71yvh.fsf@assigned-by-dhcp.cox.net>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
	<200707190140.05235.jnareb@gmail.com>
	<7vvech42nb.fsf@assigned-by-dhcp.cox.net>
	<200707191105.19735.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <hashproduct@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 06:29:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBk7c-0001bT-TG
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 06:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbXGTE3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 00:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbXGTE3k
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 00:29:40 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55481 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbXGTE3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 00:29:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720042939.GPLQ1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Jul 2007 00:29:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RgVe1X00B1kojtg0000000; Fri, 20 Jul 2007 00:29:39 -0400
In-Reply-To: <200707191105.19735.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 19 Jul 2007 11:05:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53049>

Jakub Narebski <jnareb@gmail.com> writes:

> On Thu, 19 July 2007, Junio C Hamano wrote:
> ...
>> I really hate to having to say something like that in the
>> RelNotes.  I do not think this is a good enough reason to break
>> existing configurations; I would not want to be defending that
>> change.
>
> Would it be sufficient to put above alert/warning in commit message,
> RelNotes and gitweb/INSTALL (or gitweb/README), and add rule to Makefile
> to convert old configuration, or at least check if GITWEB_CONFIG uses
> old snapshot configuration? This way if somebody is installing/upgrading
> gitweb by hand he/she would know what needs possibly to be changes, and
> if somebody uses "make gitweb/gitweb.cgi" he would get big fat warning,
> and info how to convert gitweb config.
>
> By the way, I think it was a mistake to use different syntax in the
> %feature hash ([content-encoding, suffix, program]) than in repo config
> override (name).

That's true.  I'd rather see this polished a bit more before
applying.
