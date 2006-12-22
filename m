From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 12:16:55 -0800
Message-ID: <7vejqrznwo.fsf@assigned-by-dhcp.cox.net>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
	<86k60jsvh8.fsf@blue.stonehenge.com>
	<86fyb7sv9f.fsf@blue.stonehenge.com>
	<7vwt4jzrjb.fsf@assigned-by-dhcp.cox.net> <emhdir$he9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 21:17:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxqpA-0001Kn-Eg
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbWLVUQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 15:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbWLVUQ5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:16:57 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35669 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbWLVUQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 15:16:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222201656.QEQD19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 15:16:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1wGD1W00a1kojtg0000000; Fri, 22 Dec 2006 15:16:14 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <emhdir$he9$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	22 Dec 2006 21:04:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35209>

Jakub Narebski <jnareb@gmail.com> writes:

> <opublikowany i wys=C5=82any>
>
> Junio C Hamano wrote:
>
>> Possibilities:
>>=20
>> =C2=A0(1) Forget about that "protection" business. =C2=A0If you do n=
ot
>> =C2=A0 =C2=A0 =C2=A0want mistakes, use 'branch.*.merge' but otherwis=
e we will
>> =C2=A0 =C2=A0 =C2=A0continue to follow the good old "first set of br=
anches"
>> =C2=A0 =C2=A0 =C2=A0rule.
>
> What about marking default branch to merge explicitely using
> "Merge:" in remotes/<repo>, or remote.<name>.merge?

Sorry, how is that an improvement over the current branch.*.merge?
and how would that help not breaking existing setups?
