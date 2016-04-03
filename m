From: Saxon Knight <knight.saxon@gmail.com>
Subject: Out Of Place Capitalization In Stash Feedback
Date: Sun, 3 Apr 2016 12:09:14 -1000
Message-ID: <CAE3c8OtZx33q+gsYFgq9Rn9EtEAnSREkxL9TkTOK_n489Yh+Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 00:09:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amqCx-0005ld-1f
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 00:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbcDCWJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 18:09:15 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35055 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcDCWJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 18:09:14 -0400
Received: by mail-oi0-f50.google.com with SMTP id p188so144369417oih.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=enxLQKoJ+kJNPZQTVZ7uPuLEpOfzbXba7+P/6pjhz4Q=;
        b=LRJoSLWyCihiLbPPu6BVC272acWyJrMEhEqvANimUGt0BwoEZoHsKC2r3MwdYti9gS
         gVR8Kj8GKWdSv8nyOqT9vpjqn+4vfdo3JtpsyaTSURd6IibuXBROlDCCpVGj1Mdus/Cw
         4wetBWncMIWBw9FYfyGGOTerKSTkNnNAn1p67g4mH1oQpqQrbLEvl2l/s5LY5mWjK+oo
         oT0FBi1L5UdG3LQAIfUvmmc/FqgCd27z13OEEc8TOFNPCFx/Wdnyl5fASO7IGARZUieX
         AG8Wt8Bo62MEGF+h5M6SUVvRQjYshQrqgEm8gt9BEA2S2grbk9d0zIMPdCrkPMrECOsY
         Ajbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=enxLQKoJ+kJNPZQTVZ7uPuLEpOfzbXba7+P/6pjhz4Q=;
        b=BO7ONDMjYKPa1tlqVJQbOKg+7g2F2Otrlsgiz6VrJM7qZDH/SP7RLPSKQ5Wve1pjcm
         JaujRj29Ah1M4gT/uYv5sR6cOCsy3e3DEDe0+AVtChigIe+6tblfVdbKielAZMJbIs8E
         Q9r9sS4i+q7Vbu/3Z8yRd6pP+YNqUbaUVH6RDv0xfei4BM9sHG0zPfuAgeb0qkY5oi3q
         iwVfaH7IBogkM9G2Q3YQcbVqfqzG/qHx7B28XRTVEsWm71e1hDDL/3BEMxhXwJhObrHu
         aJIKyQPiAa9H+w8JQNsQRes0QOGg/ji2XCyvZP8vDQu1qZf0jyjtRkq9eKDEmcnXTPcf
         s9aw==
X-Gm-Message-State: AD7BkJIRpZnkRFnlBa5HbSskT2aJFe5Wy2ttfBylqwsdS5ql1NV5iOY9JHcxHSRbeai9gjyFhXQJt01YiZC6Dw==
X-Received: by 10.157.12.200 with SMTP id o8mr9227014otd.148.1459721354191;
 Sun, 03 Apr 2016 15:09:14 -0700 (PDT)
Received: by 10.157.26.79 with HTTP; Sun, 3 Apr 2016 15:09:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290660>

Hello,

I recently did a git stash save "working on main", and in the
feedback, I noticed that "On" was capitalized ("...state On
master...").
I don't think this is intentional, so I figured I'd try to let someone know.

Here is the output (quotes included by me):

"Saved working directory and index state On master: working on main"

By the way, I love Git. Thank you to everyone who helps to make it the
best VCS out there!

Sincerely,
Saxon P. Knight
