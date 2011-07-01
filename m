From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [Wishlist] could git tell which password it is asking when asking a password.
Date: Fri, 01 Jul 2011 15:01:33 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87aacxepnm.fsf@lifelogs.com>
References: <877h82nlua.dlv@debian.org>
	<7v62nmos0k.fsf@alter.siamese.dyndns.org>
	<7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
	<BANLkTi=aAinh=0jxb5MoqVOdUB7zxoy2XdSqk+pdsewLXU62ZA@mail.gmail.com>
	<7vwrg1opov.fsf@alter.siamese.dyndns.org> <87tyb5n6pk.dlv@debian.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 22:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcjuT-0005wX-AW
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 22:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab1GAUBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 16:01:48 -0400
Received: from lo.gmane.org ([80.91.229.12]:33199 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab1GAUBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 16:01:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QcjuM-0005tA-UH
	for git@vger.kernel.org; Fri, 01 Jul 2011 22:01:46 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 22:01:46 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 22:01:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:J4dD09UpdnAb0cAWNrq3paSim3g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176533>

On Fri, 01 Jul 2011 21:25:59 +0200 R=E9mi Vanicat <vanicat@debian.org> =
wrote:=20

RV> Junio C Hamano <gitster@pobox.com> writes:
>> I was wondering about that when I gave that quick patch.  And "as a =
human"
>> may not necessarily apply when you are letting submodule fetch to re=
curse.

RV> I also believe that having the host name would be useful, both for =
human
RV> (another example would be git remote update when there are several
RV> remote) and script. =20

Maybe (using %U for the URL, %h for the host, %u for the user name):

"User name for %h: " OR "User name for %h (%U): "

"Password for %u@%h: " OR "Password for %u@%h (%U): "

with some way to switch between the two styles?

Ted
