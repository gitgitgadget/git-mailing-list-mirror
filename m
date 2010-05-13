From: Chris Lamb <lamby@debian.org>
Subject: Re: [PATCH] git-rebase--interactive: Handle commit messages that
 end in backslash
Date: Thu, 13 May 2010 13:58:07 +0100
Message-ID: <20100513135807.548594f9@bobcat.office>
References: <20100513133955.05493175@bobcat.office>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/KdPbrfED6G5xltmxfXGi0jo"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 14:58:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCXzX-0006hb-MT
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 14:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470Ab0EMM6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 08:58:12 -0400
Received: from new1.smtp.messagingengine.com ([66.111.4.221]:45488 "EHLO
	new1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758333Ab0EMM6L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 08:58:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1A99EF5F2A
	for <git@vger.kernel.org>; Thu, 13 May 2010 08:58:11 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 13 May 2010 08:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:subject:message-id:in-reply-to:references:mime-version:content-type; s=smtpout; bh=UMFK1Jqb2HKusSRFDIG4GIzAy9A=; b=Nhl/cmuuOJjtkqvygJ+iqniqsbM89BvIzDsYMt8zrqsqJuSTCpUiiltULO/r4d1tVnBIdBuu1kuv+1FNEW0JpK1SmffpBTNISEy98AouWgk9nVXRzmlLLm7JlTwXhi0AAoAagKrE7fJLl+7qh5fL3OwMo4GpUJ+Er+qwXJow0aM=
X-Sasl-enc: WXy9niSDQlY8g20S5VYmjrTqD7cAy8wx4EKkKkRssJlD 1273755490
Received: from bobcat.office (87-194-70-110.bethere.co.uk [87.194.70.110])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6C4634ACC4D
	for <git@vger.kernel.org>; Thu, 13 May 2010 08:58:10 -0400 (EDT)
In-Reply-To: <20100513133955.05493175@bobcat.office>
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.2; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147001>

--Sig_/KdPbrfED6G5xltmxfXGi0jo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Chris Lamb wrote:
=20
> This patch fixes three issues with handling commits that end in a
> backslash character ("\"), two of which had potential for silent data
> "loss".

Disregard the patch; it has some funky side-effect which breaks ONTO
parsing and I don't know why.

(The problem still exists though.)


Regards,

--=20
      ,''`.
     : :'  :     Chris Lamb
     `. `'`      lamby@debian.org
       `-

--Sig_/KdPbrfED6G5xltmxfXGi0jo
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvr918ACgkQ5/8uW2NPmiCbuACgqNs/ND+5x1bmRa3AlH5V180Y
HhkAn22w9i1Pq6cVfO4aL5W8AfVd/LVg
=X+CK
-----END PGP SIGNATURE-----

--Sig_/KdPbrfED6G5xltmxfXGi0jo--
