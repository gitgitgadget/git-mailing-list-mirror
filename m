From: Alexandre Dulaunoy <a@foo.be>
Subject: Re: Git-Mediawiki : Question about Jeff King's import script
Date: Fri, 27 May 2011 14:45:45 +0200
Message-ID: <BANLkTi=KG5TgxHnKDgf1nt_x5YJ1rGwNww@mail.gmail.com>
References: <BANLkTi=nLZV_QCyKT8LOhzkJYoJD6J4wPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, git@vger.kernel.org,
	"matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Claire Fousse <claire.fousse@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 14:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPwQK-0002ky-T4
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 14:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab1E0Mpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2011 08:45:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42538 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab1E0Mpr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 08:45:47 -0400
Received: by gwaa18 with SMTP id a18so665806gwa.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SGMqtMYMlsyk6/gvjnF5I+QlLRC9mtzt6b7KkAb8Khk=;
        b=dsuhESGBXIBQzrAwOtWf8wLapqcsebgNpg9xnkGROlU9/aP3fW22hcazviy5+hEhib
         1GsMiABZ583FX3H+9ZL0q57TmE2z+ynV3FKEpPQd2UC20FKnc59o7icOw4SzjYi4hNEJ
         n5WUH72lOJdDRY08OnxAq6seKannesOAHnLu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=R2UEWTvWy1Ax21qILQfCnaOfzatFOzPVryWeGokiZQIu1+foKfZqDVKtmikGR3xYz5
         C3HJlO/2z/QJOEmXkN90T4B7qfwf1bTRsMuK8bx4ArrFv9tIhA7UD9LT3gG8fIK1ig5I
         scI1HawjvWenwd6AU4rzl6RE1r6yPvdn7ZDeA=
Received: by 10.146.164.11 with SMTP id m11mr1921775yae.20.1306500345902; Fri,
 27 May 2011 05:45:45 -0700 (PDT)
Received: by 10.147.39.12 with HTTP; Fri, 27 May 2011 05:45:45 -0700 (PDT)
In-Reply-To: <BANLkTi=nLZV_QCyKT8LOhzkJYoJD6J4wPA@mail.gmail.com>
X-Google-Sender-Auth: SatRhdGiewpcGS0IgaR63XRisQw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174614>

On Thu, May 26, 2011 at 5:18 PM, Claire Fousse <claire.fousse@gmail.com=
> wrote:
> Dear Jeff King,
> We are the four students in charge of the Git-Mediawiki project
> proposed by Matthieu Moy.
> In case you skipped our email, here is a link to our last mail with a
> few information about the project
> http://www.spinics.net/lists/git/msg158701.html
> We based our script on what you called a few months ago the "quick an=
d
> dirty perl script" for the import part and have a few questions about
> it.
> First of all, just in case, here is your original script :
> http://article.gmane.org/gmane.comp.version-control.git/167560
>
> It seems like you first used a hashmap for it to be transformed later
> into a flat list / array. What is the reasoning behind this ? Why not
> create an array right away ?
>
> Thanks for the script and for any information you can give us,

In a similar spirit, there is this Ruby script:

https://github.com/singpolyma/git-mediawiki/blob/master/clone.rb

using the Mediawiki API. Quite nifty.

Hope this helps,



--=20
--=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 Alexandre Dulaunoy (adulau) --=
 http://www.foo.be/
--=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 http://www=
=2Efoo.be/cgi-bin/wiki.pl/Diary
--=A0 =A0 =A0 =A0=A0 "Knowledge can create problems, it is not through =
ignorance
--=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 that =
we can solve them" Isaac Asimov
