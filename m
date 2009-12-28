From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 20:12:50 +0800
Message-ID: <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org>
	 <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?B?TOluYe9jIEh1YXJk?= <lenaic@lhuard.fr.eu.org>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Mon Dec 28 13:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPET4-0008QJ-9v
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 13:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbZL1MMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 07:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbZL1MMv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 07:12:51 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:33854 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZL1MMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 07:12:51 -0500
Received: by iwn1 with SMTP id 1so7235293iwn.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WP+fqTX5234wS+AFONC7XXV0hxCtIoplP1AE97MMaxE=;
        b=lCcg4pYjmdTnNljyhQLIx9KFZiKaxygEGoO73m4z5KMEpIVIkp18J9iG0uVTRE8zMG
         KmHcVmJsx1vGFcAybQpqWcOndaUf6O5BqRdXAcMS4t6mgDbXZtiITn6fZUm7asuW7jcp
         BS4lStBGw9V2FHivlQCmkSWkr5B/+P4ZRuRv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UafJLjewq0I/7IxE8/pN6iHGbrmUB262aDwlGzYgVXIuTSE3SAy2KI55AsOXPVZfXW
         7lyZPhBV5JJ2TbKEcba3l6YHfIvG0vty3x7ZlyLaFjsc7QVVaZIgVdI04jZgVZ0CIuw9
         rgBnmHkKv5q7HEqbZBPccCGnPHNbtFoHS12Hg=
Received: by 10.231.170.136 with SMTP id d8mr395176ibz.17.1262002370240; Mon, 
	28 Dec 2009 04:12:50 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135737>

Hi,

On Mon, Dec 28, 2009 at 8:09 PM, Martin Storsj=C3=B6 <martin@martin.st>=
 wrote:
> Hi L=C3=A9na=C4=8Fc,
>
> On Mon, 28 Dec 2009, L=C3=A9na=C4=8Fc Huard wrote:
>
>> The attached patch makes git configure libcurl to negotiate the most=
 suitable
>> HTTP authentication method.
>> Thanks to that patch, I manage to clone and fetch my git repository =
hosted on
>> my web server requesting an authentication through the =C2=AB Digest=
 =C2=A0=C2=BB method.
>
> Something similar has already been queued for inclusion, and is avail=
able
> in the branch 'next', in commit b8ac923010484908d8426cb8ded5ad7e8c21a=
7f6.
> The patch available there requires you to set http.authAny for the li=
bcurl
> option to be enabled.

=2E..or setting the environment variable GIT_HTTP_AUTH_ANY.

(by the way, Martin was referring to setting http.authAny in your git
configuration.)

--=20
Cheers,
Ray Chuan
