From: Claire Fousse <claire.fousse@ensimag.imag.fr>
Subject: Re: Git-Mediawiki : cloning a set of pages
Date: Thu, 9 Jun 2011 11:06:16 +0200
Message-ID: <BANLkTin3eEJfXfB7aadxue-QMduimvh-tg@mail.gmail.com>
References: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
	<m3lixcdz67.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, srabbelier@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 11:06:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUbCA-0002Ja-Nq
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 11:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab1FIJGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 05:06:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48075 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab1FIJGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 05:06:16 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so646163pwi.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AMGS+n2b6P72D6PKWPqsVlCjPZKPFdmCMYQvQxx12iI=;
        b=KLC0usGC16jXhLzVQW1WSgQQPP/y+gKPJnd8oVJ4GvT9c6jJ7mcC5uj3G+eXvQnfLS
         VK+Xj0d856NR57u2Okh5/TkfVqNYkKQFhuFI9pBV67c+jTOmnByD4hIl8ti2zNRR6/5V
         fOML5j3ilRNnwNdcywK0I6HPLlunm9twndaPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ixPwRAHIxL1E/ped0hK1mvUKOZo+zeGBx2ATu5aGetRJFNf8eMFLiBsyqYud4o4cEe
         Ll+98163tcviY7bijiOBRgvTNQN2rgfKk9l0i7N9NaEhuL5q8TAmKSLefP54it0r7M63
         xz0mi9p38osx784bKeFP5/xh8eqHhUqpcNOek=
Received: by 10.142.218.11 with SMTP id q11mr69839wfg.235.1307610376600; Thu,
 09 Jun 2011 02:06:16 -0700 (PDT)
Received: by 10.142.97.15 with HTTP; Thu, 9 Jun 2011 02:06:16 -0700 (PDT)
In-Reply-To: <m3lixcdz67.fsf@localhost.localdomain>
X-Google-Sender-Auth: -emAszo-H4KQVt3DbP59nmmN_KA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175507>

>> The problem is not the feature in itself but the way you call it.
>> Just so you remember, here is the command =A0to clone the mediawiki =
:
>> git clone mediawiki::http://yourwiki.com
>>
>> As it is now, git clone does not implement a way to define a set of =
pages.
> [...]
>
> Well, what you need to do is to implement API for partial _clone_ (we
> have some SPI for partial checkout, but that is slightly different
> beast).
>
> Currently we have --depth=3D<n> to limit depth of history when clonin=
g,
> and "git remote add -t <branch>" (repeated if necessary) to consider
> only a subset of branches, though unfortunately not in "git clone"
> yet.
>
> Not what you wanted to hear, I guess... :-(


Yes, not really what I wanted to hear, but I had the feeling it would
go this way =3D).

Our school project ends tomorrow, so starting tomorrow we will have les=
s time
to work on this.

We chose to implement the first solution with ##:
git clone mediawiki::http://yourwiki.com##page1##page2..
This way that feature can be used for now, and It will be really
simple to change the
command later.

--=20
Claire Fousse
Grenoble INP - Ensimag
2A T=E9l=E9communication
claire.fousse@ensimag.imag.fr
