From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 19:33:40 +0200
Message-ID: <9B05AC3D-F791-4489-B523-C1392E480191@lrde.epita.fr>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr> <7v8x90sp25.fsf@assigned-by-dhcp.cox.net> <20070728083536.540e471d.seanlkml@sympatico.ca> <7vodhwptba.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--969093318"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 19:34:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEqBI-0005gi-7u
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 19:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbXG1Rdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 13:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbXG1Rdz
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 13:33:55 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:36772 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792AbXG1Rdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 13:33:54 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IEqAo-00067r-Fg; Sat, 28 Jul 2007 19:33:50 +0200
In-Reply-To: <7vodhwptba.fsf@assigned-by-dhcp.cox.net>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54042>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--969093318
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Jul 28, 2007, at 3:10 PM, Junio C Hamano wrote:

> Sean <seanlkml@sympatico.ca> writes:
>
>>> Do you mean by "my commits in Git" a commit you created with git
>>> in your git repository?
>>
>> Tested this here (rc3.24.g83b3d) and can confirm the reported  
>> problem.
>> After making a commit in git and then running "git svn rebase" to
>> receive updates from the svn repo, the rebased commit has a borked
>> description (multi-lined commit message appears all on one line).
>
> In short, your original commit log message is broken.
>
> The recommended convention for commit messages is to start it
> with a single line that describes what it does, followed by a
> blank line (i.e. the first paragraph consists of a single line),
> followed by a longer explanation of why the change brought by
> the commit is a good thing.
>

Hi people,
thanks for the quick and complete replies.  As a user, I do not  
expect git-rebase to change my commit message.  I was aware of this  
convention in Git, but it looks like it's more than just a  
convention.  This trap should either be fixed (your patch works for  
me) or it should be clearly stated in the documentation that commit  
messages must really be formatted according to the convention.

Personally I expected Git to keep the 1st line of my commit message  
as the "short version" (which is what git log and the like do ATM)  
and although I don't leave a blank line between the 1st line and the  
rest of the message, the 1st line is always the sentence that can be  
used as a short version of the commit message.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-5--969093318
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGq330wwE67wC8PUkRAn+NAKDYvvAIo9TeJOhuJBCpe5NoMWvvtgCfTZc8
JdR/Q3HHanwR7wWAv1Qjui0=
=bhC/
-----END PGP SIGNATURE-----

--Apple-Mail-5--969093318--
