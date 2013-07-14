From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] templates: Use heredoc in pre-commit hook
Date: Sun, 14 Jul 2013 13:20:51 -0700
Message-ID: <20130714202051.GC8564@google.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
 <1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
 <7v1u71gd7r.fsf@alter.siamese.dyndns.org>
 <CAD77+gSE5GnTcrpoWO0bb2UysDE9t51EWJo3shdeffnaLxASfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 22:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UySnB-0006Us-OI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 22:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab3GNUUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 16:20:55 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59433 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab3GNUUz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 16:20:55 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so10572132pab.24
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R6mYxPx3n1xr7tToAh5iCma7+/QV8jTm5mb3C6+v/0k=;
        b=GU5tsSnQvbU1QoUs8Ca1nBDjmQZHaPdQFJJv7D8s8aBhfZNEXhCxOj6nY8bdC2DWdp
         jPWBjidDYs7h6C0RncBpnkVTpnWaWBYYj9gSO+a6IJUCAQ7uVXHnP7dxMrTvpVr9Zlkl
         Lps+mrhkNLiq9XvfW8VcLwj+m2LDLKlb5CQEFOFphQvxBJuBD07aZFIcj/9KsYaWpPeS
         fhyeXowlppglZuVjwwo8sqpj424L0EdonViz2B5Fb3hGVz55cYypze0Gu94w7wu8J4EX
         Dgeq7mkeeXmZVL6xcROuDvNOddpSuXUTQ77DR2PKHSyU5XjznbdUEwUAxtL7DtYOCUec
         7hpA==
X-Received: by 10.66.141.71 with SMTP id rm7mr52776620pab.90.1373833254738;
        Sun, 14 Jul 2013 13:20:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id eg3sm60364798pac.1.2013.07.14.13.20.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 13:20:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAD77+gSE5GnTcrpoWO0bb2UysDE9t51EWJo3shdeffnaLxASfw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230387>

Richard Hartmann wrote:

>       fwiw, I replaced my one single echo with heredoc as you
> suggested I do that. I don't mind undoing that, or I can drop it from
> this series altogether.
>
> Guidance would be appreciated. :)

Thanks for your work, and no problem.

Both Junio's and my responses were about the (confusing and false)
commit message.  Code is not the only thing that matters when
submitting a patch --- commit messages become part of the product,
too, and are especially important as documentation that guides future
contributors.

So my advice is to fix the commit message, prepare improvements to
later patches in the series with help from reviewers where needed,
and then resubmit.

My review also included some advice about the code.  Naturally I
would be happy if that was of use, too. ;-)

Hope that helps,
Jonathan
