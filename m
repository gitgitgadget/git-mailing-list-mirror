From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 19] gitweb: No need to quote path for list version of open "-|"
Date: Mon, 31 Jul 2006 19:17:08 -0700
Message-ID: <7vhd0x42u3.fsf@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<200607311833.39524.jnareb@gmail.com>
	<7v3bch7gf8.fsf@assigned-by-dhcp.cox.net> <ealk0e$to2$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 04:17:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7jop-0005EI-9q
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 04:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWHACRL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 31 Jul 2006 22:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWHACRL
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 22:17:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61107 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030387AbWHACRK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 22:17:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801021709.KCKD25430.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 22:17:09 -0400
To: jnareb@gmail.com
In-Reply-To: <ealk0e$to2$2@sea.gmane.org> (Jakub Narebski's message of "Mon,
	31 Jul 2006 21:00:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24565>

Jakub Narebski <jnareb@gmail.com> writes:

> <opublikowany i wys=C5=82any>
>
> Junio C Hamano wrote:
>
>> I suspect the patch title is wrong -- it is not "no need to" but
>> "quoting path breaks so do not do it" ;-).
>>=20
>> I guess this fixes the problem I saw last night?
>
> If I remember correctly it worked without this patch, for git 1.4.1.1=
=20
> (i.e. with --full-history option, although not working as advertised:=
 see my
> comment earlier in thread).

Couldn't have worked, or you have found a bug in whatever
command you invoked.  If it is told to look for a path that
starts with a single quote it should have done so and produced
no history since there is no such file.

In any case, the patch #19 seems to fix the problem.  Thanks.
