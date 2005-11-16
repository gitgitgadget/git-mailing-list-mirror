From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: latest stg/git commandline completions code
Date: Wed, 16 Nov 2005 13:35:42 +1000
Message-ID: <6387EBD2-F476-4A43-B764-3D9F2B653483@hawaga.org.uk>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk> <20051109222338.GK16061@pasky.or.cz> <CDEAA4E3-54FE-4825-BFCF-DCE34DBD138A@hawaga.org.uk> <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk> <20051109222338.GK16061@pasky.or.cz> <33CE6BA8-415D-405F-89B3-982811C3A0CF@hawaga.org.uk> <20051110094013.GM30496@pasky.or.cz>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Blaisorblade <blaisorblade@yahoo.it>,
	Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 04:39:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcE7C-0006cK-2c
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVKPDfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 22:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVKPDfz
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:35:55 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:27665 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S965209AbVKPDfz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 22:35:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jAG3ZMCr007284;
	Wed, 16 Nov 2005 03:35:24 GMT
In-Reply-To: <20051110094013.GM30496@pasky.or.cz>
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12001>


>> There are a few small common functions that are used by all the git
>> completions, though.

> Then could you please separate those from the git completion to some
> kind of 'library'?

that's done now.


> When you do
>
>     cat > <tab><tab>
>
> bash happily autocompletes as well. I don't think this is a problem,
> besides it can be useful when you want to use some existing branch =20
> name,
> just slightly modified.

ok, convinced - I changed 'branch' and 'checkout' to complete on new =20
branch name.

http://www.hawaga.org.uk/gitcompletion/git-compl-lib
http://www.hawaga.org.uk/gitcompletion/cg-compl

are the two latest versions of the code (source the -lib then the cg- =20
file)

There is no autogeneration - I'm still playing round. Its just good-=20
old-fashioned manually hard coded.

The git repo that I'm keeping this and the other completion code =20
(stg, git and gitk) in is at http://www.hawaga.org.uk/gitcompletion.git

--=20
Ben =E3=83=99=E3=83=B3 =D0=91=D1=8D=D0=BD
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
