From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: latest stg/git commandline completions code
Date: Thu, 10 Nov 2005 17:57:34 +1100
Message-ID: <CDEAA4E3-54FE-4825-BFCF-DCE34DBD138A@hawaga.org.uk>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk> <20051109222338.GK16061@pasky.or.cz>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Blaisorblade <blaisorblade@yahoo.it>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 07:59:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea6O0-0001ME-Oz
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 07:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVKJG6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 Nov 2005 01:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVKJG6N
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 01:58:13 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:18445 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751101AbVKJG6M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 01:58:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jAA6vaLR021198;
	Thu, 10 Nov 2005 06:57:54 GMT
In-Reply-To: <20051109222338.GK16061@pasky.or.cz>
To: Petr Baudis <pasky@suse.cz>,
	Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11467>

On 10 Nov 2005, at 09:23, Petr Baudis wrote:






> Besides, it would be probably best to just autogenerate the
> auto-completion code - the usage information in Cogito is supposed =20
> to be
> 100% consistent and correct, so it should be a reliable source for =20
> that.
>
>
>
>

Maybe reliable and consistent but I think that info would need a bit =20
of augmentation to use for specifying autocompletion - for example, =20
in the case of:

 > Usage: cg-branch-add BRANCH_NAME LOCATION

BRANCH_NAME should *not* exist so it doesn't make sense to =20
autocomplete from the branch list, but in the case of:

 > Usage: cg-fetch [-f] [-v] [BRANCH_NAME]

BRANCH_NAME *must* exist so it makes sense to autocomplete from the =20
branch list.

The amount of augmentation is probably not too much -  probably =20
sufficient  to specify for each parameter a completion-source(s) =20
(heads, branches, filenames, blah) that doesn't get displayed in --=20
help. But this is more information to maintain and get out of date...

I wonder if Nikolai has had thoughts about that for zsh completion?
Hopefully if anything gets added, it would be useful for both zsh and =20
bash

(I confess to having pretty much no idea how zsh completion works...)

Ben

--=20
Ben =E3=83=99=E3=83=B3 =D0=91=D1=8D=D0=BD
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS numbers at above URL.
