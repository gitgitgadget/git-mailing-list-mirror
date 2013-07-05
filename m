From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 5 Jul 2013 18:23:58 +0530
Message-ID: <CALkWK0nbib0G4w6X4sy56X4KixFqpqQ2GEJ-uSOqxVoH8M7C5g@mail.gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com> <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv5X9-0002vJ-Nz
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797Ab3GEMyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:54:40 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:56768 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225Ab3GEMyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:54:39 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so5248055iec.36
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J1N8vF5fNkxTHBKKTpwGkyXpChZhK7/7/A+wK424Ymc=;
        b=Y2LucsBUhS+TAG7SJflLd749B2V8LGzcy1zJbrvRg9SVDzYjdTaV6K9kJHPF2xPTW5
         tKqHjNv2MbOGF9I8bsUeVH6KH1oRAlNXu9KPTpD2+JCoOpGq52yBni+MhHm1fD9misKt
         UPFAIJZBOelzScPXkvM371Ph2IJNMdMMg3PWVUeE3CbL4kO+zPON1dYUnoI6MxuYosIT
         2LZvqDFvdf+QWM4LjNP9zNMNu7DpJcGDvo99QnbQPJz0WPo51XJIwKb3jHsHmY1Of4Sv
         Tq5iq1tDhghQOxjAgMgR/vqNDawGHCR/FIEI14f5M1f7TE3GP9Z/ZFqy8eHE5bg/F3c7
         wG+w==
X-Received: by 10.42.190.74 with SMTP id dh10mr3839385icb.35.1373028879134;
 Fri, 05 Jul 2013 05:54:39 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 5 Jul 2013 05:53:58 -0700 (PDT)
In-Reply-To: <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229664>

brian m. carlson wrote:
> You've covered the STARTTLS case, but not the SSL one right above it.
> Someone using smtps on port 465 will still see the warning.  You can
> pass SSL_verify_mode to Net::SMTP::SSL->new just like you pass it to
> start_SSL.

Thanks.  On a related note, how do I find out about all these things?  I tried

  $ perldoc Net::SMTP::SSL

but it was completely useless.  The only reason I got this far is
because you literally told me what to do.  Do I have to resort to
reading the sources?  If so, how do I bring up the relevant functions
quickly? (I'm looking for something like the elisp M-x find-function).
