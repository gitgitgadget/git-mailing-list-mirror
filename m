From: Lars Vogel <lars.vogel@vogella.com>
Subject: Re: [PATCH] Use "working tree" instead of "working directory" for git status
Date: Thu, 9 Jun 2016 20:21:03 +0200
Message-ID: <CACA4a_Gzw5OXRc-ZaP78KOWW7nWzyN7KfWf_Gq_7vr+1HC-g0w@mail.gmail.com>
References: <1465494374-10417-1-git-send-email-Lars.Vogel@vogella.com>
	<CAPig+cR6j=L5P_i=D_6Q8Dfmu0jew9QDnRQTXjCJYQ9AUszz1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Vogel <lars.vogel@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 20:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB4c5-0006pW-W4
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 20:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162AbcFISVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2016 14:21:07 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36733 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbcFISVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 14:21:05 -0400
Received: by mail-wm0-f47.google.com with SMTP id n184so236811822wmn.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vogella-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=H6bvWzxOJ+s30UVm5dMr/nGbsbYVhhRQ/UFmVUAq+Lk=;
        b=0bqjhMdNNodr0U7PqmOaWtHYVleyPZ5+OkgYvJrA6tpHN8KilntO4a3daecSg1LHi6
         haA3TxuAwGNmYoRadKMmYaYyaxR8+R2glotpUL6I18pUU7YgX0tscqoVf0Mi89DygfJW
         NXG+B+Y6mnDVd5D+Tuvsn6ePDsdOFslgcoYU4zYDRA7H4pyJyHP+NKz16ceFawIphk9X
         CV6kTlX5zXrEDz3HjRAMWH0PzMJPK4LkbRtt1ZFIGHYHmj3KjVmzVBNDJ1pbAKiTRMti
         py97teZV3PuuH/oZIIDlvM8TLuk2Ro4ysjG0uKRS5KszmpKg9uv6aMW6qlnZV/2uoITv
         N29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=H6bvWzxOJ+s30UVm5dMr/nGbsbYVhhRQ/UFmVUAq+Lk=;
        b=Jnrbqdip8Vo7gn145AQJCYmAvzXiAHNSLVZr8sDhIml2Adw3wCdyuI8u0onqQE13hW
         1E1DM5Mm3sCxjFwwzg8aO7hUE8w/gwMuZ3QE5qu0hxgTOQbDn9LRtsZfFrxlQYcKbLEl
         in+ugvQQeGugGsUW/tBPkU+bMQWbNYkH+AKwSaggIsAt2Bl3fJwtcgqrAV4w+ijkd1sX
         3/SDetEaklOU7Hrut78Z0XYYlf/QNz/kheXbdoaEIrYCAf18EqNKi7kUpYLEHHXc5KAF
         XC67Wqb7dKYlYyZQbh55JMMf8hEqC4IXmWlx5nio/02ZqSWZ4FqS9Zx6W/EV/wXCkxKZ
         E4Jg==
X-Gm-Message-State: ALyK8tKTghjUV3m9PqyKut7lqnsSg8tR2uF7MLUoZUG7qsg5ioLHq8uYzW/eVY0TVsSQlAWcNbnG5CnlPk1d5YtN
X-Received: by 10.194.41.35 with SMTP id c3mr10409507wjl.91.1465496463554;
 Thu, 09 Jun 2016 11:21:03 -0700 (PDT)
Received: by 10.28.136.65 with HTTP; Thu, 9 Jun 2016 11:21:03 -0700 (PDT)
In-Reply-To: <CAPig+cR6j=L5P_i=D_6Q8Dfmu0jew9QDnRQTXjCJYQ9AUszz1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296913>

Thanks updated patch on its way.

On Thu, Jun 9, 2016 at 7:55 PM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Thu, Jun 9, 2016 at 1:46 PM, Lars Vogel <lars.vogel@gmail.com> wro=
te:
>> Working directory can be easily confused with the current directory.
>> In one of my patches I already updated the usage of working director=
y
>> with working tree for the man page but I noticed that git status als=
o
>> uses this incorrect term.
>
> Missing sign-off.
>
>> ---
>>  po/bg.po    | 2 +-
>>  po/ca.po    | 2 +-
>>  po/de.po    | 2 +-
>>  po/fr.po    | 2 +-
>>  po/git.pot  | 2 +-
>>  po/ko.po    | 2 +-
>>  po/ru.po    | 2 +-
>>  po/sv.po    | 2 +-
>>  po/vi.po    | 2 +-
>>  po/zh_CN.po | 2 +-
>>  wt-status.c | 2 +-
>
> Don't bother updating the .po files; that's the job of the
> translators. Your patch should touch only wt-status.c.
>
>>  11 files changed, 11 insertions(+), 11 deletions(-)



--=20
Eclipse Platform UI and e4 project co-lead
CEO vogella GmbH

Haindaalwisch 17a, 22395 Hamburg
Amtsgericht Hamburg: HRB 127058
Gesch=C3=A4ftsf=C3=BChrer: Lars Vogel, Jennifer Nerlich de Vogel
USt-IdNr.: DE284122352
=46ax (040) 5247 6322, Email: lars.vogel@vogella.com, Web: http://www.v=
ogella.com
