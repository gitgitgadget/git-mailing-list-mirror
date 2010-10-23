From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: should Documentation/howto/setup-git-server-over-http.txt be marked obsolete?
Date: Sat, 23 Oct 2010 00:24:50 -0700 (PDT)
Message-ID: <m3ocaljrs2.fsf@localhost.localdomain>
References: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
	<7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
	<AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
	<20101022150627.GB9224@burratino>
	<AANLkTimTVviTBfY1Zeebyhufr36U+0w7VYf4f=25FMFi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 09:25:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9YTa-0000XA-Gp
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 09:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0JWHYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 03:24:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46343 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab0JWHYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 03:24:53 -0400
Received: by bwz11 with SMTP id 11so1164290bwz.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 00:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=5AKWlOHUdXD5GH0vuV/oPMmt1Q1Rf0xkpduBu34vrtg=;
        b=I1SdwW/mGSXbQxuKF8zDZIgDGCejet70y3wzidY1+3Vh4+8Svikhn7oMNWNqvSmCHk
         OS+LpNvnc1lbt1gvXtQKfmo5DWGofCrPkM/VeQ7a7WrKI2OplTZJqiMO7ESkP3c9n8Mj
         p4LWBpANIShMImRCVqUTaiBmz8h7fY86EL1GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=nEQQIOZD19sbQCMHFr6hHUcApIQzBZfwqSTiKk+HWS9+NBGhVWwV8krjBR8YhfJePM
         EEI0PRE7QMGqozvXRrxFXoWDdTrXaxf6B5G6mbNQfce7Dct0WUiKjxz6QhWwfOzZI7Zr
         07DUXeiX88yK6Flsc2t0KNBycncJ7UamcerCs=
Received: by 10.204.113.197 with SMTP id b5mr2090745bkq.151.1287818691444;
        Sat, 23 Oct 2010 00:24:51 -0700 (PDT)
Received: from localhost.localdomain (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id c40sm433986fay.0.2010.10.23.00.24.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 00:24:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9N7OUUQ014093;
	Sat, 23 Oct 2010 09:24:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9N7OE6I014082;
	Sat, 23 Oct 2010 09:24:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimTVviTBfY1Zeebyhufr36U+0w7VYf4f=25FMFi@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159774>

Sitaram Chamarty <sitaramc@gmail.com> writes:
> On Fri, Oct 22, 2010 at 8:36 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Sitaram Chamarty wrote:
>>
>>> I assumed that the new -- much more efficient (correct?) transport
>>> would make the older (dumber) transport obsolete, and I didn't real=
ise
>>> it had any advantages over the new one.
>>
>> FWIW the old transport still has its place. =A0If your web host (e.g=
=2E,
>> an ISP) allows only static content (no CGI), then there is no choice=
=2E
>>
>> Not so relevant for gitolite but still relevant in the world.
>=20
> Also I now realise the new transport requires Apache, so people with
> other web servers probably need it too.

Why do people think that "smart" HTTP transport requires Apache web
server?  If I understand it correctly provided git-http-backend is a
simple CGI script, and requires CGI-capable web server and git
installed on server.  Examples use Apache because probably that is
what author was familiar with.  I don't see the reason why it
shouldn't work e.g. with nginx or IIS...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
