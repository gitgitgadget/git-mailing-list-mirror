From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] help: introduce man.viewer = eman
Date: Sat, 22 Jun 2013 17:35:01 +0530
Message-ID: <CALkWK0m6V9ULgeA81yK2WuoLgf6n4q8_BS-D4VHpTYJMQiG95Q@mail.gmail.com>
References: <1371901409-8319-1-git-send-email-artagnon@gmail.com> <20130622115938.GF4676@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jun 22 14:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqMZe-0006aO-LR
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab3FVMFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 08:05:43 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46751 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab3FVMFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 08:05:42 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so21866266ied.0
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A98Kn1jKlwP1yDf+X9KDIrOsq0cKVWRwhS0MnXUBteA=;
        b=NtxpJr+tLemIWv0z16AjV1OqZiJmaBBeqHXB+pUZepu+Kc2rY0Xvty8xSlisaNqFHy
         XBYKbdkF0Pg6XJULo1YIKmvAKZGmdwtyKYFwh1Iqs3J/LxDDimvRY0zM1oYD781JHLIE
         x8P3t6voOjh+Ynlw0WsHigfNA8bNuNFLzem1nnG+wbiFoQ+g5KxRv1G2bu9G9CBEkPpd
         Jh8furgpIR9mArKnTkC6CUHVcRQVq3OwUAUwrFDAT8jD69XWkYJuiD+jDLmgRgGC0Ko8
         eCUA2eTRoI9RJIJ07dT+uoTgp/LvQO8QQTSz0UfKCSOixE+w9u2JT5bETLWdcGN97HBs
         DgQA==
X-Received: by 10.42.190.74 with SMTP id dh10mr8042633icb.35.1371902741935;
 Sat, 22 Jun 2013 05:05:41 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 22 Jun 2013 05:05:01 -0700 (PDT)
In-Reply-To: <20130622115938.GF4676@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228701>

John Keeping wrote:
> Would it be nicer to pass a string in here instead of a flag?  Then this
> becomes:
>
>         strbuf_addf(&man_page, "(%s \"%s\")", command, page);
>
> You should probably also rename this function to "exec_emacsclient" or
> something as well now that it doesn't just launch woman.

Sure, will do both.
