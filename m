From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] git-am: add am.threeWay config variable
Date: Wed, 19 Aug 2015 16:33:36 +0800
Message-ID: <CACRoPnTY8mALN8KbjR0CHeaKOkm2oSLRL9=4X1tU1LmHiJTeNg@mail.gmail.com>
References: <1438697966-4958-1-git-send-email-pyokagan@gmail.com>
	<vpqfv3h9bvf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:33:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRyoa-0004WG-7m
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 10:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbbHSIdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 04:33:40 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:34142 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbbHSIdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 04:33:38 -0400
Received: by laba3 with SMTP id a3so11271324lab.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qvnypvII0qgs3/4WwFUK3jjOgp/gcfrkqFT02A/EMYY=;
        b=qmW1HnabYuNxYLVlo0x3VN/j5TdBl+Swj+Mw7K1tXNDxOsFlxDFhUtgyL4pF4T2Rdn
         VnMD0wxFtNF5V/2UYC5HE5zXyYZRXZaOpwHXawB1wKIE1eDFc8bx/Die77+Uh3FumDwb
         UU2j8AoIAyLTfo3+7qh/XEQwaBBY6tZglguvbASS5YPk1GsUIhcwFwaWbwBYXmwVRaFL
         JvoUwId5zjuzD+f9rmqSLxXQKxWyFRQjB/nrpYG/7lHujh96vrMU86l9hUnrX9NpV+LG
         5xErH8gR6HTkwGjYRQBH35YRJ3X5YDfgvG9OjzRhMVDZ7ZCPO/qxSApbSjGzsSvd9iIf
         e7ew==
X-Received: by 10.112.16.73 with SMTP id e9mr4512500lbd.65.1439973216405; Wed,
 19 Aug 2015 01:33:36 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Wed, 19 Aug 2015 01:33:36 -0700 (PDT)
In-Reply-To: <vpqfv3h9bvf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276165>

On Tue, Aug 18, 2015 at 5:36 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I don't remember the details of the regression we had with the shell
> version, but that would probably deserve an additional test to enforce
> the "Hopefully there will be no regressions" part of your message.

Actually, technically, I think this patch by its own would reintroduce
the regression ;)

The reason is that the bug was caused by the overall structure of the
git-am.sh code, and not the patch itself[1].

This is fixed in another patch series[2] on top of this patch which
also implements a test for "git am --3way".

[1] http://thread.gmane.org/gmane.comp.version-control.git/274577
[2] http://thread.gmane.org/gmane.comp.version-control.git/275322

Thanks,
Paul
