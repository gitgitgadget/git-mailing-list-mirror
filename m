From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 0/5] group common commands by theme
Date: Thu, 21 May 2015 14:15:05 -0400
Message-ID: <CAPig+cQtYjyj2dVFX_8CjyacRPd+dU6aMMXYGsoX9+q+zgjdZQ@mail.gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 20:15:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvV01-0005Xk-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbbEUSPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 14:15:07 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37357 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbbEUSPG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 14:15:06 -0400
Received: by igbsb11 with SMTP id sb11so15175367igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7+yVBO3XXakpr9GX412sdgQNZcCtcznZ0LNhfI4HzxQ=;
        b=l0xOpAOxE0X9t7oTDyr9pUprjVXw3DH5g6lrO6LpE4dFLUFJnDI7dbke5jQvJazK0S
         iS41EA+3xOTfgx3LWc4w+g0EFaP2CpwaW9RZSZYbdAxmX5L8ugmuRyAZsDn2J1dWJnGJ
         XS7nul0DPxqRaxtAP5FPq4wsVxF4axK9iXeCafLjgSElspe0hsIO22jinnamwDhdpy0f
         lC3W4cvQxrb/QJQ9GPl/l7pC9c29wd6ioFi8uSQzhaLy0g3W81O2/ddh0ukykkvos9h6
         44/f0hSBMiAFNbvXk+2JliQgWl/IaEy5k6FPDdPdhzRJLdOxAbHjkp8qf5o4UFg1dJAg
         n9cQ==
X-Received: by 10.107.151.75 with SMTP id z72mr5159620iod.46.1432232106030;
 Thu, 21 May 2015 11:15:06 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 11:15:05 -0700 (PDT)
In-Reply-To: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: PBf47LDNE6I9QaZIyL_1vYTgjcU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269637>

On Thu, May 21, 2015 at 1:39 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> Just a minor change, the modification of new-command.txt was squashed=
 to
> 2/5 instead of 1/5.

Thanks. With or without addressing the two very minor nits I pointed
out in patches 2/5 and 5/5, this entire patch series (v11) is:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> Eric Sunshine (2):
>   command-list: prepare machinery for upcoming "common groups" sectio=
n
>   generate-cmdlist: parse common group commands
>
> S=C3=A9bastien Guimmara (3):
>   command-list.txt: add the common groups block
>   command-list.txt: drop the "common" tag
>   help: respect new common command grouping
>
>  Documentation/cmd-list.perl         |  4 +++
>  Documentation/howto/new-command.txt |  4 ++-
>  Makefile                            |  9 ++++---
>  command-list.txt                    | 53 ++++++++++++++++++++++-----=
----------
>  generate-cmdlist.perl               | 50 +++++++++++++++++++++++++++=
+++++++
>  generate-cmdlist.sh                 | 23 ----------------
>  help.c                              | 24 ++++++++++++++++-
>  7 files changed, 117 insertions(+), 50 deletions(-)
>  create mode 100755 generate-cmdlist.perl
>  delete mode 100755 generate-cmdlist.sh
