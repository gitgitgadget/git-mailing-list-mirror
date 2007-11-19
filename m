From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 14:20:09 +0100
Message-ID: <EB96D9F3-D69C-4D46-961C-27885CBC0E52@lrde.epita.fr>
References: <47416F68.9070908@ogersoft.at> <vpq3av25sg0.fsf@bauges.imag.fr> <86k5oez9f5.fsf@lola.quinscape.zz> <vpqzlxa2y2f.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-275361255"
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gerhard.oettl.ml@ogersoft.at
X-From: git-owner@vger.kernel.org Mon Nov 19 14:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6YO-00089C-Ok
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXKSNU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbXKSNU2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:20:28 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38187 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbXKSNU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:20:27 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iu6Y5-0002Kh-4z; Mon, 19 Nov 2007 14:20:25 +0100
In-Reply-To: <vpqzlxa2y2f.fsf@bauges.imag.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65440>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-275361255
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 19, 2007, at 1:56 PM, Matthieu Moy wrote:

> David Kastrup <dak@gnu.org> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>>> To verify I did:
>>>> git-svn clone -s svn://www.ogersoft.at/ogerlit
>>>
>>> I guess the --tags=... and --branches=... options of git-svn can  
>>> help.
>>
>> You are aware of what the "-s" option does?

I personally don't know and I went through the code to see that it's  
an (undocumented) alias for --stdlayout.

> Not in the details. Well, I believe the accurate question (to original
> poster) is: does your svn repository use the standard svn layout
> (tags/, branches/, trunk/)?

I think this is irrelevant to the question he asked.

Now I think that the fact that SVN does "lightweight" copies by  
recording that such modification was in fact an `svn cp' / `svn mv'  
isn't important for git-svn, because the data end up in the Git  
repository which handles copies and moves much much better than SVN  
does.  But here the concerns raised by Gerhard seem to be more  
network-wise, in which case I don't know.  I looked at the code,  
things seem to happen under the hood of Git::SVN::Fetcher but I don't  
see what can be optimized (the code isn't trivial).  Most of the  
access are done through the underlying SVN Perl bindings, so if  
someone knows how to use them better, I think Eric will be eager to  
see the patches :)

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-5-275361255
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHQY2JwwE67wC8PUkRAq+oAKCdo79LWADWWJvlZj6GlvBobNosCQCgqzDe
ynvzTpPCJtNNnI1BoOKwj28=
=jqTb
-----END PGP SIGNATURE-----

--Apple-Mail-5-275361255--
