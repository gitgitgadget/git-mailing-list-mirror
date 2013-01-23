From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 3/8] git_remote_helpers: Force rebuild if python
 version changes
Date: Wed, 23 Jan 2013 10:51:24 -0800
Message-ID: <CAGdFq_jfoN7FbbNXwudzOo7=E3Z11=sL0VGW3_QgRyCSQWw8aA@mail.gmail.com>
References: <cover.1358686905.git.john@keeping.me.uk> <9a8644116bebf81cc15c0e63056bb2054dd17ebc.1358686905.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 23 19:52:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty5Qz-0000Pj-9a
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 19:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab3AWSwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 13:52:08 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:36885 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab3AWSwG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 13:52:06 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so847276qcm.25
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cHUZsu8vGTGKxeZbXzAJXF61t7ikBKR27eX27aDdSyA=;
        b=JJBBvVZ49kkqvveSkEP+/kpUvQVJdFerbvvqLvKdZs7LAT0Ub5wFI9LHNeu+rEOE1c
         mWAQZUvRVuqvkcN72i0KOY0Z9drXHRaePZ5WY+vxaaPmYbqMhk0nXoWEb8Fk9fZvNY+w
         3+Sn/eQhjJSvJOdxDTeQqOPw6+1Y8gcI48MTeIAgpHVGMGqJIiRUsdD9JMLAAY83SPIW
         GhVf0YXCChGKthRmjv3VC9RZSMtPfO5fhO5UUVW6obkPB2D3XXBZMiUVhiLArQfmR17Y
         eHFHeI0ybsi3I/4SJQMoEO6df4i3MdV+hM5K/7A2/pSk2PWxOtoYw9ZJmU2Bq2rhhBQR
         P57A==
X-Received: by 10.224.183.197 with SMTP id ch5mr2987984qab.27.1358967124590;
 Wed, 23 Jan 2013 10:52:04 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Wed, 23 Jan 2013 10:51:24 -0800 (PST)
In-Reply-To: <9a8644116bebf81cc15c0e63056bb2054dd17ebc.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214344>

On Sun, Jan 20, 2013 at 5:15 AM, John Keeping <john@keeping.me.uk> wrote:
> When different version of python are used to build via distutils, the
> behaviour can change.  Detect changes in version and pass --force in
> this case.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Someone else's review on this would be appreciated, the idea sounds
sane but I can't really comment on the implementation.

--
Cheers,

Sverre Rabbelier
