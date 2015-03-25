From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH RFC] init-db: introduce new -c/--config option
Date: Thu, 26 Mar 2015 00:30:13 +0600
Message-ID: <CANCZXo56RY18xKJbQoU=VRYApnKfy6e9ieu8munNsF6WB6YWYg@mail.gmail.com>
References: <1427307759-18679-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:30:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaq4K-0004SY-CW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 19:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbbCYSaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 14:30:15 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33381 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbCYSaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 14:30:14 -0400
Received: by obcxo2 with SMTP id xo2so26820948obc.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AoVeAa/6MhNvgGE7NaEHvsFlgibnGAQ1z6F7nnfjYk4=;
        b=mKiZiBPIwHHDndgxqh8meQIGb9ZZcWqdNbdIOeMfBe1pLD+ZQhTq9cU3t6aFpKOJM/
         XYo4nzEHvHqHaxipJWOk+DsMrUIPnUhu0n3l/out36xUovJPNViyswYtDF7/uV6PtlO3
         9hgKRerzutpZFfsSYH5Hmu2+5I3Qsr+Ime6X0HIJSNHXxT5DGbA+JItdL5i86GKHCuf7
         N9SF/Qj57nISduHnz4LFIop91EbPNORt5ma3W4tb4+yQMptPbMtQMwfvZqDbAd3r4mvr
         eMaKgTxL5B/7tJ+bWT8uD9KWh+ViuM6GiixKjNGFAHShbn7aoWqUXRmg9x2Ft44qpKad
         Cqeg==
X-Received: by 10.60.160.9 with SMTP id xg9mr8602592oeb.43.1427308213510; Wed,
 25 Mar 2015 11:30:13 -0700 (PDT)
Received: by 10.182.197.10 with HTTP; Wed, 25 Mar 2015 11:30:13 -0700 (PDT)
In-Reply-To: <1427307759-18679-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266290>

Hello All,

I'm not sure about two things:

1. Is there any way to do this with the current git? At least i didn't
find how to do it, so decided to write this patch.
If there is already ability to do the same without this patch, please
let me know.

2. Now current patch overwrite the value of the configuration option
from config,
if there is given option with the same key. For example, when we do git init,
.git/config contains core.filemode = true. If we will pass
core.filemode = false with this patch to git init,
there will be core.filemode = false in the .git/config. So, I'm not
sure about it.
I looked on git clone -c/--config, it just adds the same option to the
.git/config, but it looks strange to me....

So, I'm wating for any feedback.

Thank you.
