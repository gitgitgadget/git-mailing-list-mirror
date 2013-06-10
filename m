From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
Date: Tue, 11 Jun 2013 01:03:18 +0200
Message-ID: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
 <1370889365-6239-7-git-send-email-richih.mailinglist@gmail.com>
 <7vli6hg2ut.fsf@alter.siamese.dyndns.org> <CAD77+gTv-x7ZKAR3PycDWNhqeWcnEFEhK290ndxeyqqkBfWfeQ@mail.gmail.com>
 <7vobbdefr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 01:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmB7o-00051s-LS
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 01:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab3FJXDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 19:03:41 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:44399 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab3FJXDk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 19:03:40 -0400
Received: by mail-wi0-f181.google.com with SMTP id hq4so1371891wib.8
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YrEGKsDUwOLoJxGG2XhrEqiF26hEMXZp1rri6I/d43c=;
        b=p2Qah0+nUc4Djq0lLGtKvOxMSWYPE3nA690jgcGAPLA/VRP0nZX4vOGZ2AKP8Ilf23
         6VFFvfbrXerzEA6rTt3yJIV5s9gk6nPAxdcoDB0H1ypF2XvrjuiCj3qnPDpiFfMraUGi
         citLIEcM3sUS3z5+5+etsm4z0idSFvhLcan5TyJSH3gZP5BZEp16nkaFvC4kLpTTy0a6
         WGBu50tJzynY3Qv5lgCFunnTbpqsVgUqt/Sj7agGrCVB0+vT0oJKF0LxImdtTjquSY3i
         Y1kzqAxi/4vkVn+1hgpU5vPowGxnwAhpdDjNNxZN4o8R+hh5kfEm3OhcOAO5FylwjA7w
         nucw==
X-Received: by 10.180.160.167 with SMTP id xl7mr55920wib.62.1370905419077;
 Mon, 10 Jun 2013 16:03:39 -0700 (PDT)
Received: by 10.194.17.9 with HTTP; Mon, 10 Jun 2013 16:03:18 -0700 (PDT)
In-Reply-To: <7vobbdefr7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227399>

On Tue, Jun 11, 2013 at 12:57 AM, Junio C Hamano <gitster@pobox.com> wrote:

> [PATCH 1/6] templates: Fewer subprocesses in pre-commit hook
>
>   I agree with Peff that "less fork" is a bad justification for this
>   change, and also
>
>                 echo 'First line
>         second line
>         third lie'
>
>   looks somewhat bad.

The repeated echo also looks bad, imo. Also, 2/6 depends on this to
save lines. Should I rewrite with EOF, keep as is, or drop?


> [PATCH 2/6] templates: Reformat pre-commit hook's message
>
>   I think it is a good thing to make the output short by widening.

As I said, 2/6 depends on 1/6 to some extent.


> [PATCH 4/6] Documentation: Update manpage for pre-commit hook
>
>   I debated myself if it should say "The hook _by default_ prevents
>   addition of non-ASCII filenames", hinting that it can be
>   configured out if it is unwanted.
>
>   Other than that, I think it is a good addition.

Will update once I know the complete TODO.


> [PATCH 5/6] templates: Fix ASCII art in pre-rebase hook
>
>   Good, but see Peff's comments on the explanation.

OK.


> [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
>
>   After reading the original once again, it is fine as-is without
>   the change at all, I think.  Alternatively, "if these match" and
>   "if this is empty" lines can be flushed to the left, which also is
>   readable.

I think I will flush and capitalize, then.


Richard
