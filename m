From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Tue, 14 Jun 2011 11:37:13 +0200
Message-ID: <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:38:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWQ58-0008O6-AE
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 11:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab1FNJil convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 05:38:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45116 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1FNJik convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 05:38:40 -0400
Received: by fxm17 with SMTP id 17so3460121fxm.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/9R69se0dyyCjuFrUyTtzcpvFFhSkCi5YsKjf0snN/k=;
        b=aajfpjKmCkUqNkJGMKtD9mBnAxXAJSDxuwhmcn33ACus+o+6TTFxLyzVkjKWTZj4Bp
         jVBGk6BXUlhGGb0QrjFLmk2ynlNP3OekLwDI6C2ZHZ14BJrO2tjn2OsPz0V6Fe/gHL9x
         Hio/WyYpvcQnCUKjetRtXDO9vidytadOvXuRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CiTsK2AoRjq7eKYZZ9PlwLDj4Hfm8x9ArsjNo55R5/gm9ibVrXu5t9u/mRx+xoLpTA
         ujB54BaH0g6g/KAjcEgJu5UIUcvEf1vQf7n9ftGDCqC2hTNCWdCsMAjJWiaqd/byZdgn
         xAadGpwmCEOwZLf3bYFMdu5LYQh+guAhmCy9I=
Received: by 10.223.73.139 with SMTP id q11mr57072faj.56.1308044233787; Tue,
 14 Jun 2011 02:37:13 -0700 (PDT)
Received: by 10.223.117.65 with HTTP; Tue, 14 Jun 2011 02:37:13 -0700 (PDT)
In-Reply-To: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175754>

On Tue, Jun 14, 2011 at 07:57, Ramkumar Ramachandra <artagnon@gmail.com=
> wrote:
> Hi Dimitris et al,
>
> [+CC: Git List; for wider exposure]
> [+CC: Jonathan Nieder; he has been involved with translations in the =
past]
> [+CC: Junio C Hamano; for authoritative policy advice]
>
> I think it's a good idea to use a system like Transifex to manage
> translations for git.git, so that we can attract a large number of
> non-technical translators. =C2=A0Further, I think it's a good time to=
 start
> off on this now, since many of the i18n bits from =C3=86var's series =
are in
> 'master'. =C2=A0So, I'm looking to start off a discussion about how t=
o
> adapt a translation system into our current patch workflow. =C2=A0Dim=
itris
> is the lead developer of Transifex, and can help with the details.

Turns out I have two E-Mails related to this in my inbox. Below
follows the reply I sent to the other one in private mail, but applies
here too:

"""
Sorry, I didn't have time to look at this at the time. I think it's
really interesting, having translations be easier to manage is
definitely something we want so that mortals can contribute
translations to git.

I hadn't followed up on this because git.git still doesn't have
strings marked up for translation. We have the C bits of that, but the
patch series for the shellscripts is still in flight.

After that I was going to submit some more patches to add the initial
po/*.po files, after which I think considering having a web interface
like this would make sense.

Here's a couple of things though:

 * I don't want people to *have* to use any one interface.

 As far as I'm concerned the canonical way to submit translations is
 just to check out git.git's master branch, run "make pot", and then
 submit a patch for a PO file to the list.

 Of course we can *also* support doing that through a web UI, the web
 UI is after all just a fancy way of replacing your $EDITOR. But I
 don't think we should be tied to any one UI. I.e. people should be
 able to take git.pot and edit it everywhere, and a web UI like
 Transifex can't assume that it e.g. won't have to resolve conflicts
 because something changed upstream.

 * Any way of editing the translations will have to comply with git's
  normal patch submission process.

  When you normally submit a patch to Git you have to write a
  sensible commit message for it, change one logical thing at a time,
  and you have to agree to the contributor's agreement by adding a
  Signed-off-by to your Git commit.

  I think this will probably clash head-on with how any web
  translation UI with its own user accounts, no way to enter commit
  messages etc. will work.
"""
