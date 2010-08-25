From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Wed, 25 Aug 2010 13:27:19 -0400
Message-ID: <20100825172718.GC4925@inocybe.localdomain>
References: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
 <20100825041440.GH11619@burratino>
 <AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com>
 <20100825062403.GA15858@burratino>
 <AANLkTimebn+p9dcUWQiUPT8WwC-tuPpTM8M+ptq4Q9uc@mail.gmail.com>
 <loom.20100825T095907-907@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="/zsoNCA59QYBHZ5b"
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Wed Aug 25 19:27:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoJl8-00087D-Az
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 19:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab0HYR13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 13:27:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0HYR11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 13:27:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2DC2D0733;
	Wed, 25 Aug 2010 13:27:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=Yl29qQzfKp7lr0yFC0lo7tTMsnE=; b=DgnCji+
	fvS9XyC0oiNjjk8Rg63e0mO/1pswbVWlJk+YFHMjaL1xLpnSv7qtye20yoSjmSyt
	Z2ApyUT8ckM2wV8vz9nNWngigfcSx3vwBCwXpkHUHuFha4VKjAACQO63r+p5cYPr
	1ZCTxpk+gbXgS6G6pCTnIvv3uQzZK+Z2C3GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=L/ZolzwDa5DrgI7BpDlnA3d/Sy4T8bf0E
	qw563U07HTsgadJlJ/JpQsi2iY9MZqN+7xCtkdBVsQcc9mFUoPvNWb1eYQvCpWdi
	gJxU26gT3wTvgtpoTOxNSbLOWR18CWj3XUxtuMZ2C3XctHf3Sni+4Ig7Bbmm2/HL
	RDspXUnicA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC048D0731;
	Wed, 25 Aug 2010 13:27:22 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FC18D072D; Wed, 25 Aug
 2010 13:27:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20100825T095907-907@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 05694344-B06E-11DF-9C4E-030CEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154449>


--/zsoNCA59QYBHZ5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marcus Comstedt wrote:
> Todd A. Jacobs <tjacobs <at> si2services.com> writes:
>
>> Fair enough. Thank you for taking the time to explain further. I guess
>> I still don't understand how both the patch and the tag are both on
>> the master branch:
>>
>>     $ git branch --contains v1.7.2.2
>>     * master
>>
>>     $ git branch --contains 35039ce
>>     * master
>
> The commit tagged with v1.7.2.2 is on the master branch because
> it was merged there.  The tag was not cut from the master branch
> but from the maint branch.  You are fooled by git branch here because
> you display only your local branches, and you don't have a local
> maint branch.  Add -r to the command, and you will see the commits
> are in multiple branches at origin.
>
> I'm afraid the git command line tools are rather unhelpful in these
> cases (it's hard to find the answer if you don't already know it),
> but gitk allows you to see it quite nicely.  Run "gitk origin/master",
> and search for 35039ce.  You'll see the commit being made on a topic
> branch, which is merged into master (the leftmost track) on 2010-08-18.
> You can also clearly see v1.7.2.2 being cut from maint (the track
> immediately to the right of master) on 2010-08-20, shortly after which
> maint is merged into master (c11969), which is why master "contains"
> 8c67c3, which is what you're really looking for when you say
> "--contains v1.7.2.2".

In cases like this I find tag --contains handy:

    $ git tag --contains 35039ce

Returns nothing, as no tag has 35039ce.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A word to the wise ain't necessary -- it's the stupid ones who need
the advice.
    -- Bill Cosby


--/zsoNCA59QYBHZ5b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJMdVJmJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj9ZkH/1xWuaM5ie6ZM/tOQpjG6uRpjm1zizdn+HYP
s77AkzAhu7ASUrA4xbztKIxN8XfbMtaxOOgoscPVGAdVpdT+RF5hmM4ElwIvcsg4
MSHqrqFO55CsXyu1kSE380uo5GwvJSCKHmSGBcNiqixt5c/05keaGVni94vo8Z82
3YUVIVq8mRVc5Z+t2b3jeh1A3mvlWs7+Y21ElOPV8Zz2E4FR8wZHIhNda5Shqd4h
7Q1ZSltljxRNB1+LgXmUUVooBolXD2PCumPWQqDZ2VRpM3j/I3P70xlkZye1rqOd
+YOqfMQlUSptkkw06rOwl7jFclsEfOnQY7XCx/HmGcbPasFDRNQ=
=D9tb
-----END PGP SIGNATURE-----

--/zsoNCA59QYBHZ5b--
