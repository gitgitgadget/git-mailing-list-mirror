From: John Szakmeister <john@szakmeister.net>
Subject: Re: Credentials and the Secrets API...
Date: Sat, 9 Feb 2013 05:58:47 -0500
Message-ID: <CAEBDL5VQxhnL+wdkf_5=MmG4ptBr4TFyyAvbMWxRom9SRxJ6Lg@mail.gmail.com>
References: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
	<87halochci.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 11:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U489P-0006dO-SL
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 11:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab3BIK6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 05:58:49 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:58929 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab3BIK6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 05:58:48 -0500
Received: by mail-qa0-f42.google.com with SMTP id cr7so647003qab.15
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 02:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=R16tAooEfp8dDv0xRh2kEJiK/cjuf8sgVQMSxi0u/FA=;
        b=hrdXVqQhsWPQHknFuBXjsXAZGQkFfaON6sJAbXly0QJPSb1pZoxJj/9MiBDx3F/pKd
         2JjQzm/ki8Wd51AVNQN55kJvvWf/5CxkkKPtMZ5nesQcfAkcU+ZTQGk11vOcieZg68/P
         0UgQitzav/9DXDW+y7rKd72sNZma7MtSJ92aF421I1ttad+jGNwCb9k3neeltDuE3kra
         Ju0qNpAcQpIy2WyTld+/0HiXe3jSF2JXSvpbF7xJ9+ok2CKi8ZdjjahPORPUjPgE307Y
         hBiYh0K9Ekbv+aEXo7u2kx6+aKMnbYx1HVZQD098KBTLmuSWM03NgeWtJSN7KCbn5pSY
         joiQ==
X-Received: by 10.49.108.9 with SMTP id hg9mr3396956qeb.34.1360407527912; Sat,
 09 Feb 2013 02:58:47 -0800 (PST)
Received: by 10.49.120.102 with HTTP; Sat, 9 Feb 2013 02:58:47 -0800 (PST)
In-Reply-To: <87halochci.fsf@lifelogs.com>
X-Google-Sender-Auth: mQqQ3tsl_cSdybnMHB-FgOq57Gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215857>

On Thu, Feb 7, 2013 at 9:46 AM, Ted Zlatanov <tzz@lifelogs.com> wrote:
> On Thu, 27 Oct 2011 12:05:03 -0400 John Szakmeister <john@szakmeister.net> wrote:
>
> JS> Just wanted to keep folks in the loop.  It turns out that the Secrets
> JS> API is still to young.  I asked about the format to store credentials
> JS> in (as far as attributes), and got a response from a KDE developer
> JS> that says it's still to young on their front.  They hope to have
> JS> support in the next release of KDE.  But there's still the issue of
> JS> what attributes to use.
>
> JS> With that information, I went ahead and created a
> JS> gnome-credential-keyring that uses Gnome's Keyring facility.  I still
> JS> need to do a few more things (mainly run it against Jeff's tests), but
> JS> it's generally working.  Just wanted to keep folks in the loop.
> JS> Hopefully, I can get patches out this weekend.
>
> Do you think the Secrets API has matured enough?  KDE has had a new
> release since your post...

Yes, I think it has.  Several other applications appear to be using
it, including some things considered "core" in Fedora--which is a good
sign.

-John
