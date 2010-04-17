From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Sat, 17 Apr 2010 15:32:28 -0700 (PDT)
Message-ID: <m3iq7pemnw.fsf@localhost.localdomain>
References: <cover.1271432034.git.grubba@grubba.org>
	<874ojbqnry.fsf@jondo.cante.net> <86ljcnclvu.fsf@red.stonehenge.com>
	<87eiid6fjc.fsf@jondo.cante.net> <86eiidan59.fsf@red.stonehenge.com>
	<n2kfabb9a1e1004171507r3f51d18bq3ff60831370f9b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 00:32:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3GZF-0004t1-5g
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 00:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab0DQWcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 18:32:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58619 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447Ab0DQWca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 18:32:30 -0400
Received: by wyb39 with SMTP id 39so1828348wyb.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Ju11WGetD/G77ZTaum4B3knRhAzXOLP2ZekZu0QJ7nA=;
        b=piEpZmzkDy3/04HOcm5d3rhhl83mx7lYj933fMh5OLxUTNLSBs/Y6x28+15VMaV/MO
         HJNZFcmQ2+3ajV5kH0cbsR6ZZoN6m/XCdF8gY/plTGkbQprzD8Euvjj34V4AO5vmveg0
         SUF8JSg7bm1ZIBuzlCHL4DQEmfzv13i0pv6NY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=fI682N/Fh6TiypIhkMYZwmAIqIWdxbyb+M1dDmqeU4n9Fpp/Q3f2+ZY6fNJUnAmaFr
         z6uKuA6ovDsbJVf+QUtF3eICJFxGQWzZHSp6jSnWM+pa5AB3VQS+9+YN1uHI06ZVp4MM
         DD2GqdDKXThZAnLaUhRsZzZQCIrrWeQeZvNHY=
Received: by 10.216.160.213 with SMTP id u63mr4333339wek.128.1271543549482;
        Sat, 17 Apr 2010 15:32:29 -0700 (PDT)
Received: from localhost.localdomain (abvc197.neoplus.adsl.tpnet.pl [83.8.200.197])
        by mx.google.com with ESMTPS id z34sm33766667wbv.14.2010.04.17.15.32.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 15:32:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3HMVsxT005931;
	Sun, 18 Apr 2010 00:32:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3HMVWjv005926;
	Sun, 18 Apr 2010 00:31:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <n2kfabb9a1e1004171507r3f51d18bq3ff60831370f9b10@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145187>

Sverre Rabbelier <srabbelier@gmail.com> writes:
> On Sat, Apr 17, 2010 at 21:34, Randal L. Schwartz <merlyn@stonehenge.=
com> wrote:

> > Yes, once it's already *in* the program. =A0But I bet you had to *l=
ook
> > them up* to add them.
>=20
> Yes, but once they're there nobody has to look them up. It's moving
> the problem from having to look up what it means on _and_ write, to
> just write.

We use idiomatic C, e.g.

  if (!strcmp(option, "warn")) {

not

  if (strcmp(option, "warn") =3D=3D 0) {


We use idiomatic Perl, e.g.

  %hash =3D map { $_ =3D> 1 } @list;

not

  use English qw(-no_match_vars);

  %hash =3D map { $ARG =3D> 1 } @list;

--=20
Jakub Narebski
Poland
ShadeHawk on #git
