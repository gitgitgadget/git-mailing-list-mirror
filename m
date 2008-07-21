From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git pull versus fetch/merge
Date: Mon, 21 Jul 2008 13:33:52 +0200
Message-ID: <20080721113352.GA21009@atjola.homenet>
References: <488452D6.1060508@keyaccess.nl> <20080721102320.GA19776@atjola.homenet> <48846BC2.4090407@keyaccess.nl> <20080721110900.GA8550@sigill.intra.peff.net> <48847344.5060908@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Mon Jul 21 13:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKtfM-0003Pa-A7
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 13:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYGULd4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2008 07:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbYGULd4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 07:33:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:38616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954AbYGULdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 07:33:55 -0400
Received: (qmail invoked by alias); 21 Jul 2008 11:33:53 -0000
Received: from i577B81BB.versanet.de (EHLO atjola.local) [87.123.129.187]
  by mail.gmx.net (mp010) with SMTP; 21 Jul 2008 13:33:53 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18PtttkNH8PZjP5cJvZRz+h2Aa1Q363Cl/8gDb8Qn
	4ManCzsKcNQjr7
Content-Disposition: inline
In-Reply-To: <48847344.5060908@keyaccess.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89350>

On 2008.07.21 13:30:12 +0200, Rene Herman wrote:
> On 21-07-08 13:09, Jeff King wrote:
>
>> On Mon, Jul 21, 2008 at 12:58:10PM +0200, Rene Herman wrote:
>>
>>> Thank you. Also due to a reply on the ALSA list by Mark brown I now=
=20
>>> get  this. Yes, the remote was rebased while I had it setup as a=20
>>> remote here  it seems; only recently have it under this name, so I=20
>>> didn't think that  was the case. After a "git remote rm tiwai, git=20
>>> remote add tiwai <url>"  things work fine again as it fetched a=20
>>> completely new branch.
>>
>> Note that adding the remote with "git remote add" will add a fetchsp=
ec
>> line like this:
>>
>> [remote "tiwai"]
>>   fetch =3D +refs/heads/*:+refs/remotes/tiwai/*
>>
>> where the '+' means to force fetching rewound branches instead of
>> rejecting them (this is safe, since you are just overwriting trackin=
g
>> branches, not your local work).
>
> Not here...
>
> rene@7ixe4:~/src/linux/7ixe4$ git remote add tmp =20
> git://git.alsa-project.org/alsa-kernel.git
> rene@7ixe4:~/src/linux/7ixe4$ tail -3 .git/config=20
>
> [remote "tmp"]
> 	url =3D git://git.alsa-project.org/alsa-kernel.git
> 	fetch =3D refs/heads/*:refs/remotes/tmp/*
> rene@7ixe4:~/src/linux/7ixe4$ git --version
> git version 1.5.5

Broken in 1.5.5 and 1.5.5.1, Jeff's fix went into 1.5.5.2. Bad luck ;-)

Bj=F6rn
