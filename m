From: THILLOSEN Andreas <thillosen@free.fr>
Subject: Re: Git: Having trouble merging two repositories by interweaving
 their histories
Date: Tue, 10 Sep 2013 02:19:46 +0200
Message-ID: <522E65A2.3060401@free.fr>
References: <522E3D12.4090004@free.fr> <87fvtdbnna.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 02:20:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJBgW-0002lx-2A
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 02:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab3IJAT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 20:19:56 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:49142 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744Ab3IJATz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 20:19:55 -0400
Received: from [192.168.1.100] (unknown [88.178.152.236])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DB3598223C;
	Tue, 10 Sep 2013 02:19:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130901 Thunderbird/17.0.8
In-Reply-To: <87fvtdbnna.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234403>

Le 09/10/13 01:06, Andreas Schwab a =E9crit :
> THILLOSEN Andreas <thillosen@free.fr> writes:
>=20
>> It implies "interweaving" their histories, so that I can get a "stat=
e"
>> of both RepA and RepB around a same time period of time.
>=20
> This is only possible by rewriting every commit to point to a new tre=
e
> containing the combined trees of the two repositories.  To get a
> meaningful result this requires that both repositories have a complet=
ely
> linear history.
>=20
> Andreas.
>=20

Thanks for your answer...

I searched a little more around the web, and found some trick called
"grafting repositories".
But examples were all of the same kind: They supposed that all commits
in RepA were done before commits in RepB. For instance:

http://stackoverflow.com/questions/2428137/how-to-rebase-one-git-reposi=
tory-onto-another-one

This is not my case, because I had work done in parallel in both
repositories.
So I'm not really sure that "grafting" could help in my particular case=
=2E..

To make the graft permanent, they use git filter-branch, which rewrites
history (all SHA1s are changed etc.)... but as long as dates could be
kept, it would not annoy me that much.

I also found a script called git-stitch-repo in CPAN... I have not yet
tested it, but it is reported that it only works on repositories with
linear history (no merges):
http://search.cpan.org/~book/Git-FastExport-0.09/script/git-stitch-repo

This is also not my case: Merges have been done regularly on my two
repositories...

There is also this tool: CombineRepo... no idea how reliable it is, or
what limitations it entails:
https://github.com/geppo12/GitCombineRepo

So... if I understand correctly, there will be no real practical way to
merge my two repositories, in order to get an interweaving history? (no=
t
criticizing, I only want to know where I am heading now!)

Greetings,

Andreas THILLOSEN.
