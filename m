From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v4] checkout: add --progress option
Date: Sun, 1 Nov 2015 13:35:16 -0600
Message-ID: <CAOc6etb24owGX1KD9b-eYt5TtTKzEzinvnJ-81ev5QK_tKgLPQ@mail.gmail.com>
References: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
	<20151101191902.GA19594@sigill.intra.peff.net>
	<CAPig+cQvsXMqAzV_59sZdqDEh_SRfOMh+BY3XLmzSPdfWwugdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 20:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsyPR-0000v8-OF
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbbKATfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:35:17 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34382 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbbKATfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:35:17 -0500
Received: by padec8 with SMTP id ec8so15670139pad.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Sh5FCmIQft55/pE4JuPWQzIktoSFYZH8aqTqenkDH2g=;
        b=ow3SjnV1flUZXrIYEM5kMpEIttOyKKaLQwflQaDfOd2a1qiapHH59v4i4rieIDqfcM
         pH/vR1Xk2wfjFxSjy1bp5k2eJ2pc2oRNs5hhpJf/AvdoyleTC7pyLHsoZzCgCpcGrx4u
         fUykDa4Qbe+1qp/KBxacaNxdE57G8jXI4nNqsfB4lR8isyxuuPlXlsyxT6c4z2d7jFLp
         gpgtTGm+sV3NSDHiJnE2Siogk4khhx8PRYH0XhHaF4Sgywecfy4nL1wYZSQhNqztZyQ4
         TluJI9FHbUGmQPN3wrtKZ8P76A9Qg6lPz3X/T0O97hAy9JGNv7+GuTCS8ZFdzIPGVkO9
         ttJg==
X-Received: by 10.67.14.42 with SMTP id fd10mr22673429pad.11.1446406516529;
 Sun, 01 Nov 2015 11:35:16 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 11:35:16 -0800 (PST)
In-Reply-To: <CAPig+cQvsXMqAzV_59sZdqDEh_SRfOMh+BY3XLmzSPdfWwugdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280662>

On Sun, Nov 1, 2015 at 1:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> > +--progress::
>>> > +       Progress status is reported on the standard error stream
>>> > +       by default when it is attached to a terminal, unless -q
>>> > +       is specified. This flag forces progress status even if the
>>> > +       standard error stream is not directed to a terminal.

Before I send a new full patch, could you guys tell me if you find this ok?

-q::
--quiet::
Quiet, suppress feedback messages. Progress can skip this option.
Read the information about --progress

--[no-]progress::
Progress status is reported on the standard error stream
by default when it is attached to a terminal, unless --quiet
or -q is specified. This flag forces progress status even if the
standard error stream is not directed to a terminal and overrides
the --quiet or -q options.

Thank you all, guys!
