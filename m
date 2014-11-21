From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] please review a batch l10n update for Git 2.2.0 final
Date: Fri, 21 Nov 2014 16:59:55 +0800
Message-ID: <CANYiYbEa_p6q9iTS6Rys5dmZNhfZYngNFXGK-gYJFfzODg+B5g@mail.gmail.com>
References: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
	<CAN0XMOLZw+btduQkQwMLykYFgFuZzTfMwnexyGR0FBdbG=qFmA@mail.gmail.com>
	<CANYiYbEt7r1Bjx9VA29Vk5FL9Qu0nTeXVZWAaggrcM=eNsY7Rg@mail.gmail.com>
	<CANYiYbH5-eDSkq8LQsyixMsDh6e9ZA7nTVib_GbdK5BQ6vE6OA@mail.gmail.com>
	<xmqqmw7l1nq5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 10:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrk4P-0001vk-HT
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 10:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbaKUI75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 03:59:57 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:47445 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaKUI74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 03:59:56 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so8075641wiv.1
        for <git@vger.kernel.org>; Fri, 21 Nov 2014 00:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GmftX7LuCyWpYGbkWomlj2lPa/+JcBp7mwkztQNvgS8=;
        b=ltcrU9rF6c7676URncX3tkDTE5SM3AvnZRoy/aXHGZbajomLbkEG8GpP+WBczgCkBd
         5ZlSIwMveGEnvss450u3T503T+Xz/C7l3xz20F6bmnUVmzHh6A+JhCJC6rv0lqUBJCxn
         WrG2cI6o/8jq1nt6/4rKza9lbW3UVdRiR7DScBmV+qTK43hoMbt5HRN/jIQIqT+f596z
         wAdRreduPeut9t5MibfqII6SjZo0hr5XgZegnA6qT7fbMT0cLxVBlWThlnInO0ce96Io
         UTJLmTwLXg+01ZDPYWeTc2iOhXVvJIaMdA2zoPfdbs1HHWtGFskxQhlHaIKNVFz+Th9N
         vE6Q==
X-Received: by 10.180.72.199 with SMTP id f7mr5710129wiv.53.1416560395551;
 Fri, 21 Nov 2014 00:59:55 -0800 (PST)
Received: by 10.194.56.101 with HTTP; Fri, 21 Nov 2014 00:59:55 -0800 (PST)
In-Reply-To: <xmqqmw7l1nq5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2014-11-21 7:00 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> I've pushed out what should be -rc3 minus l10n changes and try to
> make sure there will be no N_() and _() changes.
>
> Let's do a 2.2-rc3 as the last round of this cycle tomorrow.  I've
> fetched up to your 7ba2ba7 but haven't merged it yet, just in case
> you will have further updates.  Otherwise, 2.2-rc3 will be what is
> at the tip of 'master' today with 7ba2ba7 merged in.


Hi Junio,

Please pull the following changes since commit
ca0107e279df1465946970113d68b4ee26ffbcc4:

  Merge branch 'sv/submitting-final-patch' (2014-11-19 13:48:01 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 7ba2ba7d12163a8f9a9947d7880bd26f2970d4c5:

  l10n: remove a superfluous translation for push.c (2014-11-20 16:23:43 +0800)

----------------------------------------------------------------
Jiang Xin (3):
      l10n: git.pot: v2.2.0 round 2 (1 updated)
      l10n: batch updates for one trivial change
      l10n: remove a superfluous translation for push.c

Ralf Thielow (2):
      l10n: de.po: translate 2 new messages
      l10n: de.po: translate 2 messages

 po/bg.po    | 114 ++++++-----
 po/ca.po    |  60 +++---
 po/de.po    | 631 +++++++++++++++++++++++++++++++-----------------------------
 po/fr.po    |  94 +++++----
 po/git.pot  |  48 ++---
 po/sv.po    |  80 ++++----
 po/vi.po    |  60 +++---
 po/zh_CN.po |  60 +++---
 8 files changed, 578 insertions(+), 569 deletions(-)

-- 
Jiang Xin
