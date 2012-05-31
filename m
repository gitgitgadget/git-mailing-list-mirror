From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 14:21:16 -0500
Message-ID: <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> <7vehq18c82.fsf@alter.siamese.dyndns.org> <20120531011911.GC5488@sigill.intra.peff.net> <7v62bc97w1.fsf@alter.siamese.dyndns.org> <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> <7vtxyw6ypx.fsf@alter.siamese.dyndns.org> <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com> <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_B13D22AA-B143-47DF-A12F-BE4373E4EFDF"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 21:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaAw2-0003r5-4x
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 21:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080Ab2EaTVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 15:21:21 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:38943 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab2EaTVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 15:21:21 -0400
Received: by gglu4 with SMTP id u4so1142031ggl.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 12:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer:x-gm-message-state;
        bh=vgi2162rgcd8wqJxwknE8zyWZe07T8D7msqLd1VtnQ4=;
        b=J4rn790CQ6znmjFv8TzzRdD+uypmVZjZaQMJUDgWc/fYw0Y4PJHEXZpOM1Ox3vqZeW
         RynkAaQ1du/InFMhV3z9Ctr3go733Cqy2R7A775ANYVRDkpVjzLrPJseNni27V8qpxGU
         oEC5hzCdW5Fy+D/8Z+WY4PD+CcwznB8JFMZQBdkolzCRDlFAJnhaGB8OO/2JAI0WNLs/
         aYiJ1Ew7X5lNROGWGZX90Mcuc7mvPRb5Iv9xQ/hX8MX2zDQ0Trwe1IBRORuKFqCzoqZ4
         /cg732LhYW2AUNNvbpc3LEsMFdKzwspZZO5DvZiUZ8pO3Ggad6tDYaKTJSuElfin60pB
         K9Tg==
Received: by 10.60.20.70 with SMTP id l6mr3239666oee.38.1338492080167;
        Thu, 31 May 2012 12:21:20 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id qb7sm3128724obc.13.2012.05.31.12.21.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 12:21:19 -0700 (PDT)
In-Reply-To: <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQnr746JiyxsyYFxop8DjavPu5SYRtDMII/Rx/FKZRf5JI47kAz56MLvMbXq+MHIUiUn9R0M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198940>


--Apple-Mail=_B13D22AA-B143-47DF-A12F-BE4373E4EFDF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

You have three recent instances where people have bumped into this with =
sed.  (And yes on reporting it to the packaging project.)  It seems to =
me leaving a breadcrumb so that folks can figure out what's going on =
without having to bother the list would be a win for everyone.  And yes, =
if any and all uses of POSIX tools started showing up with some =
frequency then I think the same breadcrumb win/win logic would apply.

  Enjoy,
  -ljr
---
Lanny Ripple
lanny@spotinfluence.com


On May 31, 2012, at 1:33 PM, Junio C Hamano wrote:

> Lanny Ripple <lanny@spotinfluence.com> writes:
>=20
>> Perhaps the error message in git-am could be modified to indicate
>> sed is a suspect?.  E.g.,
>>=20
>> lanny(master);<work/IdeaProjects/Piper> git rebase master rl-clean292
>> First, rewinding head to replay your work on top of it...
>> /sw/lib/git-core/git-am: line 692: Leblond: command not found
>> Patch does not have a valid e-mail address.  (Used /sw/bin/sed found =
on PATH).
>>                                              ^  ^  ^  ^  ^  ^  ^  ^  =
^  ^  ^
>> lanny((ae6c220...)|REBASE);<work/IdeaProjects/Piper>=20
>=20
> Hrm, that does not sound an attractive way going forward.
>=20
> Do we have to suspect any and all uses of POSIX tools, just in case
> somebody installs a broken implementation from random places?  Is
> sed the only thing that is possibly broken?
>=20
> By the way, have you filed a bug report to whoever supplied your =
/sw/bin/sed?
>=20
>=20


--Apple-Mail=_B13D22AA-B143-47DF-A12F-BE4373E4EFDF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/HxK0ACgkQ+owW65SoXfiTlwEAp47Jc4zk8HLZNWmiLMyBgixj
0oMfV0IA+5t+RUXMO0sA/0WYqBdX7Ww1nrpScYw/gr7YCFw0ceNSygO9Tv2lbO51
=GDj2
-----END PGP SIGNATURE-----

--Apple-Mail=_B13D22AA-B143-47DF-A12F-BE4373E4EFDF--
