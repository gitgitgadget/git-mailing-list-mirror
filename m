From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 13:16:10 -0700
Message-ID: <7vwtb9hrp1.fsf@assigned-by-dhcp.cox.net>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jun 22 22:16:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtVb9-0002YW-Cf
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 22:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWFVUQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Jun 2006 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWFVUQN
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 16:16:13 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:13981 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030375AbWFVUQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 16:16:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622201611.KIQB19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 16:16:11 -0400
To: git@vger.kernel.org
In-Reply-To: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 22 Jun 2006 12:49:47 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22366>

Junio C Hamano <junkio@cox.net> writes:

> * The 'pu' branch, in addition, has these.
>
>    Johannes Schindelin:
>       Teach diff about -b and -w flags

I am hoping to coordinate the inclusion of this upstream first
and have this hopefully in the real 1.4.1 release.

>    Lukas Sandstr=F6m:
>       Make it possible to call cmd_apply multiple times
>       Make git-am a builtin

Last time I tried this, it did not work for me, so I am putting
it on hold.  I feel, however, "am" is a high-enough-level tool
that we would prefer to keep it scriptable for quick tweaks.

If it is hurting portability because it is written in shell,
maybe this can be moved to all Perl (especially when Pasky's
Git.pm is ready) or Python.  Personally I think Windows minded
folks who cannot stand command-line interface Cygwin port gives
would not be satisfied anyway, until somebody writes a native
drag-this-mail-and-drop-on-that-brach tool, so porting the
command out of shell may not be even worth doing.  I dunno.
