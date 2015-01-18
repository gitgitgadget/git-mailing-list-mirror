From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Startup of Git 2.3.0 l10n round 2
Date: Sun, 18 Jan 2015 22:47:36 +0800
Message-ID: <CANYiYbH0dczJ3YRzyKHW1BEzZy3Odo8VvbCiWrkXhasp-35uCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:47:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCr8g-0007yy-82
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 15:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbbAROri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2015 09:47:38 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35977 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbAROrh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2015 09:47:37 -0500
Received: by mail-wg0-f47.google.com with SMTP id z12so2133943wgg.6
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 06:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KBP1T6xH51G0FeHoQvBC14X9sIQmgx/2nU1WyGhZ77k=;
        b=K+rlohK+d7ZoEZwLd1X3dP+AiQXSCdrf6vTmXu3AZu2PiiKg4tFpyLXwZQpU4Xb76X
         QOKTLlH3Z36HE+h8yBjqpQ7MsOvr9njEFyHtyngqIKpRmzQgKEM5n3AVAA6rKsf0+SU9
         ZudSKcWjlj601Bs3BtRMTjOsYjRG22IQVYJCeDcRT4MtdrpRyI8uKxwz7cTy7Jx3nCd9
         lSlfl8XMNSqtx9SzvgOrLFO5XorSEoVOfZ18+s0l49Z4ae/PxCVvZEmuHk0rNm7xzvUz
         7J+X8yNuX5VzObV9gPX5pnmxsx1vu94Z0XkAPqB7N9kj2yh7rULU6RH4xDLbjmf1e71i
         c/Cw==
X-Received: by 10.195.12.15 with SMTP id em15mr50452091wjd.80.1421592456465;
 Sun, 18 Jan 2015 06:47:36 -0800 (PST)
Received: by 10.194.80.131 with HTTP; Sun, 18 Jan 2015 06:47:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262601>

Hi,

=46ive l10n teams (Vietnamese, French, Swedish, Simplified Chinese and
German) have already accomplished the 1st round l10n for Git 2.3.0.

Now let's start l10n round 2 for the upcoming Git 2.3.0, because
there are 3 new i18n updates found in Git master.

The new "git.pot" is generated in commit v2.3.0-rc0-56-g105979f:

    l10n: git.pot: v2.3.0 round 2 (3 updated)

    Generate po/git.pot from v2.3.0-rc0-44-ga94655d for git v2.3.0 l10n
    round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin

2015-01-13 14:41 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> Hi,
>
> Since Git v2.3.0-rc0 had already been released, it's time to start ne=
w round
> of git l10n. This time there are 13 new messages need to be translate=
d since
> last update for v2.2.0:
>
>     l10n: git.pot: v2.3.0 round 1 (13 new, 11 removed)
>
>     Generate po/git.pot from v2.3.0-rc0 for git v2.3.0 l10n round 1.
>
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in =E2=80=9Cpo/README" fil=
e.
>
> --
> Jiang Xin
