From: Andreas =?iso-8859-15?q?Kl=F6ckner?= <lists@informa.tiker.net>
Subject: Re: [PATCHv1+eps] git-repack.txt: Clarify implications of -a for dumb protocols
Date: Thu, 4 Jun 2009 09:34:12 -0400
Message-ID: <200906040934.39475.lists@informa.tiker.net>
References: <200906031950.56974.lists@informa.tiker.net> <1244115295-28688-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4428413.9Z9QYlvITr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 15:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCDCH-00008F-5t
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 15:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbZFDNlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 09:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZFDNlH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 09:41:07 -0400
Received: from outbound-mail-20.bluehost.com ([69.89.20.235]:50108 "HELO
	outbound-mail-20.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751542AbZFDNlH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 09:41:07 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2009 09:41:06 EDT
Received: (qmail 1169 invoked by uid 0); 4 Jun 2009 13:34:28 -0000
Received: from unknown (HELO host304.hostmonster.com) (74.220.215.104)
  by outboundproxy1.bluehost.com with SMTP; 4 Jun 2009 13:34:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=informa.tiker.net;
	h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:X-Identified-User;
	b=hZw+D6i36MVwdmCV7K6MurKegmJ/viYJmOEoK6l1ODhg4Y76UauL7Zq3Uy97WldW0WYh/m93/Rxu/sETuZl9B41J5XYHZPHrYmsCiYKgMsaRRnYjiKGUcxSCNnxs16l5;
Received: from ip68-9-132-118.ri.ri.cox.net ([68.9.132.118] helo=grizzly.localnet)
	by host304.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <lists@informa.tiker.net>)
	id 1MCD5P-0003YE-UG; Thu, 04 Jun 2009 07:34:28 -0600
User-Agent: KMail/1.11.2 (Linux/2.6.30-rc7-686; KDE/4.2.2; i686; ; )
In-Reply-To: <1244115295-28688-1-git-send-email-git@drmicha.warpmail.net>
X-Identified-User: {11749:host304.hostmonster.com:tikernet:tiker.net} {sentby:smtp auth 68.9.132.118 authed with andreas-store+tiker.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120698>

--nextPart4428413.9Z9QYlvITr
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks, that's much better!

Andreas

On Donnerstag 04 Juni 2009, Michael J Gruber wrote:
> The current text makes some users feel uneasy, worrying whether
> '-a' could lead to corrupt repositories. Clarify that '-a'
> may lead to performance issues only for dumb protocols.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Is that clear enough but concise?
>
> Applies to maint.
>
> [Sorry for the resend, I managed to mistype the subject.]
>
>  Documentation/git-repack.txt |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index aaa8852..8af5505 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -32,7 +32,10 @@ OPTIONS
>  	pack everything referenced into a single pack.
>  	Especially useful when packing a repository that is used
>  	for private development and there is no need to worry
> -	about people fetching via dumb protocols from it.  Use
> +	about people fetching via dumb protocols from it.
> +	(Over dumb protocols, one would have to fetch the whole new
> +	pack in order to get any contained object, no matter how
> +	many other objects in that pack exist locally already.) Use
>  	with '-d'.  This will clean up the objects that `git prune`
>  	leaves behind, but `git fsck --full` shows as
>  	dangling.



--nextPart4428413.9Z9QYlvITr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQBKJ81VJZ7T4Hn4+FIRArSzAKCUP0KgIiKJ1BatmGIa2u8yVJCYmwCfYBgW
k5/+JKa6Ju45jVbx7EK/MpU=
=jYjT
-----END PGP SIGNATURE-----

--nextPart4428413.9Z9QYlvITr--
