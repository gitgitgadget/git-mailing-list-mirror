From: walter harms <wharms@bfs.de>
Subject: Re: help: bisect single file from repos
Date: Wed, 09 Dec 2009 13:12:52 +0100
Message-ID: <4B1F9444.9030000@bfs.de>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net>	<4B1D27B6.7010900@bfs.de>	<200912080917.17220.chriscool@tuxfamily.org>	<4B1E5796.2090201@bfs.de> <7vein5e2lc.fsf@alter.siamese.dyndns.org>	<20091209012855.GA3208@neumann>	<20091209172737.6117@nanako3.lavabit.com> <20091209094532.GS18686@neumann>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 13:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NILPv-0004hN-1S
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 13:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbZLIMND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 07:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755387AbZLIMND
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 07:13:03 -0500
Received: from mx.sz.bfs.de ([194.94.69.70]:54646 "EHLO mx.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755383AbZLIMNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 07:13:01 -0500
Received: from mail.sz.bfs.de (mail.sz.bfs.de [192.168.0.1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx.sz.bfs.de (BfS Mail Relay SZ) with ESMTP
	id 6F7F4288E64; Wed,  9 Dec 2009 13:13:07 +0100 (CET)
Received: from localhost (unknown [192.168.2.47])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id 2B580E3908;
	Wed,  9 Dec 2009 13:13:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bfs.de
Received: from mail.sz.bfs.de ([192.168.2.193])
	by localhost (amavis-sz.sz.bfs.de [192.168.2.47]) (amavisd-new, port 10024)
	with ESMTP id FtWDXZtuFB62; Wed,  9 Dec 2009 13:12:55 +0100 (CET)
Received: from dc-slave2-fr.fr.bfs.de (unknown [10.177.18.200])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id DCDACE38ED;
	Wed,  9 Dec 2009 13:12:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 5DEB4DB260;
	Wed,  9 Dec 2009 13:12:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 206E1DB26F;
	Wed,  9 Dec 2009 13:12:53 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at fr.bfs.de
Received: from dc-slave2-fr.fr.bfs.de ([127.0.0.1])
	by localhost (dc-slave2-fr.fr.bfs.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cj2SJxuSn73X; Wed,  9 Dec 2009 13:12:52 +0100 (CET)
Received: from [134.92.181.33] (unknown [134.92.181.33])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 7D021DB260;
	Wed,  9 Dec 2009 13:12:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091209094532.GS18686@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134963>



SZEDER G=E1bor schrieb:
> Hi,
>=20
>=20
> On Wed, Dec 09, 2009 at 05:27:37PM +0900, Nanako Shiraishi wrote:
>> Quoting SZEDER G=E1bor <szeder@ira.uka.de>
>>
>>> [1] - 'git cherry-pick' doc says the following:
>>>
>>>   <commit>
>>>     Commit to cherry-pick. For a more complete list of ways to spel=
l
>>>     commits, see the "SPECIFYING REVISIONS" section in git-rev-pars=
e(1).
>>>
>>> What?  "A _more_ complete list"!?  Well, it's not very hard to be m=
ore
>>> complete than this, there is not a single way described here (;
>=20
>> I agree that "more" shouldn't be in that sentence, and I understand
>> your hesitation to read plumbing manual pages, but I don't think it
>> is a sane solution to the issue to repeat how to name a commit in
>> manual pages for every single command to bloat the two line
>> description you quoted into a half-page paragraph.  Even within that
>> two lines, the real information that should be in the manual for
>> cherry-pick is only three words "Commit to cherry-pick" and the rest
>> is to help people who don't know.
>=20
> I agree, that's why I proposed "a _section_ about specifying these
> commits" in the more relevant part of my previous email you did not
> quote.
>=20
> The description of the "<commit>" option would remain almost the same=
,
> but it will now refer to a dedicated section about specifying commits
> below, but still in the same manpage.  This new dedicated section
> would contain the list of three, five, N most common ways to specify =
a
> commit, avoiding the bloatage in the options section.  And for those
> who really want to dig deep, this dedicated section will refer to 'gi=
t
> rev-parse' for the complete list.
>=20
> And this would not be the first time we document something in many
> places, think of '--pretty' and diff options, for example.
>=20
>=20

It would be no problem when you have the description multiple times.
Important is that they use the same words for the same things
and add examples. Most people that use git have a fair idea what they
want but not how to do it. git is new an you can not assume that
even basic principles are known to the general (programmer) community.
So you need to make extra effort to explain it all over again.

re,
 wh
