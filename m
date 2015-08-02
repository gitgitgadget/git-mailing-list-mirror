From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 1/1] po/README: split out the different contribution types
Date: Mon, 3 Aug 2015 00:05:46 +0800
Message-ID: <CANYiYbFvackgJnqR4yahUPT2zE-kTAhQJnvzeUp-FsC-U24-dw@mail.gmail.com>
References: <1438522955-6076-1-git-send-email-philipoakley@iee.org>
	<1438522955-6076-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 18:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLvlo-00053Z-UF
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 18:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbbHBQFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 12:05:49 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34644 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbHBQFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 12:05:48 -0400
Received: by lbqc9 with SMTP id c9so41817393lbq.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9vI0LkS2InQUM4ji7lf9EUuV7zp/bHnGks0Cqmlm810=;
        b=Vp6zGK7dn17pf4YTtPUn1BCA/1QsEnU0uQahhwy+IddC5DFjq9lqTR5FQnnqMZLpgh
         sZ2eb5DbOZ2yOvVRS0aM3OJ3NRpT5WQkpkuTltmupHBM1f8rooDlwEIN5c5mVvsSDerC
         iMZGmFywmT56eHSC5uATD1rL8BIuGaxe/xUvsuDLp+iv6omEx3ljp0zrSmgtYbpeeTBd
         r5ikfoUfQqZtL9nBK0OMcCtJ5fzSiOaOgZBvthJefRHaxLbYoxT3/vntAYoRx5mYrerA
         GXaNtD6dfcvgsJ6oHqGst/NoM6LHvOikzqPPqJhkMdG7qe83Y0OE22q+P83tuQnqq2TQ
         kJcw==
X-Received: by 10.112.185.100 with SMTP id fb4mr12895852lbc.79.1438531546464;
 Sun, 02 Aug 2015 09:05:46 -0700 (PDT)
Received: by 10.152.132.7 with HTTP; Sun, 2 Aug 2015 09:05:46 -0700 (PDT)
In-Reply-To: <1438522955-6076-2-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275142>

2015-08-02 21:42 GMT+08:00 Philip Oakley <philipoakley@iee.org>:
> Separate out the three different contribution styles for existing, new,
> and wider mis-translation contributions, with suitable headings for easy
> reference.
>
> In particular highlight the appropriate action should a Git
> mis-translation be from a different distribution. i.e. initially report
> to that usptream, but also consider if it could be coordinated here.
>
> While here, add surrounding headings, and reference the lanaguage codes.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  po/README | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/po/README b/po/README
> index d8c9111..b54b3c6 100644
> --- a/po/README
> +++ b/po/README
> @@ -10,19 +10,43 @@ coordinates our localization effort in the l10 coordinator repository:
>
>          https://github.com/git-l10n/git-po/
>
> +The two character language translation codes are defined by ISO_639-1, as
> +stated in the gettext(1) full manual, appendix A.1, Usual Language Codes.
> +
> +
> +Contributing to an existing translation
> +---------------------------------------
>  As a contributor for a language XX, you should first check TEAMS file in
>  this directory to see whether a dedicated repository for your language XX
>  exists. Fork the dedicated repository and start to work if it exists.
>
> +
> +Creating a new language translation
> +-----------------------------------
>  If you are the first contributor for the language XX, please fork this
>  repository, prepare and/or update the translated message file po/XX.po
>  (described later), and ask the l10n coordinator to pull your work.
>
> +
> +Reporting mis-translations
> +--------------------------
> +First, confirm that your language translation is managed by this group.
> +Initially any translation mistake should be reported to the appropriate
> +upstream team. If not managed by this group, and the translation has a
> +suitable licence, consider suggesting that the translation could be
> +included here (see 'new language translation' above).
> +
First, find the right place to report.  If there is a YourLanguage.po here,
and you can find the bug in it, then here is the right place for you to
report.  But if not, maybe your Git distribution (such as from Ubuntu)
may have its own l10n workflow, and not work well with our git
upstream. For this case, you should report bug to them...

(I'm not a native English speaker, so correct me)

> +
> +Forming a Team
> +--------------
>  If there are multiple contributors for the same language, please first
>  coordinate among yourselves and nominate the team leader for your
>  language, so that the l10n coordinator only needs to interact with one
>  person per language.
>
> +
> +Translation Process Flow
> +------------------------
>  The overall data-flow looks like this:
>
>      +-------------------+            +------------------+
> --
> 2.3.1
>

-- 
Jiang Xin
