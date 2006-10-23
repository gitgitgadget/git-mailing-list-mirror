From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Checking for "diff.color." should come before "diff.color"
Date: Mon, 23 Oct 2006 22:03:40 +0100
Message-ID: <200610232203.40510.andyparkins@gmail.com>
References: <200610232051.17396.andyparkins@gmail.com> <7vk62qydvu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2598344.glPyTUzYdk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 23 23:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6zy-0007EA-Vy
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWJWVGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWJWVGP
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:06:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:57717 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751703AbWJWVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 17:06:15 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1510501uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 14:06:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=SLI6w2Bhj9dStON9PGUrGu1GdTku3o7Z6W7+OvWfrZxoEk9nPVbQnD8IU0yXakOJE9FTtlmIxk/LLke7b5C6cgj3tVrTk36Q6omB6P1zda4ZZjAuHIo+7ikjsLzt8HHDQ0LApGcsrf6bqTb8aiYtl7HXijsXkFTGINCVaEB/lpM=
Received: by 10.78.160.2 with SMTP id i2mr8082440hue;
        Mon, 23 Oct 2006 14:06:13 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 30sm24759hue.2006.10.23.14.06.12;
        Mon, 23 Oct 2006 14:06:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vk62qydvu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29881>

--nextPart2598344.glPyTUzYdk
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2006, October 23 21:29, Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> > In git_diff_ui_config() the strncmp() for "diff.color" would have match=
ed
> > for "diff.color.", so "diff.color." configs would never be processed.
>
> A test case that demonstrates the breakage without the patch
> would be nice. Could you come up with a two-patch series that
> is:

No need.  Jeff King already caught the fact that my patch is unnecessary.  =
I=20
withdraw it.

Sorry to keep bothering you all with these non-entity patches.  I really am=
=20
only trying to help :-)


Andy

=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart2598344.glPyTUzYdk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPS4swQJ9gE9xL20RAr1UAKCYFtIclsuKmchKapBxgZFFtqRedACfeYhT
n97EktiZF9REbdnHOxiiX0A=
=bLUE
-----END PGP SIGNATURE-----

--nextPart2598344.glPyTUzYdk--
