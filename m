From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/22] Mark more strings for translation
Date: Sat, 27 Feb 2016 13:41:51 +0700
Message-ID: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:41:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYZi-0002f2-3g
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbcB0Glr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:41:47 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36339 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbcB0Glq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:41:46 -0500
Received: by mail-pf0-f175.google.com with SMTP id e127so64353120pfe.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NcOr0RnnCUuopZv0njqv4eR8fpESU9Tzh73Te3Xg1DM=;
        b=H/K1NLHjSmU9xT+2+19ZmojhHIPmsFLeyVXmqMD4SwCzi16vVOWW1dHhnD3Dlgs5hb
         BBpRs74GrbEWfDOJ8b3MtM6U+aUijnyT5sP6yhE8tTcjnmLoBvZ/wL3iOGhfDhuI3yau
         49WJX4ij2yZu8V7fMRnnt4i1aSlSsaFoNY9kJnoTPrMly01QEJz+BMGI3HnMW+gy7A2B
         HKAsRtzn97P6LSrtiySoqIYOGDjrGHNdfrGLlRmUf3WnPZggq/RamsEjE83Tu3NqzD4M
         0dX2jdtuVZwR0w7h5CtYJTEt5Q3LYLVsoBv3e0Zg/cNF8/TCfN9txYa/stgGee/Wop88
         HgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NcOr0RnnCUuopZv0njqv4eR8fpESU9Tzh73Te3Xg1DM=;
        b=IVKIfDMrTZcBH+Yfq3GTCMBDjlrisDrAgG8T9KWC4N0xf4J4uRwdUofjvowAHhwISX
         Tmt+hD2Rq7DHRHw14RjVKfueGzjCtyk59nmajsPS8GPtJ3OoG47AYi15XPUhHNTur52d
         7+Afy2L5bbMN/jx03c7oMJ7df7+BpajyL9cZRCzvBqN01PnRkxYN5lWkJAkNc1Tio9dS
         aOpqiN3ZtO78sVtYXcIrng2MhnQCNAMNmOsIu2gY24mqnoAsx/UuYliSAGr2HtaYdqE0
         FSfjWeyAb5akTyDWB6oEztXNU9JLesdcZFsIgmAMgMtdjx5XyNX1/tyUZrMz6atUwgvI
         4moA==
X-Gm-Message-State: AD7BkJKEAXCXMsk0oC99c4V3cYe74qSGJJbYpKYTw1CWgX7D4ZlfkNbuAttheHtJFulTyw==
X-Received: by 10.98.0.71 with SMTP id 68mr7624508pfa.156.1456555306130;
        Fri, 26 Feb 2016 22:41:46 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id by3sm23523489pab.39.2016.02.26.22.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:41:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:42:17 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287661>

On Sat, Feb 27, 2016 at 6:41 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> In previous cycles, I often left many topics in 'next' when tagging
> this zero-th preview, but eventually merged them before the final.
> I decided to do things a bit differently for this cycle: a topic,
> once it hits 'next', will not be rewound and only refined and
> corrected with incremental updates, so the only effect such a late
> merge to 'master' before the final is that some topics are not as
> widely tested on 'master' before the final one is tagged.
>
> So this -rc0 is deliberately aggressive in that it includes all
> topics that have been cooking in 'next' that I think we can fix bugs
> that might still lurking in them before the final (it merges 25
> topics since the last batch to 'master'). =C2=A0The topics not merged=
 to
> this preview, on the other hand, will not be considered for 2.8
> final, even though I might later succumb to the temptation to pick
> up ones that are in 'next' as of today ;-)

Beautiful. This allows me to fix up all i18n strings in a single
series instead of spreading them across many topics in 'next'. I'm not
sure if there's enough time for translators before release though. It
depends on how many rc- there are and how long it takes for this
series to graduate.

This series marks many strings for translation. It's a result of
looking for new strings between 1.7.2 and 'master', and sometimes
looking around touched files some more.

Most of these are wrapping _() around strings, except 01/22 (enable
gettext) and 20/22 and 21/22, which convert some more strings (they
have been in my queue for a year)

  [01/22] credential-cache--daemon: enable localized messages
  [02/22] builtin/blame.c: mark strings for translation
  [03/22] builtin/checkout.c: mark strings for translation
  [04/22] builtin/clone.c: mark strings for translation
  [05/22] builtin/config.c: mark strings for translation
  [06/22] builtin/config.c: mark strings for translation
  [07/22] builtin/update-index.c: mark strings for translation
  [08/22] convert.c: mark strings for translation
  [09/22] credential-cache--daemon.c: mark strings for translation
  [10/22] http.c: mark strings for translation
  [11/22] ident.c: mark strings for translation
  [12/22] notes.c: mark strings for translation
  [13/22] ref-filter.c: mark strings for translation
  [14/22] refs/files-backend.c: mark strings for translation
  [15/22] remote-curl.c: mark strings for translation
  [16/22] run-command.c: mark strings for translation
  [17/22] sha1_file.c: mark strings for translation
  [18/22] submodule.c: mark strings for translation
  [19/22] trailer.c: mark strings for translation
  [20/22] transport-helper.c: mark strings for translating
  [21/22] transport.c: mark strings for translating
  [22/22] wrapper.c: mark strings for translation

Total 20 files changed, 385 insertions(+), 372 deletions(-)
