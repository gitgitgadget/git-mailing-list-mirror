From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 06:29:58 +0100
Message-ID: <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <20071105234049.GA31277@genesis.frugalware.org> <3abd05a90711052016s615cd66cy5a5f932900d89143@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-25--876050153"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 06:30:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpH13-0004Fx-RN
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 06:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbXKFFaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 00:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbXKFFaG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 00:30:06 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38463 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbXKFFaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 00:30:04 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IpH0k-0003PL-OT; Tue, 06 Nov 2007 06:30:02 +0100
In-Reply-To: <3abd05a90711052016s615cd66cy5a5f932900d89143@mail.gmail.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63627>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-25--876050153
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 6, 2007, at 5:16 AM, Aghiles wrote:

> Hello,
>
>> who will run git stash clear? :)
>
> Yes you are right. By the way, in the context of merging into a
> dirty tree, "git stash clear" seems to be a dangerous command:
> there is a risk of loosing all your changes without a question
> asked!
>
> I know unix is a harsh world but ...

Be *very* careful, because it's worse than that.  If you run, say,  
`git stash clean', instead of `clear' (that's the sort of typo that  
quickly slips through), then it will stash all your changes in a new  
stash named "clean".  Once you realize you made a typo, you will most  
probably correct it and run `git stash clear' but...   Oops, you just  
wiped your changes that were in the "clean" stash.
That happened to me and other people I know, so now I'm utterly  
cautious when I start a command with "git stash".

As far as I remember, a patch was proposed to change this mis- 
behavior of "git stash" (one could argue that it's a PEBCAK issue,  
but I really think this command is *way* too dangerous) but I don't  
think it's been accepted at this time.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-25--876050153
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHL/vWwwE67wC8PUkRAt0xAJ0UEaqIEgb2iLCV/hOlhqTzG0UQugCdG4pb
Tr0WfCy0iTKJzSys9kgILLc=
=twWM
-----END PGP SIGNATURE-----

--Apple-Mail-25--876050153--
