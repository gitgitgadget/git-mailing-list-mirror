From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage
Date: Sat, 23 Sep 2006 13:46:59 -0700
Message-ID: <7vac4qs43g.fsf@assigned-by-dhcp.cox.net>
References: <20060919212725.GA13132@pasky.or.cz>
	<20060923125746.GJ8259@pasky.or.cz>
	<7virjes7dq.fsf@assigned-by-dhcp.cox.net> <ef43do$fm1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 22:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GREOx-0005fq-CJ
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 22:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWIWUrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 16:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIWUrB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 16:47:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11474 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964898AbWIWUrA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 16:47:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923204659.XKLT6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 16:46:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rwmy1V0061kojtg0000000
	Sat, 23 Sep 2006 16:46:58 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ef43do$fm1$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	23 Sep 2006 21:54:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27625>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"<a href=3D\"http://www.kernel.org=
/pub/software/scm/git/docs/\" title=3D\"git documentation\">" .
>> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"<a href=3D\"" . esc_html($githelp=
_url) .
>> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"\" title=3D\"" . esc_html($githel=
p_label) .
>> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"\">" .
>
> Why not use $cgi->a_begin({-href=3D>esc_param($githelp_url), -title=3D=
>$githelp_label});
> or just plain $cgi->a and $cgi->img?

Be my guest and send in a proper patch please.

I was merely demonstrating my preference on how definition of
default values and actual use of them are separated.
