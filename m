From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Fri, 1 Jun 2012 08:56:01 -0500
Message-ID: <B0BB0BD8-EFB5-4A3C-A6F7-00A1C7DE0509@spotinfluence.com>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> <7vehq18c82.fsf@alter.siamese.dyndns.org> <20120531011911.GC5488@sigill.intra.peff.net> <7v62bc97w1.fsf@alter.siamese.dyndns.org> <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> <7vtxyw6ypx.fsf@alter.siamese.dyndns.org> <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com> <7vd35k6w0i.fsf@alter.siamese.dyndns.org> <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com> <20120601093039.GD32340@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_8C4CB875-8E68-42C0-94CA-1A04B23C07BC"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 15:56:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaSKp-000208-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 15:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759929Ab2FAN4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 09:56:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35382 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab2FAN4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 09:56:05 -0400
Received: by yhmm54 with SMTP id m54so1617610yhm.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 06:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer:x-gm-message-state;
        bh=49Pe6W2brI38rkEqPxfbeAgRrh9fN/RxyfbCr4duHwE=;
        b=k9A4eLOWAHcLLxf8wJ9kmpmnhsnON8PGaGhz2NX2zJ3OXbfusr1pAXv93tTeU15RO+
         DKeDCY/ItzPsCxGhpm5jEWHxgJFBUghhbLzYA0E99n/+mD4RKvE0Cgzd/6mEWBq+WNt3
         qfeaCOEGmiNK+zPDtviULRlmJ3enQdPAd2ilc5F/s6s/Zem/Fp0mzLouvLgNVS50/mmm
         n65JEom7eaEqrPo+ZN1s6QjZG/XeJIfwiKmrKG6c0eIRp9DwP2QCoPumG+Oxwz8XpPfC
         6RFwTOZpM+dVPLXwXvXqJ1//Jbq8VIcuLjPReh1/cbEtFenN2MHWZ6sttt34RRxSijSx
         1E3g==
Received: by 10.50.106.136 with SMTP id gu8mr1603677igb.23.1338558964071;
        Fri, 01 Jun 2012 06:56:04 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id wh8sm2915765igb.11.2012.06.01.06.56.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jun 2012 06:56:02 -0700 (PDT)
In-Reply-To: <20120601093039.GD32340@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQkzXOJ73yi0B2lP7QHa5F6tymSAL6UkN0ZsSWGxG/tgYgQJjTnv9d7GP+Qsg/KXr/RkYhpl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198989>


--Apple-Mail=_8C4CB875-8E68-42C0-94CA-1A04B23C07BC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I did show that sed was broken and have provided a minimal, reproducible =
test.

I have reported it to the sed maintainers and they are working on it.

A message or comment in the code that seds not properly handling utf8 =
characters have been shown to be the cause of the problem and that git =
selects sed from the PATH would have been 100% effective in at least one =
case.  I don't know the troubleshooting skills of the other two people =
that bumped into the problem so can't comment.  Of the billions of =
people that have not (if it existed) looked at the breadcrumb and =
weren't led astray it's (would have) also been 100% effective.  Can you =
in turn posit any reasonable way that get_author_ident_from_commit would =
improperly build author-script short of a bad sed?  I guess you could =
pull out transient or systematic disk error.

You do, in fact, have several solutions.  I won't reiterate since they =
are in the thread earlier.  You also have in many cases the valid =
concern that the solutions would not be backwards compatible.  And yes, =
this sed will get fixed but what then?  The next person that gets a sed =
they don't expect earlier in their PATH will have to go through the same =
steps.

I do appreciate the assistance that led to the solution to my problem.  =
Thanks for maintaining and making available such a great piece of =
software.

Regards,
  -ljr
---
Lanny Ripple
lanny@spotinfluence.com


On Jun 1, 2012, at 4:30 AM, Jeff King wrote:

> [Please don't top-post.]
>=20
> On Thu, May 31, 2012 at 02:21:16PM -0500, Lanny Ripple wrote:
>=20
>>>> Perhaps the error message in git-am could be modified to indicate
>>>> sed is a suspect?.  E.g.,
>> [...]
>>> Hrm, that does not sound an attractive way going forward.
>> [...]
>> You have three recent instances where people have bumped into this
>> with sed.  (And yes on reporting it to the packaging project.)  It
>> seems to me leaving a breadcrumb so that folks can figure out what's
>> going on without having to bother the list would be a win for
>> everyone.
>=20
> But you have to keep in mind all of the people who will be led down =
the
> wrong path by your breadcrumb when the failure is caused by a
> _different_ problem. What is the probability that it is helpful versus
> not helpful?  If you are going to give advice that sed might be =
broken,
> you should at least test to see if it is broken and report it.
>=20
> But really, I'd rather just see the broken sed fixed. Where would the
> breadcrumb lead people at this point, anyway? We don't actually have a
> solution besides "uninstall this other, crappy sed". Has the sed bug
> actually been fixed?
>=20
> -Peff


--Apple-Mail=_8C4CB875-8E68-42C0-94CA-1A04B23C07BC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/IyfEACgkQ+owW65SoXfiqKwD8Ci/K60cVp9UNhEaaXLb8M7DL
tdfv0abVXjWGea1o44kBANN4dUqHzzXPQKYTtww9BRVs00JiBSF+csQBCFsjX6db
=aagw
-----END PGP SIGNATURE-----

--Apple-Mail=_8C4CB875-8E68-42C0-94CA-1A04B23C07BC--
