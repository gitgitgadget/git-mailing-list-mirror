From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug on OS X...
Date: Fri, 28 Jun 2013 10:13:00 -0700
Message-ID: <7vwqpep3ab.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5VeE7dyo_A7904SBNSvf834xdGyyuk=vE44wXoRVJ-nkg@mail.gmail.com>
	<9DD46E0F-FA9C-4C60-A1CE-03EAAD823967@quendi.de>
	<CAEBDL5V3eAJGs-CTVZd8wVxKV3b+Gbk26E1rFaKjk-xBhSu31Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 19:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UscEa-0006Ro-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab3F1RNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 13:13:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755736Ab3F1RND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jun 2013 13:13:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6690E2960F;
	Fri, 28 Jun 2013 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QuAgupH0dU+i
	eG7ssimkxFDewVk=; b=qXFsbCHbj3LYOeomr7dcAj+bYHr3U+cG8hlycXDUqLff
	tOGaT80Md2Uah/0stcbKJHajDTBElgbPJfhbHMVltHu6fxz3L9+zOd/hfGKcQH17
	GlE34r1hmT7baz2nIQFVWtKxlrDJSmz9vcRu9ldgnj5J2FOdqLarOcxm08b663c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q1yrgE
	CfVKfF47w8ARpWvj5mt/K9Dm3BxEqmQhZUgcq8O3KUvmZEp1prvTvaSMJM9Etnhy
	FeaY4OuEdOe9SEFJUHk5zDUJQzW6F1e0a7rRkD3Natwi6ycV8IunuEDxddShnT0O
	qhUGHIKB0Cgvql/I7PtqUiAdppGMmFpecOVYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A23C2960B;
	Fri, 28 Jun 2013 17:13:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3CF72960A;
	Fri, 28 Jun 2013 17:13:01 +0000 (UTC)
In-Reply-To: <CAEBDL5V3eAJGs-CTVZd8wVxKV3b+Gbk26E1rFaKjk-xBhSu31Q@mail.gmail.com>
	(John Szakmeister's message of "Fri, 28 Jun 2013 09:51:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCF632C8-E015-11E2-987E-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229215>

John Szakmeister <john@szakmeister.net> writes:

> On Fri, Jun 28, 2013 at 8:44 AM, Max Horn <max@quendi.de> wrote:
> [snip]

>> I am unable to reproduce this on Mac OS X 10.7.5 with git 1.8.3.1
>> nor with current git maint. Command run inside /tmp, which is on
>> a normal HFS+ volume (using the default settings, i.e. the FS is
>> case insensitive).
>>
>> $ git --version
>> git version 1.8.3.1.42.ge2652c0
>> $ git clone --depth 1 git://nbd.name/packages.git
>> Cloning into 'packages'...
>> remote: Counting objects: 4711, done.
>> remote: Compressing objects: 100% (3998/3998), done.
>> remote: Total 4711 (delta 157), reused 3326 (delta 94)
>> Receiving objects: 100% (4711/4711), 3.85 MiB | 0 bytes/s, done.
>> Resolving deltas: 100% (157/157), done.
>
> OK, so I finally tracked it down.  Commit
> 6035d6aad8ca11954c0d7821f6f3e7c047039c8f fixes it:
>
>     commit 6035d6aad8ca11954c0d7821f6f3e7c047039c8f
>     Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>     Date:   Sun May 26 08:16:15 2013 +0700
>
>         fetch-pack: prepare updated shallow file before fetching the =
pack
> ...
> It looks like I was hitting the race condition.  It's fixed on master=
,
> so I assume it will be in 1.8.3.2.

Hmmmph, I do not think the cited change is about any "race".

If it were that we spawn index-pack and write updated shallow
information at the same time, and depending on the timings,
index-pack may not read the updated one and fail, then it would have
been a "race", but that is not the above change is about.  If you
saw the issue on MacOS, you would have seen the same breakage, as
long as you started from the same repository status, on other
platforms, and reliably.

An early part of nd/clone-connectivity-shortcut topic contains the
said commit, and I do not mind merging it to the maintenance track,
but I suspect that there is something else going on on your OS X
box, if you saw differences between platforms.

Perhaps on your OS X box you have {transfer,fetch}.fsckobjects set
to true while on others it is set to false, or something?
