From: Junio C Hamano <junkio@cox.net>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 03 Mar 2007 05:29:22 -0800
Message-ID: <7v3b4mbglp.fsf@assigned-by-dhcp.cox.net>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net>
	<7vabyweypw.fsf@assigned-by-dhcp.cox.net> <E1HNATn-0005Y6-HW@flower>
	<200703030357.18822.jnareb@gmail.com>
	<alpine.LRH.0.82.0703022223060.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Oleg Verych <olecom@flower.upol.cz>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 14:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNUIg-0005SS-Ni
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 14:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbXCCN3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 08:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbXCCN3Y
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 08:29:24 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52988 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbXCCN3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 08:29:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303132923.MKBZ2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 08:29:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WDVN1W0051kojtg0000000; Sat, 03 Mar 2007 08:29:23 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41296>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 3 Mar 2007, Jakub Narebski wrote:
>
>> By "conservatively" it means that it uses 'application/xhtml+xml' only when
>> client explicitly claims that it accepts its, and it is not due to for
>> example */* accept globbing.
>> 
>> So if lynx isn't working, it is its damn fault...
>
> I absolutely don't care.
>
> I use lynx, and lynx worked perfectly fine before.  So it is not lynx 
> that broke it.  Please fix gitweb.

I think the real question is if gitweb output need to be XHTML.
If everybody's browser is happier with text/html and we do not
have to use things only in xhtml, sending text/html out (both as
content-type and the actual contents) feels like the right thing
to do from compatibility point of view.
