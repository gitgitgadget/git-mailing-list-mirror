From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [bug] git cannot find "git pull"?
Date: Thu, 11 Jun 2009 21:17:38 -0400
Message-ID: <20090612011737.GB5076@inocybe.localdomain>
References: <4A319CE1.6040201@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 03:17:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEvOw-0007Ec-Po
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 03:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbZFLBRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 21:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbZFLBRl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 21:17:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbZFLBRk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 21:17:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 692FEBA819;
	Thu, 11 Jun 2009 21:17:41 -0400 (EDT)
Received: from inocybe.localdomain (unknown [173.67.155.244]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BC135BA815; Thu,
 11 Jun 2009 21:17:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4A319CE1.6040201@garzik.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: D33E6EE6-56EE-11DE-AB19-97731A10BFE7-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121381>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

Jeff Garzik wrote:
> I just upgraded to Fedora 11 (git-1.6.2.2-1.fc11.x86_64), and see
> the following:
>
>> [jgarzik@viper linux-2.6]$ git pull
>> git: 'pull' is not a git-command. See 'git --help'.
>>
>> Did you mean this?
>> 	shell
>
>
> Bleh...  :)  "git --help" indicates that "git pull" still exists.

Yuck.  I can't reproduce this (and I would hope that if the Fedora
packages have been broken for many weeks that someone would have
noticed and complained loudly before the release...).  Of course, if
there is something horribly wrong with the Fedora packages, I'll try
to get it fixed as quickly as possible.

Do you happen to have any strange PATH set, other non-packaged git
binaries installed, or funky aliases/settings in your git config?
Does the problem occur after an upgrade or clean install?  For all
users?

It is notable that Fedora 11 is the first Fedora release that follows
the git 1.6.x defaults and installs most git binaries outside of PATH.
I don't think that would cause this, and I haven't had any troubles
running these packages for many months, but that's never stopped
really obvious bugs in the past...

(Apologies for the obscenely silly questions.  I'm just hoping they
might help lead to the root cause so we can make sure it's fixed. ;)

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If the triangles were to make a God they would give him three sides.
    -- Montesquieu


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKMaysJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj6EgIAIE89MaASw38Wc34++DuuJGxatAZQRoHaBHk
vH34L0EHtQbreGd3Ph/CuA+rowSMIYwknhgxSkQNzE4nBI8kuyk9VsAiLUIpLgId
IeIHnpNCrQzBaNQQXxBIc/nBz7cUk9T9f7qOCzSbcIMJDigD/WEdtbEJJiBAm6zk
dBk6NV6hof+JKPIKQ7p7cJ/O5uI0wAzK/nmH2wpqm7nm3YyPOGtDbKbcUpKRG1Bb
9CMufREKSsxycRvR7grNgFsnTJvLDUWui5vY5oUIxKbRFpK5W3IeuvVo3tmuMPWq
wBRH2Ua5AseeDESBlNT82ONHyMWxdzdYf43v+t/Cp0diISpHKl0=
=C/L/
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
