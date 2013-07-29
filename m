From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] Remove deprecated OPTION_BOOLEAN
Date: Mon, 29 Jul 2013 20:04:21 +0200
Message-ID: <51F6AEA5.7040504@googlemail.com>
References: <1375112281-3935-1-git-send-email-stefanbeller@googlemail.com> <7vbo5l1c5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig75EBB009387139EE1F8FD6C7"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 20:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rnp-0002Ld-UM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 20:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab3G2SEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 14:04:09 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57069 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267Ab3G2SEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 14:04:08 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so3049658wgh.5
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=Bqi6DQgDi8ebJJtV6gq65U78A4A45yyT941F4aedoGc=;
        b=swSis/MtwkCa4CmbZumdZkuXR7yzrKfbW6z7w2QmiCA27S0b/mBRI1zHZyMyKWT4j3
         if+oUwZNQ2Bab2//+ohJKAsg+CHJE6TOwBIkQfSvIqBjUBlTp4AhyCLbbKEQjFO848NS
         mqO7EDlqcZTCI7vlBNkOCE2CX23Piwmu9bq0qW2q8SJNzFOfn8ylIdWfN/G7Syz7yG9g
         jhPVN6tdtvCMYsc2Rb2sYInQeZZeikzywOPxkvtYcAra7cxdw55+jKEN41P0anKQJ7Co
         IVqdsb/3O0G/uUkUqYsi6yCUwTo1AYfBGzThrT5LaacjxZmeyZhwcD0oT/86Ev0YU35r
         jqZQ==
X-Received: by 10.194.60.5 with SMTP id d5mr31066586wjr.26.1375121047499;
        Mon, 29 Jul 2013 11:04:07 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id e7sm4303185wiy.4.2013.07.29.11.04.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 11:04:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vbo5l1c5a.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231312>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75EBB009387139EE1F8FD6C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/29/2013 07:58 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> So recently Junio released -rc0. Is that a reason to not
>> send out patches, which do not do bugfixes? So the following=20
>> commit for example doesn't fix a bug nor does it add a feature.
>> Is it fine to send out such kind of commits during the -rc
>> times or better wait for the next development cycle?
>=20
> It would be a good idea to show it to others as a preview of what to
> come even in a pre-release freeze period, so that people holding
> real patches in the affected area can work with you to avoid
> conflicts.
>=20
> But I would not expect them to be applied to the upcoming release,
> nor even 'next'---this largely depends on the maintainer workload.
>=20
> Thanks.
>=20

Thanks for the answer. Let me rephrase the question a little bit:
Would you rather encourage to send it out now, or later?
("I'll apply it ot a local branch and eventually remember it next
release to merge." or "I'll forget about such stuff, you need to
resend it anyway.")

Regarding possible merge conflicts I'd be happy to resolve them
and not add a burden to people doing features.

Stefan



--------------enig75EBB009387139EE1F8FD6C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR9q6lAAoJEJQCPTzLflhqBcwQAKL0vvnj+FXvoyq5C2jVkOht
qPSgtAW9Su0/gcLyj7QPkgSIlyeKlBKq+SaqU1Fl5+FhMg9lwO3TZb54N6bINDBw
TXfnQ0a846edOx8QVbzWLZ3QimScajm0yHW+9aGkUBSWieAHw4INnt9AO0c5+mKo
Ze9lcTHVDsRiQScgcFvqo0vcQfaKrHKHCGtFpIiXGLPkXfd5n6dvubifLfUzIbcX
HxuQHeG9+5Am8MMA+aZodnc/NanGHso8wKvdZ/RcfZl8EKZ9STz4/6UKni9AqCaJ
3I2e/g/yJHb7KcoHtVzGKq/b6a8oxobpRMnEoRXmSkiCeWjRDH9FPyJdMs1NgbH8
3r5BU98jxyQJlBty22WZykXaP3O41JF7UvkiCjgHZNPgMDanfLgNo0dEC1T9+FIB
bTeu0SrESnsdgcVyvgK73f5+FjxszyHHCvsmrSMVkRSEmA6uahTKNHthsPnkCCym
lnLjm5Da+vS1CIvC5VQMiLhnIRvT0VBNcjbg53s3IsbjoocHSPihnuIkY2jY7krE
mXJ/gJGBXPOWEeGHpDq/5pJldVvdGZeqeqVNa9+IsSoGryCH23Uj1DVeAjhyBhmQ
PaQFJOkVaQ2hgyh3+5059rA7DRRuMIs8GOA1MBaLlvnSVdJ6YdhYofyA+vxyIj+K
hWlIDPDzcxnhg8vB3Cud
=mFpv
-----END PGP SIGNATURE-----

--------------enig75EBB009387139EE1F8FD6C7--
