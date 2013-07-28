From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Sun, 28 Jul 2013 11:45:47 +0700
Message-ID: <CACsJy8Dyaf0f5rk-NS_H-M8_t7WMGJyL+z_RaEYraGqbuZ+JiA@mail.gmail.com>
References: <201307270321.32398.tboegi@web.de> <CACsJy8AT--3Lus-3F4-8EHL_3--a-98RkJxaMMALaSjgV+D3WQ@mail.gmail.com>
 <51F44F4D.7030106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 28 06:46:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3IsP-00065s-RB
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 06:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943Ab3G1EqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jul 2013 00:46:20 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:47866 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab3G1EqT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jul 2013 00:46:19 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so5393888oag.2
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PX3gIxI0wEDguv2SQL3Z3Jfzc3rQGv6PKscy0cuHVL0=;
        b=Alwoq9Dd/iJLtFE5RPZ+E0leuk4upJ12cVWMcJcF6j24ZFAh3SG3o78UGAcUWMU5T1
         ygNR8/7kDFR05rcChjHx+9YCdCrRBDi7ECJtDhYAep1PELCQU6iZCRucRmvgnfvSmFss
         5e5H/w+3oklQrSnUT2k6tmso8AYQa5hcVQCkTCGWHNd6E2qhie+5us1XwAmgslTLCD7F
         +KJ1PvqukvKDZZyajr0RePf85vzRBvWuZPSDQBl79LRkr/e4VhKMxXBAe+NWjs0EUfCQ
         k/RGqem5nibzpxsPoajMbiNCE89FAsTsEXsjQgEq6F8iWsBVROXMcCPuRddcWUZBIikX
         TPsA==
X-Received: by 10.182.34.166 with SMTP id a6mr48184406obj.102.1374986777875;
 Sat, 27 Jul 2013 21:46:17 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Sat, 27 Jul 2013 21:45:47 -0700 (PDT)
In-Reply-To: <51F44F4D.7030106@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231259>

On Sun, Jul 28, 2013 at 5:53 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
>> Does this have any effects on non-utf8 users? I'm on utf-8, so this =
is
>> not really my concern, that is unless it changes something on LANG=3D=
C..
>>
> Not sure if I fully understand the question.
>
> Mac OS will always use UTF-8, and we can choose between
> precomposesd and decomposed.
>
> Windows ("Git for Windows" =3D=3D msysgit) uses UTF-8 (precomposed)
> Git under cygwin 1.7 uses UTF-8, precomposed.
> Git under cygwin 1.5 or git compiled under mingw does not use
> UTF-8, but a Windows code page"
>
> Linux may use UTF-8 or ISO-8859 or whatever you configure.
>
> This change affects only Mac OS,
> (should this be stated better in the commit MSG?)

Ah yes, I see precompose_unicode changes default value from -1 to 1,
but I did not see that the whole precompose unicode code is only
active in Mac OS.

>
> And if somebody wants to change a repo between Linux, Windows
> and/or Mac OS, everybody should use UTF-8 (precomposed) for filenames=
,
> directories and branches.
> (or stick to ASCII)
> Does this answer the question?

It does, thanks.
--=20
Duy
