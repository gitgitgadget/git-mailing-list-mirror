From: John Bito <jwbito@gmail.com>
Subject: Re: git diff looping?
Date: Mon, 15 Jun 2009 19:53:22 -0700
Message-ID: <3ae83b000906151953h570df143kd4d2c51b8dc2ac66@mail.gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
	 <20090616024457.GA9513@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 05:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGOvF-0006Rs-Pw
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 05:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbZFPDBI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 23:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbZFPDBG
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 23:01:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:14733 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZFPDBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 23:01:05 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2816367ywb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dv+z9OwfgyTeSSytBVIv9rB6L8gS81NhuG3QpZWxYcE=;
        b=Pgkr1bCD/AQRqPxwaE/TS+lZEp/MUpxOuUyyBicK78I5P7rClLPe4L7kJFO10RmZOM
         8hqlOuWDLR8bq6GkjGEW6ReS7FSWK1aqjLJ1ai2WHSW9Ml2VqRQiCLgYcSvPI1vir72u
         URbxdWt32x9g9yQ0DAegy6m+/FsiSiaBoaXII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A9sRXDNZSD02w3YmbJ2lh8U1T7YdCx9Uw74C72taJAW+1NDttSaOA9eZS6Ey0p1EHs
         XMtxFpLgofmKoNqdR+6f2LiF4rATqql3iTi2QnYUsJtWbqumrEU5Av4mMxHb+HIvb9C0
         HIs1PpJblC1bunWd/AP2bPP/glTU+fgNQiXDA=
Received: by 10.100.211.3 with SMTP id j3mr9913564ang.19.1245120802611; Mon, 
	15 Jun 2009 19:53:22 -0700 (PDT)
In-Reply-To: <20090616024457.GA9513@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121652>

Thanks, Jeff!

I didn't mean to suggest there was a problem in the (origin)
repository.  I was wondering if anyone could recommend an approach to
finding out what went wrong.  I can certainly clone a fresh repo and
apply my changes there.  I'd just like to have some idea of what went
wrong.

~John

On Mon, Jun 15, 2009 at 7:44 PM, Jeff Epler<jepler@unpythonic.net> wrot=
e:
> It's apples and oranges, but I had no problem on
> =A0 =A0$ git --version
> =A0 =A0git version 1.5.4.3
> =A0 =A0$ uname -a
> =A0 =A0Linux platte 2.6.24-24-generic #1 SMP Wed Apr 15 15:11:35 UTC =
2009 x86_64 GNU/Linux
> or
> =A0 =A0$ /usr/src/git/git --version
> =A0 =A0git version 1.6.3.2.31.g7af0
>
> =A0 =A0$ git clone git://repo.or.cz/egit.git
> =A0 =A0$ cd egit
> =A0 =A0$ git diff v0.4.0 | wc -l
> =A0 =A047943
>
> =A0 =A0$ /usr/src/git/git diff v0.4.0 | wc -l
> =A0 =A047943
>
> Jeff
>
