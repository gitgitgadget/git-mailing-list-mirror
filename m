From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: t5801-remote-helpers.sh fails
Date: Sun, 18 Nov 2012 09:23:40 +0100
Message-ID: <CAMP44s22kuXqUjY2Oy2YtBfj1+kF2rHnRKcovV8sPkhu1oR+2A@mail.gmail.com>
References: <509E5B27.5080808@web.de>
	<CAMP44s0HtMRaQ91z95cZS73W7tnqYwyKV_2guWJ6u6UP4p5JNw@mail.gmail.com>
	<509EA8EE.1030908@web.de>
	<CAMP44s2yenQKSgdUXfZP+yDJJ+bdveyms=SQ+3ptPvpT6D0hsg@mail.gmail.com>
	<50A87718.4030806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:31:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0Hd-0000jw-ER
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 09:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252Ab2KRIXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 03:23:42 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59254 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2KRIXl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 03:23:41 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4005440oag.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 00:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7VcqAJX1h+036aqFRQXID2Kin9BycwQjR7Qg3XuvNaw=;
        b=RDBKzlJ1rStqMebOHPZt2rOiuxlp7gfaKCQstOqffLRIPdJ8gTrAwjOVw4dO6F1E4w
         AdhNx2QnCHQHunXUm7RYw18YEnMUyyhhHPUVlnEs/kOXLgdf8Wvo6cSm9mX63/VP705p
         OERf/MnWdRMiQXI2raliSAa86i4my+6VUfk/QSPMLx2fyoldbjEspEjFvCBbRfzkfMNP
         4TCoE4YuFBGKM8O6B4IU3g/5ZPte1KQfCeLpZ+LC86AOIuPL/4Ag4XcG3f4KMOxrwTXV
         Inp3OnkdOVFKppkvQ7+oHgsje2oeLxMIngV983/AWIDTzd7iQ0RqiI+kz5f9xVcji4k9
         zyDA==
Received: by 10.60.31.241 with SMTP id d17mr7795130oei.107.1353227021053; Sun,
 18 Nov 2012 00:23:41 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 18 Nov 2012 00:23:40 -0800 (PST)
In-Reply-To: <50A87718.4030806@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209992>

Hi,

On Sun, Nov 18, 2012 at 6:50 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:

> I managed to have a working solution for
> "d) add a check for the bash version to the top of the test in t/"
> Please see diff below.
>
> This unbreaks the test suite here.
> Is this a good way forward?
>
> Filipe, does the code line you mention above work for you?
>
> If yes: I can test it here, if you send it as a patch.

It's already sent:
http://article.gmane.org/gmane.comp.version-control.git/209364

--=20
=46elipe Contreras
