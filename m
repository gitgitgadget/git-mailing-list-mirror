From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 11:55:39 -0700 (PDT)
Message-ID: <m3r5yukv6g.fsf@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	<20090512182828.GA26812@dpotapov.dyndns.org>
	<46a038f90905121140n61902c61qc3cd41100efee4ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3x8q-0001KB-Fd
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 20:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbZELSzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 14:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZELSzl
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 14:55:41 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53712 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZELSzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 14:55:40 -0400
Received: by fxm2 with SMTP id 2so166146fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=OxwG4pfqgkD4xQJfQ5R6U84Ma8Xl0ChLSDsvrMZwuHI=;
        b=BATtmkuqQhv/fP3V8Pnmc58zqIXFBjij9p3XjtbUikV43QKjPXljxHw7190oGA6lIF
         xi7HZXFmbDCrWFK1aWzP7Xf2IlNykaNED46Ns5/lUgJR2poV2LZgKp3rT/Xy1tih5Gm7
         ypIP5roW/EQupp7GmZ1YhRNPebxMpvziJpQEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Khi7ylvbK9lD2Jo1RJ6pV744ALBMj84YFtqfWm2mVqfhyv4n4xVxkU1CDp3007WERw
         iKjeI6k0SuQW6R4uCJoXaGtK3KHKIZCIANEsIY/GqMH3Y/xfjBNCrLAlGK7CLBBDqskR
         BUzV8l9l5pzOitbJrKWc+4leXoNSlhFV4GzUk=
Received: by 10.103.176.20 with SMTP id d20mr16130mup.27.1242154540030;
        Tue, 12 May 2009 11:55:40 -0700 (PDT)
Received: from localhost.localdomain (abvp65.neoplus.adsl.tpnet.pl [83.8.213.65])
        by mx.google.com with ESMTPS id u9sm589683muf.7.2009.05.12.11.55.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 11:55:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4CItcT5000320;
	Tue, 12 May 2009 20:55:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4CIta4s000317;
	Tue, 12 May 2009 20:55:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <46a038f90905121140n61902c61qc3cd41100efee4ae@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118944>

Martin Langhoff <martin.langhoff@gmail.com> writes:
> On Tue, May 12, 2009 at 8:28 PM, Dmitry Potapov <dpotapov@gmail.com> =
wrote:

> > 2. If you really want to be cross-platform portable, you should not=
 use
> > =A0 any characters in filenames outside of [A-Za-z0-9._-] (i.e. Por=
table
> > =A0 Filename Character Set)
> > =A0 http://www.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap=
03.html#tag_03_276
>=20
> Would it make sense to have warnings at 'git add' time about
>=20
>  - filenames outside of that charset (as the strictest mode, perhaps
> even default)
>  - filenames that have a potential conflict wrt case-sensitivity
>  - filenames that have potential conflict in the same tree due to
> utf-8 encoding vagaries
>=20
> MHO is that a strict "start your project portable from day one" mode
> is best as a default. But I'd be happy with any default, actually ;-)

Somebody asked for a pre-add hook in the past; it would be good place
to put such check.  But in meantime you can do it using pre-commit
hook instead, isn't it?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
