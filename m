From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 12:01:41 -0700 (PDT)
Message-ID: <m3k4sfgmjc.fsf@localhost.localdomain>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
	<l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Simon <turner25@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:07:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0g1R-0004zJ-0F
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab0DJTHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 15:07:06 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35950 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0DJTHE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 15:07:04 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2010 15:07:04 EDT
Received: by bwz19 with SMTP id 19so21434bwz.21
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=JivKF7afxvzatH/WUZyGm218T1HjIBN/ZLZ2q6W90UU=;
        b=nphiNANPAXvayF6OZnR14aiVZQJk9TG+GzEjq6MtO7ZIABCvkFsOMxvNG7GQOTzsIi
         CozYywY5qNhrEZi3yM2RShYDea54k9LzUgl2prADovpcYnK2FrJJPSxZvRQr25DylrcD
         lkWDioMJmz/ysoV+b/dKr2dkWnc1D+eS9Z+cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=U05UW3WNvfs2bMq8Vf0DdmG+TfF6YhtBe4uXLRLQUoWbD3ycBijH6AkZyRBtUSOBwN
         2mTp8OemKMz2Xv9z9suqfNaK0f2pVY6C6RkIDcmrAdkabEc8H9j5jP6Mef84yLL3IzZh
         wC8mZ4yPb73ICHZTKooXnZcFZWOR9LngiqBNk=
Received: by 10.204.6.25 with SMTP id 25mr1938451bkx.135.1270926103275;
        Sat, 10 Apr 2010 12:01:43 -0700 (PDT)
Received: from localhost.localdomain (abvp94.neoplus.adsl.tpnet.pl [83.8.213.94])
        by mx.google.com with ESMTPS id s17sm21306071bkd.16.2010.04.10.12.01.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 12:01:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3AJ1CHh023729;
	Sat, 10 Apr 2010 21:01:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3AJ0uum023723;
	Sat, 10 Apr 2010 21:00:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144577>

Simon <turner25@gmail.com> writes:

> > A format properly designed for script parseability should use even =
use
> > whitespace as a field separator.
> >
> > Why?
> >
> > Because if you do that, front ends *will* do field analysis using a
> > naive split-on-whitespace operation. =A0And then...someday...someon=
e
> > will try to run one of these of these on a volume from a system whe=
re
> > filenames contain embedded whitespace. =A0Like Mac OS X or Windows.
>=20
> Why not use an XML output?
> Plain text is easier to parse, but XML may give this extra durability
> you are looking for?

Are out of your f**g mind?  XML, really?  XML might be good choice to
*define* _document_ formats, but is really poor data exchange /
serialization format (being overly verbose, among others).  Also, XML
is not language but meta-language.

I could understand providing JSON format, specified using --json
option.  I think there is some GPLv2 compatibile JSON generating code
in C (MIT licensed code is GPLv2 compatibilie, isn't it?); we can
always borrow compact JSON generation code from GPSD project (if
license allows it) from ESR.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
