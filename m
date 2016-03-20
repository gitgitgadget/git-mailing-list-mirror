From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Update *.po with git.pot?
Date: Sun, 20 Mar 2016 15:29:44 +0800
Message-ID: <CANYiYbFYrMiPWrAA0Fj4Gor4q_vTnCZqufm92dYCGpEJeNTTUA@mail.gmail.com>
References: <CAN0XMO+8PQNXPRgROd9oVqHzTsgLo_k1yP-MLpqK5N44+1ShDQ@mail.gmail.com>
	<alpine.DEB.2.11.1603190750550.16189@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VHLCpW4gTmfDt2MgUXXDom4=?= <vnwildman@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Marco Sousa <marcomsousa@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Paolone <marcopaolone@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Mar 20 08:30:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahXoF-0002WY-AJ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 08:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbcCTH3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 03:29:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35236 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbcCTH3p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 03:29:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id r129so2977287wmr.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=zjkcSTWcdmYxcj6K+iVVxKzYKq50yFF2Mz1ulBJwlPI=;
        b=KjCjyYxP7L5pG6nHlxG1RX7R4fpCeZFEY4A+reQ8aEWYRwbocv+fQr8VM6F1d/tbn3
         LrrV21OSAnAq4GLc+CQpxiSKUMRIJWihHCpct42HOzRGGPIYf2FV6fscGSkqO2aWA81s
         ouA/HjKOoiaU1IG7kf7HpcjeY95IWDQEFHHdiwK+s6JyJ1iTWJ43jwCmDRC8coHpzABo
         IZ3bpcXO8tRpda0ajmNYb/AG2BnNoGVD0ilMUQX+Vv9k1oiFGCjH0dbb93Ukd0NG1GB+
         ivFkf8qeofSIeQ1CiCy+T791oeWbTgDjyFJ82PPJJplSlMAQimTUp7iC8MtfRdpA48yc
         ri4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=zjkcSTWcdmYxcj6K+iVVxKzYKq50yFF2Mz1ulBJwlPI=;
        b=MBWbvaWk2VKOTrASBCytjDssMj12NfYphyB1jqbiJCo7WJYVZO+uqsDKe4v7LImJzk
         ckykB8RsF9XtueiwwONd29MF5lGC+15FzZoAVPQE68i4RwZm4oOdtSJSYqLcfw/4+IO9
         tKZ+3DXslbvnYJmf+HXE1XJveOKhYYavAxKpt6flyQPH21Iq9uXwAjYGg4+moC5SFQjp
         EVvEzX4s0GHQX/zUrT7Eg7gjPuszC0mDvh/14qwC5imZ4miqeFcgV5Y6dNElWmJ1J4BA
         pSjKW/l5IwrKp/b03MQzf5/h+GHQdt9g++6jYQChTiCrqmRWPhqjBLXL8Ia3asTTnH2z
         QddA==
X-Gm-Message-State: AD7BkJJ5g9zADAxLwB/RHZo7bcIJr4Go4LJHfBvyKc4Y31laJ0nC93NIs+/y3xf9v7KixF09eSwTaVm2f5vlJg==
X-Received: by 10.194.227.1 with SMTP id rw1mr23382577wjc.62.1458458984081;
 Sun, 20 Mar 2016 00:29:44 -0700 (PDT)
Received: by 10.194.54.8 with HTTP; Sun, 20 Mar 2016 00:29:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603190750550.16189@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289338>

2016-03-19 14:53 GMT+08:00 Peter Krefting <peter@softwolves.pp.se>:
> Ralf Thielow:
>
>> Since translations are made in one commit, this commit is messed up =
with
>> the msgmerge update so when you look at the commit later, you'll hav=
e a hard
>> time to find out what the actual changes in translations were.
>
>
> You can always use something like podiff
> <http://man.gnu.org.ua/manpage/?1+podiff> to find the actual changes =
in each
> update.

In my worktree, I have defined some attributes and a diff driver, which=
 can
make a clear diff on po/pot files.

=46irst, add these two lines in .git/info/attributes:

        *.po diff=3Dgettext-uniq
        *.pot diff=3Dgettext-uniq

Then, define diff driver named "gettext-uniq":

        git config --global diff.gettext-uniq.textconv  "msguniq -i
--no-location --strict -s"
        git config --global diff.gettext-uniq.cachetextconv   true

And the settings above will make clean output for `git diff`, `git
show` commands.

>> It will make the history of *.po-files much more readable.
>
> Unfortunately, it also makes merging changes more difficult. I someti=
mes
> queue up bugfixes between translation runs, and having the po file be
> reformatted in commits I do not control means I would have to manuall=
y
> re-add those as there is no good merge driver than can handle that
> reformatting.
>

If we update "po" files with "pot=E2=80=9D file in one commit, l10n guy=
s
can not merge directly, but have to use msgmerge instead of
using "po-helper.sh update XX.po".

And some translations could not been updated, e.g. "is.po"
is used for testing, and "it.po" and "pt_PT.po" have stopped
maintenance for years.

--=20
Jiang Xin
