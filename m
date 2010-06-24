From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: on pulling/cloning git notes
Date: Thu, 24 Jun 2010 15:27:48 +0200
Message-ID: <AANLkTimImotT2F2JGSZnUsjD-dGk7s_eBx2j815FTcAG@mail.gmail.com>
References: <AANLkTilDMVU6b7SwHx0Bztu1rTCubiIPTuDDX6pJBcHx@mail.gmail.com>
	<4C2329E5.8050904@drmicha.warpmail.net>
	<AANLkTilGS6t29J4NQMgseZY9WD1kAPCr9oFeQt1RaWjP@mail.gmail.com>
	<4C235ABE.9050504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 15:28:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORmTF-0001Dd-Oj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 15:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab0FXN1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 09:27:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36865 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab0FXN1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 09:27:51 -0400
Received: by fxm3 with SMTP id 3so383164fxm.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oI/j/RpzA0woSAAUkSm1aTs6TrUnZjbIFWxANIEfqTs=;
        b=obXOdnDw9DM7DSpV423PBI0ldrrnfC7UxNIPulzknsvpqX5IqNsaE8oP5W8oJVRTli
         OktvDZGVurfXU/SBEqxcgh0NfsJjT6fagvV/MQFFjIvt337MzVENFUW7OtD3C4OBYH+t
         gXhofwfK5ihz66IoYiqsj+AMQEkxIPA6WzJQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tVc9kvvWPys98qfG3jdzGVyAe+xp62AeeJeo1m5JnjESsFTGZfJ/t8xpkldZP97SKk
         e09AYi5stHh8OgXZaULG9dhpTW4Hodu6HDaQsACE8eWkkakryV59RcGoky03dCW9H6wr
         6VHgPqEGz2/Os3TiSSbmSSsrJr4RLQblp1mog=
Received: by 10.103.50.13 with SMTP id c13mr3136716muk.63.1277386068944; Thu, 
	24 Jun 2010 06:27:48 -0700 (PDT)
Received: by 10.103.138.8 with HTTP; Thu, 24 Jun 2010 06:27:48 -0700 (PDT)
In-Reply-To: <4C235ABE.9050504@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149593>

On Thu, Jun 24, 2010 at 3:16 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Christian MICHON venit, vidit, dixit 24.06.2010 14:25:
>> On Thu, Jun 24, 2010 at 11:48 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> As you can see from the default "fetch" line above, "refs/heads" ar=
e
>>> fetched by default (when cloning, fetching etc.), but nothing else
>>> (well, besides some tags). You can set up an additional fetch refsp=
ec to
>>> get the notes also.
>>
>> I'm actually doing a fresh clone elsewhere, using 'git clone --mirro=
r
>> gitolite:daat'.
>
> You didn't say "--mirror" before ;)

yes I did... "When trying to to a 'git clone --mirror' from that same
gitolite"...

>
>>
>> I was expecting to grab everything from the remote refs, as in this
>> case my .git/config will look like this:
>> [remote "origin"]
>> =A0 =A0 =A0 =A0 fetch =3D +refs/*:refs/*
>> =A0 =A0 =A0 =A0 mirror =3D true
>> =A0 =A0 =A0 =A0 url =3D gitolite:daat
>
> Hmmh. I have notes in the standard "refs/notes/commits", push them in=
to
> that same ref on the remote side (using an additional push refspec).
> When I "clone --mirror" that I do get them back in "refs/notes/commit=
s"
> in the (bare) mirror repo.
>
>> [remote "origin"]
>> =A0 =A0 =A0 =A0 fetch =3D +refs/heads/*:refs/notes/*
>> =A0 =A0 =A0 =A0 mirror =3D true
>> =A0 =A0 =A0 =A0 url =3D gitolite:daat
>>
>> Thanks for the hint, Michael!
>>
>
> I'm glad it helped though I don't know why...
>
> Did you push the notes into head refs?

yes apparently I did. I thought it did help, I must have pushed the
wrong way originally.

I'll fix that. Actually --mirror works fine and I'm actually getting
the commit linked to the notes.

thanks for double checking.

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
