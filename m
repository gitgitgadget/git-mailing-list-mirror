From: Junio C Hamano <junkio@cox.net>
Subject: Re: First cut at git port to Cygwin
Date: Mon, 10 Oct 2005 13:21:30 -0700
Message-ID: <7vr7at3yyd.fsf@assigned-by-dhcp.cox.net>
References: <20051005155457.GA30303@trixie.casa.cgf.cx>
	<20051005191741.GA25493@steel.home>
	<20051005202947.GA6184@trixie.casa.cgf.cx>
	<81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
	<81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
	<81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
	<Pine.LNX.4.64.0510070828270.31407@g5.osdl.org>
	<20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home>
	<4346E8AC.5030503@citi.umich.edu> <20051007213952.GA8821@steel.home>
	<Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
	<Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr7avrgr2.fsf@assigned-by-dhcp.cox.net> <434AB663.8050205@zytor.com>
	<Pine.LNX.4.63.0510102100010.7688@wbgn013.biozentrum.uni-wuerzburg.de>
	<434AC058.60803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:25:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP49P-0005B2-Ud
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVJJUVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVJJUVd
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:21:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10166 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751200AbVJJUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:21:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010202113.ZSGL11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 16:21:13 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434AC058.60803@zytor.com> (H. Peter Anvin's message of "Mon, 10
	Oct 2005 12:26:16 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9921>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eh?  If we MAP_PRIVATE, *and* we (intentionally) write to it, we 
> *BETTER* not write anything back.

Correct.

It has already been fixed by Johannes last week and I merged it
over the weekend if not earlier if I recall correctly.
