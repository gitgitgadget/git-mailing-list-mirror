From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Enable core.fsyncObjectFiles by default
Date: Wed, 24 Jun 2015 08:07:23 +0700
Message-ID: <CACsJy8AZ7TOqZLKUD=tVaBVMH4af_jg42Y04ZryQ9dhTSoGu5A@mail.gmail.com>
References: <1435096643-18159-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 03:07:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7ZAU-0002dO-Us
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 03:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933599AbbFXBHz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 21:07:55 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36263 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbbFXBHy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 21:07:54 -0400
Received: by igbiq7 with SMTP id iq7so87512683igb.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mvhf4rRmcIq5lW9ztw1qH6WA03+I7N1/GtI7mJ3of4g=;
        b=U9RGoFDWJkggrAl30llX4nNz7F/AK3XI0tfHxEP8ZVdTQcIn8yu9u7fV1y2mdCahWz
         cfaDZbXvPzeSNhW9IUKIKZZwatzaYIM+KCZkFXzS6riuSWMjC3Cd3EPVabQlWDJ95Kbv
         oNKdc49yDL4JoHHQklG/8Ou7O9TpYQLdtW4TnGjZ3JXkA9RQQajV4oksxeLdke/+WMCa
         IFGlhiArjZ6OVw/E2sKzySNvFZ3T5cjzgtqDdZ/SoBh3FEiZeSdgxlwdmLseRZaWVjlF
         Br9n5p2x78dTAD2Yphg9EEgVVIG5DvwOOnC43aKM6acB8yhGUYV2AEkQPT3NtRdGNSK1
         l6gg==
X-Received: by 10.42.244.4 with SMTP id lo4mr6324954icb.65.1435108073349; Tue,
 23 Jun 2015 18:07:53 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 23 Jun 2015 18:07:23 -0700 (PDT)
In-Reply-To: <1435096643-18159-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272526>

On Wed, Jun 24, 2015 at 4:57 AM, Stefan Beller <sbeller@google.com> wro=
te:
> Linus Torvalds started a discussion[1] if we want to play rather safe
> than use defaults which make sense only for the most power users of G=
it:
>
>> So git is "safe" in the sense that you won't really lose any data,
>> but you may well be inconvenienced.  The "fsync each object" config
>> option is there in case you don't want that inconvenience, but it
>> should be noted that it can make for a hell of a performance impact.
>
>> Of course, it might well be the case that the actual default
>> might be worth turning around. Most git users probably don't
>> care about that kind of "apply two hundred patches from Andrew
>> Morton" kind of workload, although "rebase a big patch-series"
>> does end up doing basically the same thing, and might be more
>> common.=EF=BB=BF
>
> This patch enables fsync_object_files by default.

Will this make nfs performance a lot worse or still within acceptable r=
ange?
--=20
Duy
