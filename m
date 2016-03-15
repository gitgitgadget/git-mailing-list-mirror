From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Wed, 16 Mar 2016 00:42:35 +0800
Message-ID: <CANYiYbGkieYRVCEgHCADKwDFXmXexyCV0C1GquDv8FbX+3dYYw@mail.gmail.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 17:42:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs3O-0005Wy-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934636AbcCOQmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:42:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35766 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934196AbcCOQmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:42:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id n205so4435535wmf.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DhjGCK0Wl0+CQxrdDQRhJn49a8f5nd1Zy0//dTVMLxs=;
        b=AYCOzZGX/ICHQkK95l/GFMgqm6i2t8oMZfQrWUACanPQ3XvU6JnRh3FuR1ipr7NhjR
         ML+JFT9yywiVRzC7brFs9hF/MNPRjVR/JNp2cWZJYwE2+dEU/gkxCORrzsPbNFjHK3Ez
         upbDBlwlr9VFXtgiVglyvHTJgKpu83vW8jVBdPS9hBKA9UlMYB19nFcgqINYJeZxFMZi
         RkTJymwmYJuJITe0+jT3KD3YMK6We0TlaS9sFlwxAfVh1/M0wdtPQrzbJoG69ZiuDrmW
         EgGYhkJMu96s7p5mDaSxRKyrJFGn8DZ0O8d3NAdhoUWY6K8mp6pWwxqEtmj3QNULhXXD
         47HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DhjGCK0Wl0+CQxrdDQRhJn49a8f5nd1Zy0//dTVMLxs=;
        b=TR4Ipet7gNTQNr+pOXibmLChggBl0HkJNTFsOXBQqlgxxt6vks4vbuSfAktLHQ3P7M
         DtNxcHG4WOIn53Ke+vhC+cQKsXTZII+KyS2Uvbm5zhgMCZlomI51QLsO9wzgPbV5AQOz
         Vrd10OvOKeRZs6GTN/GHLForqY3Z1swYwO4YFpZYKf1o3sSt+P4ntRVMUDMJ4FyDs2bb
         Mq56LvnuVbrz0FkFl0TlJHkpwjA+VbqGU7o6HpoMuJ65bi8r0TjxcyhFVo4IZ9xRQ7Ee
         F2o3HhQTVJbZHu7MaYHHIXnu0rCXQTzJfwEY1s046h/Q+21E+wA9/K+muWnRe4u+tTvi
         NlCA==
X-Gm-Message-State: AD7BkJIIAtukfC2oqt9+C9vkmGFonvHKA5yrKk9Yo6msdhbOm9yB5vSu38BVEgn2T5RZ7zYMzmdvcsak2tCtew==
X-Received: by 10.194.216.40 with SMTP id on8mr34111122wjc.40.1458060155704;
 Tue, 15 Mar 2016 09:42:35 -0700 (PDT)
Received: by 10.194.54.8 with HTTP; Tue, 15 Mar 2016 09:42:35 -0700 (PDT)
In-Reply-To: <56E6D8C4.2010205@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288861>

2016-03-14 23:29 GMT+08:00 Michael J Gruber <git@drmicha.warpmail.net>:
> Hi Junio,
>
> Have you pulled git.pot for 2.8.0 already? [1]
>
> Maybe I'm not up-to-date on the release cycle timing regarding l10n, but
> I was trying to fix a mixed translation/non-translation issue, and it
> turned out the reason is probably that it is not in "git.pot":
>
> "behind " is in git.pot
> "ahead " is not in git.pot

Yes, I find your commit has just been merged in the master branch, and
it brings one extra message to be translated in Git v2.8.0 l10n.

So let's start round #3 of l10n for Git 2.8.0 to make it perfect.

> Now, I can recreate git.pot locally, of course, but localisations such
> as de.po seem to have those translation commented out because they're
> missing from git.pot.
>
> Basically, translations don't get proper testing at this point in the
> release cycle.

I will send a pull request to Junio right now, and you can test it on
a updated git.pot.


-- 
Jiang Xin
