From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 0/1] handling mistranslation reports (resend)
Date: Sun, 2 Aug 2015 23:50:58 +0800
Message-ID: <CANYiYbGbMvPOerwQHSKRzqR8HfsTm-6fV6R+gefiX4hr1d4=SA@mail.gmail.com>
References: <1438522955-6076-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 17:51:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLvXW-0008FF-Ec
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 17:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbbHBPvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 11:51:01 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34348 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbHBPvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 11:51:00 -0400
Received: by labow3 with SMTP id ow3so2346171lab.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HZFgH0gxYBut2rq1tBD2xgyREiTgakYyUMl+b/OLlto=;
        b=yEPujr6q6nfDwVoqZhLngQuCIQ8b5DEKqXW6TGzlZdqVrosul5FCukqOyXmh3JmsIX
         fX7AnP7aj4CfFZUifdlHS8viN/06FWsDpRJOVxdrtvI5v5ulq8GXSD2SEv3iHHVYUyz3
         qJ3eOWwLMpp8H5tKggAv+Hv6zBxurPzKrwt/Aru6Og/w4ugD69tgaLrYm9h79N2gjWgs
         1nG7REfCVacDX3hiUHxcWawmbAufS41vR/jjFtjGUvp1mxLqefpWYHcqR1LO6kWvpwHW
         XqYf2BaEldmxtMUvj/UiQ6NQUijph3+b3N/lL/ifMA3qb8vFHoKZicfXN+nYvpF59FRX
         bNfA==
X-Received: by 10.152.37.37 with SMTP id v5mr12657174laj.11.1438530658758;
 Sun, 02 Aug 2015 08:50:58 -0700 (PDT)
Received: by 10.152.132.7 with HTTP; Sun, 2 Aug 2015 08:50:58 -0700 (PDT)
In-Reply-To: <1438522955-6076-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275141>

2015-08-02 21:42 GMT+08:00 Philip Oakley <philipoakley@iee.org>:
> [Resent as first email was not picked up by vger, apologies for any duplicates]
>
> Hi Jiang,
>
> Recently, on the 'Git for human beings' list, a user reported a
> mistranslation and asked if/what could be done, with a suggested
> alternate text [1].
>
> I pointed the user at the po/README for general guidance.
> Unfortunately the user was noting a Spanish (es) translation error which
> is not held in your tree, but the README does include how to start a new
> translation. This led to a misunderstanding with regard to which aspect
> of the README was being referred to (private discussion with Junio).
>

Some linux distribution, such as Ubuntu, has its own l10n workflow for
each package (including git.git), and not works well with the upstream.
For example, Ubuntu makes a one-time import from our Git translations
(from some obsoleted version) into their l10n databases, and their
contributors will start to translate using their web UI, and never sync
with our upstream again.  They ubuntu may have more languages
support, but they may also have more bugs.  Sometime,  their bugs
will be reported to our upstream, for example:

* http://thread.gmane.org/gmane.comp.version-control.git/239130/focus=239130

We could add some clues for this case if the user can not find
the resource to contribute.

--
Jiang Xin
