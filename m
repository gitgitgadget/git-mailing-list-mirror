From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log is a bit antisocial
Date: Fri, 14 Apr 2006 15:06:02 -0700
Message-ID: <7vu08volrp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain>
	<7vlku7q3k7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141719290.2215@localhost.localdomain>
	<7vhd4vq23h.fsf@assigned-by-dhcp.cox.net>
	<1145051072.27704.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 00:06:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUWQa-0007sq-NM
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 00:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWDNWGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Apr 2006 18:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWDNWGF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 18:06:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20113 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030201AbWDNWGE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 18:06:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414220603.KBDA18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 18:06:03 -0400
To: =?iso-8859-1?Q?S=E9bastien?= Pierre <sebastien@xprima.com>
In-Reply-To: <1145051072.27704.1.camel@localhost.localdomain>
 (=?iso-8859-1?Q?S=E9bastien?=
	Pierre's message of "Fri, 14 Apr 2006 17:44:32 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18705>

S=E9bastien Pierre <sebastien@xprima.com> writes:

> Le vendredi 14 avril 2006 =E0 14:28 -0700, Junio C Hamano a =E9crit :
>
>> What about it?
>>=20
>> Asking for help on log could be spelled as "git log --help" with
>> a patch like the attached, but I am not sure that is worth it...
>
> I would say that it is very useful to newbies, or simply not to
> frustrate users trying to get help. It is really worth it, at least f=
or
> me.

Have you read the patch, especially the comment in it?  With and
without the patch, this command would behave quite differently:

	$ git commit --help
