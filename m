From: Jed Brown <jed@59A2.org>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 14:24:25 -0500
Message-ID: <87zjpzg592.fsf@mcs.anl.gov>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com> <vpqbo2guff7.fsf@anie.imag.fr> <xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com> <87hac7hmrb.fsf@mcs.anl.gov> <xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 21:24:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ42i-0006HM-6O
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 21:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab3JWTY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 15:24:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34254 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab3JWTY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 15:24:27 -0400
Received: by mail-ie0-f174.google.com with SMTP id qd12so2079077ieb.19
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=c277FScPKBG0FXiU+WnKfaE0iX9dVhuSVbNkM3whDsg=;
        b=SP0zo9BwRk2tHytyy0AC6KlxqjY+jJXV87lpjkUzZ3QEtnwiWgaWJJMJuAPMl25gyV
         NI7WIgAYd6EdOkS+U8fvFfw8ijk8rT5IOR0zxjrcZAsXMAp3Ol/6jG/rhrwLgeyYQMWb
         k0TPVoQL9A1gYoMVHfAzfvJBAC8RBz5GGIC1E0dMi7v/G279ureja9w2qWzYuEyJuHKE
         rt7Eekt40DXVNhjlEwIjOoDJITV2U6/FRVtf8BOxcICnIG4Cys8g6fUBS3eNkCzpcifG
         yCBTEwHe61XO22T0yP4vAiOmafOYoWI/H+dEyvOWKQRgSM1gEFjIpn7EnpEmfbMU53ar
         w+vw==
X-Received: by 10.50.67.105 with SMTP id m9mr1671378igt.34.1382556267143;
        Wed, 23 Oct 2013 12:24:27 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPSA id o11sm8387935igi.1.2013.10.23.12.24.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2013 12:24:26 -0700 (PDT)
In-Reply-To: <xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.16+100~g18ee1e2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236549>

--=-=-=
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jed Brown <jed@59A2.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>> I suspect that it would be too late for 2.0 we want to do sometime
>>> early next year, though.
>>
>> How would you manage transition from the current behavior?  Warning
>> people to explicitly use "." or ":/" during some interim period sounds
>> worse than just switching the default behavior.
>
> "How would I"?
>
> You're asking that question only because you omitted too much from
> the quote ;-)

I meant that if the proposed migration plan were to be "just change it
and people will learn" (because anything more gradual would actually be
worse for users) then is it really too late for Git-2.0?

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaCJpAAoJEM+2iNHeMalNfKYP/RB7z/GKrxbHOqP5kSyQsrmU
9XOiAAliVffg5BAQ6gm4/ZgmfxkQH6kULsM52dBIhMST1gAESZQFo72rddYeEej9
8qS7saIluEwL+SJDhUUUXEgorwnQW3S5OPasWdRXKhMSN0wv0iyEJptEla6mrhTy
FPf0z5FStELxolW+hed86ilFfaFdcZwI0HfnmaaigmlLkpsVHrUsnYkPSXPpd0Is
vh/Wlnk/aXf/0Yrex6S/gPo+hXNATFYHxpAiiG60jHv6RNRUBejgd9cFiwLWY68N
0PI834XU54n59wsFjmvQDgGPoOT52ubNy4jntEk7pvISKMKkLEG6xygF3wrQRNaL
zPyIw/AxjxkjAZeevpzJFbF0alNJqB51CCXeltxzEo6xR6bWENSgdpabHV7Eg/K4
dFCScX6sZXLchLAQk30RL2KZF0JA0iq4YPOjDVDZwVQZCq+BD0PVk4TH171ZjX69
ZToc5P064mn6Ys122qkehcxEgW7vI4vRJQqwJLuZqCyj/Yl4IZboYmRXxbG+MvI2
W3mRAkTpg31DZZu6VyPvK/u/VJVTIDwwgvNzZ40PnA3quNUikqe4pQBEaT848egr
DsSf0mbEpIkD0bODW75LGiB7A93+QUuDAf1OSiy7188FgCsAzrinHP6D1sFseNCq
9qgudjU/Fy9/hHvr2+fJ
=/9oQ
-----END PGP SIGNATURE-----
--=-=-=--
