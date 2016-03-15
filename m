From: Your friend <pickfire@riseup.net>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to
 ~/.config/git"
Date: Tue, 15 Mar 2016 10:14:15 +0800
Message-ID: <c74296a0db1cac9daf5da00756ab0313@riseup.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
 <xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 03:14:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afeV4-000266-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 03:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414AbcCOCOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 22:14:18 -0400
Received: from mx1.riseup.net ([198.252.153.129]:58000 "EHLO mx1.riseup.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933090AbcCOCOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 22:14:16 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id 036031A24D5
	for <git@vger.kernel.org>; Tue, 15 Mar 2016 02:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1458008056; bh=eJjA8X3WhUaMIEZqTYUlbsS/lyofzqkBGKo5pH5SNak=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=j6tF7GA1hNvmifMzb+i3BAwwxRUrv5zcIyWvGjdRd0UdQQfFVkPARK7ZUAQo6MpOt
	 JXPIJeCJWgcVssF7CHnpw3NzPglh3lzOgU+Zc7/LhBhHvjfInq+ShzddG2C1vBK3C7
	 WiXmyQi7EZh1GSCZmH4MlW1N2T/TsP5coTO3vZtU=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: pickfire)
	with ESMTPSA id DC5621C0063
In-Reply-To: <CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.99 at mx1.riseup.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288829>

On 15/03/2016 09:32, =E6=83=A0=E8=BD=B6=E7=BE=A4 wrote:
>> You sound like you think it is better to check the location of the
>> existing socket,
>=20
> Yes, for the purpose of compatibility, it's the only choice, as I can=
=20
> see.
>=20
> To sum up, I'd like to implement:
>=20
> 1. <path> is configured by --socket, then put it here.
> 2. else if `~/.git-credential-cache` exists, put the socket under her=
e.
> 3. else, put the socket under
> `$XDG_RUNTIME_DIR/git/credential-cache.sock`,
> if $XDG_RUNTIME_DIR does not exist, default to
> `/tmp/git-$UID/credential-cache.sock`.
>=20
> As a result, new user will use xdg-compatible path while old user wil=
l=20
> not
> be surprised.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi, I am Ivan Tham =E8=B0=AD=E4=BF=8A=E6=B5=A9, I know a bit of C and m=
ore in python, I am
currently taking foundation in a Asia Pacific University.

I would really like to work on this microproject for gsoc too but too=20
bad
=E6=83=A0=E8=BD=B6=E7=BE=A4 had taken it. :(

I think it should be in ~/$XDG_CACHE_HOME/git/credential or
~/.cache/git/credential instead of ~/.config/git/credential.
