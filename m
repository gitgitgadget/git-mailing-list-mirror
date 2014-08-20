From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Tue, 19 Aug 2014 22:57:56 -0700
Message-ID: <CAPc5daWTeiW_4k9nCH_CQGPPva-dLtmWFu4KN-cxxw6J1MQFUw@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <20140820011935.GC3104@localhost> <CAPc5daWJj1oM3ebc59sbpORggoigyq-hSOvfc0ueFHD=WeCYWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 07:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJyuu-0003Ef-0i
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 07:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbaHTF6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 01:58:24 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:56414 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaHTF6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 01:58:18 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so6870243lab.36
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tc7MGAUv5OJHCOp10F33PYSZTFwKTm2vHrpz2TLldbU=;
        b=TWhnX6KBwFd6dDAoRgNXtMtt1bxNmIVFm9lHDPMQIrVdw3os6wr3IG8dVfqVdMQba6
         GtlKzj0+yzRjqZpdjWHvKoqoKRga6CzBfZ1g3rmFFxRFIJOumPwMyruHE7OUIcPobqBB
         2TIXkUG7cP/MPyEdjCDK8H93SlKjJVjBk/8F5n8Ag8HTB7IEEdBTU/Ln5dxTRW27Zrbt
         Y6aYDwGQMq2o+JNgkkAkJonLEhzemkQdXLt9zJqmVS+rKBI4GpdUAagDWUpkJlZJZdCD
         rDZHFuKo8OwW+QOCU4rDUxjS5WU/WT/88S/pbD5mp9qxqKI0sI+aXqkiRBIuGDYp+2cw
         1vOA==
X-Received: by 10.152.28.134 with SMTP id b6mr26459812lah.33.1408514296747;
 Tue, 19 Aug 2014 22:58:16 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Tue, 19 Aug 2014 22:57:56 -0700 (PDT)
In-Reply-To: <CAPc5daWJj1oM3ebc59sbpORggoigyq-hSOvfc0ueFHD=WeCYWg@mail.gmail.com>
X-Google-Sender-Auth: xc_WTC5rvho1Q_UXAcgbJMftBh8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255552>

On Tue, Aug 19, 2014 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, but I cannot answer, as the only thing that I recall when
> I hear "branch object" was that I heard the phrase used but
> without much substance.

Just to avoid unnecessary misunderstanding, by the above, especially
the "without much substance" part, I do not mean that those without
code have no say in the way the project improves its product. It is true
that this project does not operate in such a way that visionaries throw
ideas for coding minions to implement. A person with an itch and idea
on how to scratch that itch is expected to lead the design and code,
possibly with help from others. But in order to ask others evaluate and
join force to help with the design and make it real with code, you need
to present your idea to sufficient level of detail to be actionable.

By "actionable", consider the level of detail in which the proposed log
message (not code or documentation update) of PATCH 15/18. Even
though the message alone does not give any working code, or it does
not even spell out the byte-level detail of how the protocol messages
look like, people should be able to read enough details such as what
kind of information a push certificate is to contain, when a certificate is
created, how it is transferred, when and by whom it is received, how it
will be used by the receiver, how a server operator can tweak his or
her system to make use of the information, and how the newly added
system component would fit into the existing system. In other words,
the description should be sufficient to assess both how useful the end
result would be, how much new work needs to be done to get there,
and how well the resulting system as a whole would fit together well.

I went back to the old thread to re-read the mention of "branch object",
but I did not get an impression that the idea was presented to the
actionable level of detail; at least not yet.
