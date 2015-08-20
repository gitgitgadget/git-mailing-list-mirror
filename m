From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Minor annoyance with 'git interpret-trailers'
Date: Thu, 20 Aug 2015 18:53:18 +0200
Message-ID: <CAP8UFD0YcBdAfMJxc2bQD_zTp+kPk2L2sQfWYzTDn+trFk+DMA@mail.gmail.com>
References: <vpqy4h5ud9z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 20 18:53:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZST5g-0006O9-5h
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 18:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbbHTQxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 12:53:20 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34532 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbbHTQxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 12:53:19 -0400
Received: by lbbtg9 with SMTP id tg9so27876973lbb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rzMVhmgR92SCC4Qay2l5GkvaE+v2rSiJ+JsqLl8v1cQ=;
        b=SQFMcNynuzPM2UDnYz3/XENexaxKZA70akKwTK2ZRdUxXGwJR6x9dJrYY4dX91/mnc
         gjEwv+GtH0p8/Y866xn3UbfT8oCBThq3Lxl+ArAy9IN7gLO9khm2yUw8I9dfEheVFc2o
         9wzWi+RBFcD/33P/YvDELajw9hrZxXRK3SxP/e6cZNa0+qXra22ByZKFZ1FMyRH9MhKM
         znWAsTNAPSQT6EBd+KLyCrBkbiuFUhJ3LuUzprBfzzxnleBgdfkWxn2jS2+LsIlLPuoL
         9jEBq7hTo0tsCeeCDflMMq6Pq3QOJi5pRzUsMI2bbP3u3KXjPgdvG1fmFzH3VR/VHCK1
         zPzA==
X-Received: by 10.112.199.5 with SMTP id jg5mr3705987lbc.57.1440089598111;
 Thu, 20 Aug 2015 09:53:18 -0700 (PDT)
Received: by 10.112.21.168 with HTTP; Thu, 20 Aug 2015 09:53:18 -0700 (PDT)
In-Reply-To: <vpqy4h5ud9z.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276253>

On Thu, Aug 20, 2015 at 6:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> I use 'git interpret-trailers' as a commit-msg hook to add a
> Signed-off-by in a repository.
>
> When used in a one-line commit message formatted like
> 'foo: do something', the command interprets the one-line summary as a
> trailer, and inserts my Signed-off-by after it, without a blank line:
>
>     foo: do something
>     Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> This breaks the convention "One summary line, one blank line, and then
> body", and shows my sign-off in the output of "git log --oneline" :-(.
>
> I think the behavior "don't insert a newline if the last line looks like
> a trailer" should be disabled when the message is a one-liner.

Yeah, I agree. I will take a look at fixing that soon.

Thanks for the report,
Christian.
