From: Junio C Hamano <junkio@cox.net>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 15:39:16 -0700
Message-ID: <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	<Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
	<44713BE4.9040505@gentoo.org>
	<Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
	<46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	<Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
	<46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	<44720C66.6040304@gentoo.org>
	<46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	<Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	<20060522214128.GE16677@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 00:39:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJ3d-0005pY-TL
	for gcvg-git@gmane.org; Tue, 23 May 2006 00:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWEVWjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWEVWjT
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 18:39:19 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29598 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751282AbWEVWjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 18:39:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522223917.MHAZ27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 18:39:17 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20060522214128.GE16677@kiste.smurf.noris.de> (Matthias Urlichs's
	message of "Mon, 22 May 2006 23:41:28 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20542>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Hi,
>
> Linus Torvalds:
>> I wonder why those "git-update-index" calls seem to be (assuming I read 
>> the perl correctly) done only a few files at a time. We can do a hundreds 
>> in one go, but it seems to want to do just ten files or something at the 
>> same time.
>
> No, fifty.
>
> I simply was too lazy to count the actual filenames' lengths. ;-)

I think cvsimport predates that option, but these days that loop
can be optimized by feeding --index-info from standard input.
