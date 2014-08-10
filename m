From: Alexander Shopov <ash@kambanaria.org>
Subject: Fixing WTF porcelain messages in Git
Date: Sun, 10 Aug 2014 18:13:19 +0300
Message-ID: <CAP6f5M=xnRHY1EFjSFPKNeA9ygz_YVdVsqY5xKV+zkA5V18HoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, Xin Jiang <worldhello.net@gmail.com>,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 10 17:13:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGUoH-0006lB-Vi
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 17:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbaHJPNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 11:13:21 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:53305 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaHJPNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 11:13:20 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so7193720qaq.11
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 08:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ah6BQhDfWTxgCWXmLa9A2e0fNsS/VcE92PDeXmSX8Bg=;
        b=ghQ/AxmJZMow5bOEqCJRdTMNFh0Lzq/B+q3k5c+Me/88puYlPz7Tyl+3h14Rf7ONXH
         IHn0ccjL+ztmnp6boohsvRxuvPUpMeX7LVvJmjQI/I9Ayc8IG3QzYgtd+qgxhtzN5H3o
         BHnLKAk17gSEGxJ0a4zxgfwYtW2AdjU2LNUbt5KDSfB8pHHS1o5Go+yCxl+dAQXY1VHb
         F5JsZOypb7jZF2jvUkmJrJZynKleTi55v+k0qK1blwMIslk7aN8PZDqNmS87oyIYr+7O
         j03UsGse5BaMX2IHh2ubnyP8MzZO1Wdo4mDwhSwYk11Yckt9tCTNGITHH6e2cmDha3T+
         5Y6A==
X-Gm-Message-State: ALoCoQnY2tTnjt7Qos3SRMSON5geOQb4nPHJI8cZJgkCuuRvnZcnSXPY8b3uJrT02ORiQcganUpJ
X-Received: by 10.224.46.138 with SMTP id j10mr55676682qaf.85.1407683599443;
 Sun, 10 Aug 2014 08:13:19 -0700 (PDT)
Received: by 10.140.93.6 with HTTP; Sun, 10 Aug 2014 08:13:19 -0700 (PDT)
X-Originating-IP: [78.83.52.173]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255093>

Hello everyone,

I have just finished the Bulgarian translation of git. Doing this
allowed me to identify about 90 places where the original messages can
be improved - for consistency, spaces/tabs, abbreviations etc. 12 of
these places however are really WTF messages - they do not explain
properly what is wrong or right about the current state i.e. the user
does not know what the problem is wrong and is left clueless how to
fix things.

I will send a patch with my suggestion for improving these 12
messages. Fixing these will provide most value for the final user of
git. The rest of improvements can wait.

I will add the maintainer of i18n, every active translator of git to
CC so they can react accordingly or just add suggestions.

I think fixing these in the 2.1 timeframe is not possible as the state
of the translations will suffer plus there needs to be at least some
minimal discussion as I can have botched the messages. I propose
fixing them in early 2.1 maintenance releases or 2.2 latest.

Just FYI, the set of WTFs is:

#: merge-recursive.c:1861
msgid "Unprocessed path??? %s"

#: builtin/clean.c:517
msgid "Huh (%s)?"

#: builtin/commit.c:1201
msgid "Clever... amending the last one with dirty index."

#: builtin/index-pack.c:1067
msgid "confusion beyond insanity in parse_pack_objects()"

#: builtin/index-pack.c:1142
msgid "confusion beyond insanity"

#: builtin/log.c:995
msgid "insane in-reply-to: %s"

#: builtin/log.c:1068
msgid "Two output directories?"

#: builtin/merge.c:845
msgid "Wonderful.\n"

#: builtin/merge.c:1403
msgid "Nope.\n"

#: builtin/remote.c:954
msgid " ???"

#: builtin/tag.c:504
msgid "no tag message?"

#: git-bisect.sh:424
msgid "?? what are you talking about?"

Kind regards:
al_shopov
