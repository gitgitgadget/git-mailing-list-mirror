From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] diff.c: second war on whitespace.
Date: Sat, 23 Sep 2006 02:37:37 -0700
Message-ID: <7vzmcqudni.fsf@assigned-by-dhcp.cox.net>
References: <7vbqp7vxb8.fsf@assigned-by-dhcp.cox.net>
	<ef2u05$f29$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 11:38:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR3xo-0007DO-Gy
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 11:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWIWJhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 05:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWIWJhj
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 05:37:39 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:19945 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751413AbWIWJhj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 05:37:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923093738.HDPK22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 05:37:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rldg1V0081kojtg0000000
	Sat, 23 Sep 2006 05:37:40 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ef2u05$f29$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	23 Sep 2006 11:15:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27575>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> gmane.comp.version-control.git
>> This adds DIFF_WHITESPACE color class (default =3D reverse red) to
>> colored diff output to let you catch common whitespace errors.
>>=20
>> =A0- trailing whitespaces at the end of line
>> =A0- a space followed by a tab in the indent
>
> In gitweb/gitweb.perl, around %feature hash definition, we have:
>
>         <TAB> # <SP> <TAB> 'sub' ...
>
> and I think that is exception to the "no space followed by tab" rule.

Read the description again.  No space IN INDENT that is followed
by tab.
