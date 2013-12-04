From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 0/3] Show extra branch refs in gitweb
Date: Wed, 04 Dec 2013 14:44:57 +0100
Message-ID: <1386164697.2173.16.camel@localhost.localdomain>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 14:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoClH-000863-5y
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494Ab3LDNpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 08:45:01 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:60743 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462Ab3LDNpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:45:00 -0500
Received: by mail-ea0-f169.google.com with SMTP id l9so10841114eaj.0
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=1sF7Dps+SoVkK0zT3ZtJ5qgg3eFxb+PV+lV5A3F0u0g=;
        b=Us9QV+4/XMOuQTa3PTwesZ53tZF4kTQ6WR1EZwxrk0LuGFicIecKCPm44dRbng7DbZ
         q2aGoFKupRHcPymGv7R31GJSaB3GDSk0idSZPD4/a4WoyFtleMvjCm0oH+2jeLPcuVOW
         7u1Xo4N9zmqnW8BYrAxga4SNBZskPZ/CS5eGso/3Vl521Cn4ZG4/SKszIBCG1bUwy0x5
         b9Lv6lGzRNJuAh7GIY+q4rfxASj8u35zEjKjpRYJTg7SsP3Eayl4314CmKbNOkxCoE0d
         tPRdVl5pNUpPV9m+U3bUpsLJUpHfHx0P+ZQzDDQ3eseFwZfaL9Zox53X2Fz/Pe5OQWe6
         F8YQ==
X-Gm-Message-State: ALoCoQkiLnBEO60DEzck1Me/Z6cadvQ52TVMDkMgDhiWQd/fOJ4dHqhF+m4wuVRLq3BUlTZ3bun6
X-Received: by 10.14.88.5 with SMTP id z5mr4118200eee.101.1386164699335;
        Wed, 04 Dec 2013 05:44:59 -0800 (PST)
Received: from [192.168.1.100] (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id v7sm77319976eel.2.2013.12.04.05.44.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 05:44:58 -0800 (PST)
In-Reply-To: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238783>

On Tue, 2013-12-03 at 15:56 +0100, Krzesimir Nowak wrote:
> First patch just splits some code to a function, second patch adds th=
e
> extra-branch-refs feature and third one adds some visual
> differentation of branches from non-standard ref directories.
>=20
> Krzesimir Nowak (3):
>   gitweb: Move check-ref-format code into separate function
>   gitweb: Add a feature for adding more branch refs
>   gitweb: Denote non-heads, non-remotes branches.
>=20
>  Documentation/gitweb.conf.txt |  27 ++++++++++
>  gitweb/gitweb.perl            | 120 ++++++++++++++++++++++++++++++++=
+++-------
>  2 files changed, 129 insertions(+), 18 deletions(-)
>=20

New version of patches are in "Show extra branch refs in gitweb v6"
thread.

Cheers,
--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
