From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-archive: document CWD effect
Date: Mon, 09 Apr 2007 13:00:03 -0700
Message-ID: <7v7islz5bw.fsf@assigned-by-dhcp.cox.net>
References: <esc64d$d2u$1@sea.gmane.org> <4618DFEE.8080707@lsrfire.ath.cx>
	<7virc68nc1.fsf@assigned-by-dhcp.cox.net>
	<461A55FB.6070600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Williams <njw@jarb.freeserve.co.uk>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb027-0002uA-Qb
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 22:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbXDIUAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Apr 2007 16:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbXDIUAH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 16:00:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49310 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965309AbXDIUAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 16:00:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409200004.FQIW1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Apr 2007 16:00:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id l8041W00Y1kojtg0000000; Mon, 09 Apr 2007 16:00:04 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44093>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
> ...
>> Since people who _really_ want a subtree can
>> just say "git archive --format=3Dtar HEAD:Documentation", I
>> suspect we may be better off not doing "current directory only"
>> by default.  This changes the behaviour, but (1) it affects only
>> people who run from a subdirectory, (2) it is counterintuitive
>> that your location in the working tree matters when you say "I
>> want a tarball of that commit", and (3) it is an undocumented
>> behaviour anyway.
>
> I agree with (1) and (3), meaning that we are free to change the
> behaviour.  I don't agree with (2), though.  I'd find it strange if
> changing the working directory wouldn't change the archive contents.
>
> We should keep consistency with the rest of git here.  Since git-arch=
ive
> is just a fancy git-ls-tree, I think we should mirror its behaviour w=
ith
> respect to the working directory.  (Which is what the current code do=
es.
> Modulo bugs, of course.)

I am tempted to say "fair enough", but I would wait for others
to come up with objections I did not think of.
