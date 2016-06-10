From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] Fix spelling of "occurred"
Date: Sat, 11 Jun 2016 00:21:54 +0530
Message-ID: <CAFZEwPMgYCau=LxdtjZ2WVJXp91mXYG5bc=0X0mo_eJ+eYqLHA@mail.gmail.com>
References: <1465568551-5819-1-git-send-email-peter@colberg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Peter Colberg <peter@colberg.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 20:52:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBRXE-0001tD-Gl
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 20:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbcFJSv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 14:51:57 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35396 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcFJSv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 14:51:56 -0400
Received: by mail-yw0-f178.google.com with SMTP id z186so56265471ywd.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SlPjUcvxkorqjwUioVF792g1CVDEKcC0dgG/Yty2rmg=;
        b=MFhdTKZsFHIy/TMviWFFQaIDWXQIBxv3CJ7O6EbaqUgr/4BY83Vni1SIP9qXaiVLwV
         uHdwSN144L7+JFwpr58biVflg8COVXE2XILSz8IM5Ba5jqY0fAF9vUpW86wL3Feo91bg
         n6m9XS3qbKyi6sy21sUxqv8ONpSSQsYEQfQlPrJ1yY8Xw+3w2KAxknVp4HBnvZdMCEUE
         KTHGSj5aPKz3eB4vASptlvCwvvj65O3tHlO/0aCYUnRpEB9N4Ueubtu0Tgg6dy99KbNz
         UOWC6UlBk5QUPLmBabH8AEh6+8yiGJHPOUPSRG6zy/nUvyEv3YkBlh8JCPgJ3RfaaZwH
         GC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SlPjUcvxkorqjwUioVF792g1CVDEKcC0dgG/Yty2rmg=;
        b=d5L6NbmteaKSuXs4lIMgj04Y5+aqVopIvl9o3fN4cFfxjPocjgjFWBQxUANKIBJN8x
         ULn5dLaYqe8yURzlpIRLXDKCKkEzYxah9WH3NRAkpu9naXl2Uto0JJ6i4Z47in97UJZl
         uh39Hism7jLvo1rIYOJOaU/RauHJCFEkyZs9y2G9Wj6du6xSOcsbZtWmZyXDxdlpvUPZ
         laBcjC6i0mYoUqVhO06Y+baNqopeDpBpEcVEqvxFIh7sfqUWZS+nyZ/AnR3fOYGqn1HR
         qRVSU7qSDrTQf/WydRYTzc6Wxc+15+JDHvPjn1hYhEWkD66XFWQ3avtcYPQGgXZ/aJly
         EJcA==
X-Gm-Message-State: ALyK8tJI7uy0AIdNYMwpBpjD1ftp97mUX7hJ4l9+eE41sFocCwaRvjasIUjXbvaG/do2/0Dqi23y8hsIXip6Nw==
X-Received: by 10.129.134.133 with SMTP id w127mr1837422ywf.252.1465584715255;
 Fri, 10 Jun 2016 11:51:55 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Fri, 10 Jun 2016 11:51:54 -0700 (PDT)
In-Reply-To: <1465568551-5819-1-git-send-email-peter@colberg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297016>

Hey Peter,

On Fri, Jun 10, 2016 at 7:52 PM, Peter Colberg <peter@colberg.org> wrote:
> Signed-off-by: Peter Colberg <peter@colberg.org>
> ---
>  config.c    | 2 +-
>  po/bg.po    | 2 +-
>  po/ca.po    | 2 +-
>  po/de.po    | 2 +-
>  po/fr.po    | 2 +-
>  po/git.pot  | 2 +-
>  po/ko.po    | 2 +-
>  po/pt_PT.po | 2 +-
>  po/ru.po    | 2 +-
>  po/sv.po    | 2 +-
>  po/vi.po    | 2 +-
>  po/zh_CN.po | 2 +-
>  refs.h      | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> ...[snip]

You only have to change the spelling mistake in config.c and refs.h .
Our translators take care of everything else.
Thanks for your contribution.

Regards,
Pranit Bauva
