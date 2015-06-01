From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 0/9] send-email: add sendmail aliases line continuation support
Date: Mon, 1 Jun 2015 07:49:36 -0400
Message-ID: <CAJ80saufd9xMAdvBT6Ts0RyVWW+PimTwvgojZ9bCT26vgUF-7g@mail.gmail.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:49:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzODu-0007vw-6Q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 13:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbbFALti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 07:49:38 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36009 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbFALth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 07:49:37 -0400
Received: by obbea2 with SMTP id ea2so101056155obb.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0/jYUe3iIRXtupgd8vFtzSlXTrvvkrxtqdFII8sutYs=;
        b=YTaK/1NbCXCUQ0d/MQfw1v+kb46fCZlRYxB6O0LBYxIoK2+lpPhaqdJYYz8Sfq57Ff
         /uNIFsHUAghoWBne/Mstu3EGqPm/opUZo8Vp07q6fEpAjEcxECMh32zAoaLCrsEr6uDg
         q+Ct5HHTZVffJEL9bsH6i++PApLrArIHZVe3OvPC505aEYrdwpZw1vFJHccDIIF7aa5D
         KzmD8PIF43rF4GbKl+bIB1xPuE1FnhrM/m6s3Ow3XgPD+SV0FWE8Mx57Vx0pUPzeGkuO
         ytG9HEl5CMWSfRahu+UwCb+KHQg1zs7bIUnpyDt9cnDEyHyIIsF3NG7dk73bf6mojQqV
         hHRQ==
X-Received: by 10.202.196.11 with SMTP id u11mr16959235oif.8.1433159376366;
 Mon, 01 Jun 2015 04:49:36 -0700 (PDT)
Received: by 10.182.117.197 with HTTP; Mon, 1 Jun 2015 04:49:36 -0700 (PDT)
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270403>

This series looks very good to me.  Thanks for the extra work you've
done to make the sendmail alias support much better :)

I'm not too concerned about this, but if you think it would be
appropriate you may use it:
Acked-by: Allen Hubbe <allenbh@gmail.com>

On Sun, May 31, 2015 at 6:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> This series adds line continuation support for sendmail aliases.
> It extends basic sendmail aliases functionality implemented by
> ah/send-email-sendmail-alias (currently d1205b07 in 'pu')
>
> Eric Sunshine (9):
>   send-email: further document missing sendmail aliases functionality
>   send-email: visually distinguish sendmail aliases parser warnings
>   send-email: drop noise comments which merely repeat what code says
>   send-email: fix style: cuddle 'elsif' and 'else' with closing brace
>   send-email: refactor sendmail aliases parser
>   send-email: simplify sendmail aliases comment and blank line
>     recognizer
>   send-email: implement sendmail aliases line continuation support
>   t9001: refactor sendmail aliases test infrastructure
>   t9001: add sendmail aliases line continuation tests
>
>  Documentation/git-send-email.txt |  5 ++-
>  git-send-email.perl              | 54 ++++++++++++++-------------
>  t/t9001-send-email.sh            | 81 +++++++++++++++++++++++++++++++---------
>  3 files changed, 94 insertions(+), 46 deletions(-)
>
> --
> 2.4.2.538.g5f4350e
>
