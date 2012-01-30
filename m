From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: i18n: Avoid sentence puzzles
Date: Mon, 30 Jan 2012 18:46:52 +0700
Message-ID: <CACsJy8CUXSSvToPrx9aW5a76BV=g7OTrWLZ2MQ6xDTpDSLpPeA@mail.gmail.com>
References: <201201301231.21090.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Frederik Schwarzer <schwarzerf@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrpho-0000UN-1y
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab2A3LrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:47:24 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61446 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab2A3LrX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:47:23 -0500
Received: by bkas6 with SMTP id s6so3076604bka.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 03:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HCbwPOA3gFDWaEs0/7mn6B2anUDQCExx1HEP7IEqZxM=;
        b=qgSTTajf1vzU8mLfVKjz1MxD7bGgdYghDo7Wul8m//u1F5kUeuSNOa9lQbrrsICQau
         IZJuh3rygSR4HoXTgpZG8s1K/38P27OKnxH4jq41+aS8LefC9gDI4iI7Ipnvi9jh6PI1
         YIUYTkBIeo1+Ox2Iq4wxUJQJmJL6zKF+p2k4c=
Received: by 10.204.157.17 with SMTP id z17mr8190567bkw.37.1327924042205; Mon,
 30 Jan 2012 03:47:22 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Mon, 30 Jan 2012 03:46:52 -0800 (PST)
In-Reply-To: <201201301231.21090.schwarzerf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189351>

On Mon, Jan 30, 2012 at 6:31 PM, Frederik Schwarzer
<schwarzerf@gmail.com> wrote:
> Hi,
>
> in order to enable translators to prepare proper translations,
> sentence puzzles have to be avoided. While it makes perfect sense for
> English, some languages may have to separate those words to sound or
> even be correct.
>
> The attached patch demonstrates a change to achive that.
> ...
> So my question would be: Is it considered worth it to extend the code
> for translators' and translations' sake? If so, I would be glad to
> help with that.

As a translator (though not git's because my time is limited and GUI
apps have my priority), I completely agree and support this. There are
other places where a sentence is broken down into many short phrases.
It's hard for a translator to find a good translation in such cases.

I remember there was also a patch about "1 file vs 2 files" in diff
summary, which was rejected because it would break scripts. I think
grammar patches should be allowed at least for interactive use (i.e.
either pager is on, or std{out,err} is tty).
-- 
Duy
