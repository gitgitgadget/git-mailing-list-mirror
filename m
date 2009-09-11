From: Todd Zullinger <tmz@pobox.com>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 09:33:13 -0400
Message-ID: <20090911133313.GF2582@inocybe.localdomain>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Cc: git@vger.kernel.org
To: james bardin <jbardin@bu.edu>
X-From: git-owner@vger.kernel.org Fri Sep 11 15:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm6Fv-0004LX-71
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 15:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZIKNdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 09:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZIKNdW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 09:33:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbZIKNdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 09:33:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02D3E2EC3E;
	Fri, 11 Sep 2009 09:33:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=tPjVIyc5lTAZDvQCk6vAR7p9nic=; b=gMEa5qM
	LzjciCVKTyzzwPmyyk/M6tt11H9c6oYjHWzdhn3PK6M9ZsQ0IR0+vUg8Ee49bXxg
	5VfAv3HoF27X18ort5N+ZybdQxpTB6NDF+/5IEb3LRdtEgDxMEFLwqeu2X2fJt/d
	36P7EP1hescYLzj0RI7/+yG7ykLckqibvvpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=dGZ49q82iChCAD6R53fwFDVPSkc5cX1dk
	7MWK1b6L+SC8b+HcuwUWN4OfzgnZ61iew0KExVsk7KxGdJ0uZG+CFI5UYXPHMZh6
	ml/uHp+UABXU+Sowa2+aySpKzJzfQ8CYg/BcwkvpoHl82bCuL+vxJ5a963pMSqxN
	Tb2EZft/SY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E606C2EC3D;
	Fri, 11 Sep 2009 09:33:15 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.9.179]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BAFD2EC3C; Fri, 11 Sep
 2009 09:33:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: A90E8030-9ED7-11DE-8C12-A13518FFA523-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128191>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

james bardin wrote:
> I'm making a git rpm for our site, and I'm getting an error with
> bash_completion on RHEL/CentOS 5.

Out of curiosity, have you tried rebuilding the Fedora packages from
rawhide?  They should work on RHEL/CentOS 5 just fine (I use them
myself).

> When outside a repo, any completion causes git to spit out
>   fatal: error processing config file(s)
>
> This is 1.6.4.2 using the contrib bash completion file

I can't reproduce this on either Fedora or CentOS.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A great many people think they are thinking when they are merely
rearranging their prejudices.
    -- William James


--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKqlGTJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjcpkH/jMT9tt5HiuYic6gmyjFCshMcQ8JLbptqqzx
Vzd6KK+w1Y+TTS/LmPScttoStNmsT/D8CJBuW132pYWrH2N0XqWxgjHpuBbIWrUu
vBUaKu8GfGXWNO0x95wZYgvitT/TxKMyqZZtxmgh+C36eXsElYZ+VYBZfpkUj5bh
HyYWx1SHo6T9H+g8zTtmb/2oKBqfify6GpKNbF4dI+6kI6VVpGy0tSvZsdyXW0Ej
PWrSgnKq79Bn4Y8YvV0br/3jjgOnLm7syXu5mneIHh5kkJc5b1ZG+8t3tDRQPIyt
BeczimyLwRmH8YJDKE7gyYQ9H0sELKuu3angwPFhKyIX/mbKkC8=
=Rdqq
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
