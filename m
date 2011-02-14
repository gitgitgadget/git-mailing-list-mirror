From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Mercurial over Git no success
Date: Tue, 15 Feb 2011 10:19:59 +1100
Message-ID: <AANLkTimi8MU3VYug6orouHS7GmBJ-Pf27_zj_KO0Sj6c@mail.gmail.com>
References: <1297717305.19327@davidwbrown.name>
	<AANLkTinro_sSV52aZATAPFAm1SLRq8i4Q1kA2W+wqqH3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Manuel Doninger <manuel.doninger@googlemail.com>
To: david@davidwbrown.name
X-From: git-owner@vger.kernel.org Tue Feb 15 00:20:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp7iC-0004Am-Hx
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab1BNXUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 18:20:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49586 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab1BNXUB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 18:20:01 -0500
Received: by wwa36 with SMTP id 36so5489655wwa.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 15:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GwQtkcxIMqkq84BMPSkQ7gIKojQVqgI8kOd385ublCY=;
        b=pYj6z9Ruj2lG13U993ejaFzJEUP6HGalmua937jyTmKBInWzhGdVZw35OgEYuAUhCQ
         PUYeynqX1aDVSNJN7leeatwC1N4n+eieBrO0GIS6PfrMjdB/z4MkKYlS4Jj1WHZ4Wr9o
         LHY97gaFw6JRM2R3nSmHnf7bjx/nFw9r2Hu2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UEOQ+JZbT1ghXhcJzeHzEsfgjJUwFP2faUMA8Q8PaaJPJxJ6iUmDFhOW5DKENns0uq
         whM9nLWQKaKY5LqV2YIMbEKQP2J1nwMdFZckdY7eGKIZNojcUar1JDOPdWNWJOZrtN52
         zZT97T01pghzyZTFqR42cf9KNbYBg5Z7QjGKE=
Received: by 10.227.128.70 with SMTP id j6mr3128275wbs.16.1297725599765; Mon,
 14 Feb 2011 15:19:59 -0800 (PST)
Received: by 10.227.60.14 with HTTP; Mon, 14 Feb 2011 15:19:59 -0800 (PST)
In-Reply-To: <AANLkTinro_sSV52aZATAPFAm1SLRq8i4Q1kA2W+wqqH3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166794>

=46rom the INSTALL file:

 - Git is reasonably self-sufficient, but does depend on a few external
   programs and libraries.  Git can be used without most of them by add=
ing
   the approriate "NO_<LIBRARY>=3DYesPlease" to the make command line o=
r
   config.mak file.

        - "zlib", the compression library. Git won't build without it.

       ...

Per suggestions already made, on ubuntu apt-cache search and apt-cache
get are your friends.

jon.

On Tue, Feb 15, 2011 at 8:50 AM, Manuel Doninger
<manuel.doninger@googlemail.com> wrote:
> According to the Install-section in the Pro Git book, you have to
> install some other libraries. See http://progit.org/book/ch1-4.html
>
> Manuel
>
> On Mon, Feb 14, 2011 at 22:01, =C2=A0<david@davidwbrown.name> wrote:
>> Hello Gitters, long ago when first starting the project I'm currentl=
y running at my company I looked around for a VCS/SCM that would be any=
where better than: CVS/SVN. At first I looked at Git but could not get =
a version to run on my Ubuntu box. So, I had to settle for Hg. Now, tha=
t I'm several months into the web app dev I'm responsible for the hired=
 help has convinced me to switch to Git. Now, I'm back at the same old =
problem I had months ago that forced me to give up on using Git. Unlike=
 a lot of Unix/Linux based software the usual:
>>
>> ./configure
>> make
>> make install
>>
>> Does not work for building Git on my local Ubuntu box (10.10 BTW). S=
ome non-innocuous error condition as follows:
>>
>> cannot find zlib.h
>>
>> Pls advise. David.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
