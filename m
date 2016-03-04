From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 3/3] Documentation/git-pull: document --[no-]autostash option
Date: Fri, 4 Mar 2016 23:56:21 +0800
Message-ID: <CACRoPnT1BsddXC9oqODkxHb==coKU6EKQiijk9=T0HYTFeCZVQ@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-3-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 16:56:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abs5b-0002AZ-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 16:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbcCDP4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 10:56:24 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36488 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbcCDP4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 10:56:23 -0500
Received: by mail-lb0-f196.google.com with SMTP id gn5so5316353lbc.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 07:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3NfSqiFtELWpsVBB6gxlte59hEFelM6rjkfqu8MAu+Q=;
        b=k2xIDqYTHZcUJ/aauQawVDMpihadL64q+Opj8FUbfxMXLlWcyKEUUmshYk7fENgpW1
         WQyHkAitXgzn8dDMnI3jHr1j4dDCw5x7mmRqnsIAabl8qfL9dpWDuNIGPtN1viRwuRLN
         yJMqQZnv85biElkCVDxx0ahgL2FtWw9/S80cy5CnAWFFNcKZ452uyNVhHAhHAyySNFx+
         k9Xi3VZ9QvyIDzWYtZk0016AFO5W4oY2NT8ddH07QyIOHrV9/qtv86Uyfu/Td3m/Q3mM
         UIM+UTdxyERBeYnzwEHY4T+LCfEOAk9HduSAmDdCVUuyRipUbrjlwbyH8XaCFQcxcqI1
         emBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3NfSqiFtELWpsVBB6gxlte59hEFelM6rjkfqu8MAu+Q=;
        b=hGgrHwGc1sZepSWQi2JXRlTUxtyMpHI33VUqwZFC1GDzT4TTC33YetpPjW8bPgqYaA
         LFXWJwgayIIgTAuACE3eblxZsyr3zIONEWl5r0wnpGF7nk37KiY1OyuJYB2JissKNbMU
         5FiJcDHIxxx9NlckuJsDoPbDsYmzGYybAuN+Zg1grg6YAvijbI56w5MFIKQ5g7LYUJ70
         Zpv6u2Es0IrvpBoAEgbay3oTYqcpxlHdLSGvSlFdRmxE/0sbSGehHSCtQGEJKym2zYDN
         GHrtdxaSDbB1BtrPcDf2mQ9X90klo3P1cOiSNlehI/6gW0VD2aBF/YywW7t8ypevwEhh
         /pFA==
X-Gm-Message-State: AD7BkJJo5/Zmc4VloD3gUJqQB1+URfBeuvC6TK1vPJ/wtSYzxvRMbo4uDJsID8l7do8iPQlLUS4FtPYKMXvjsQ==
X-Received: by 10.112.128.225 with SMTP id nr1mr3182059lbb.101.1457106981715;
 Fri, 04 Mar 2016 07:56:21 -0800 (PST)
Received: by 10.112.207.74 with HTTP; Fri, 4 Mar 2016 07:56:21 -0800 (PST)
In-Reply-To: <1457021601-9099-3-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288261>

On Fri, Mar 4, 2016 at 12:13 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  Documentation/git-pull.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index a62a2a6..a593972 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -128,6 +128,21 @@ unless you have read linkgit:git-rebase[1] carefully.
>  --no-rebase::
>         Override earlier --rebase.
>
> +--autostash::
> +--no-autostash::
> +       Automatically create a temporary stash before the operation
> +       begins, and apply it after the operation ends. This means
> +       that you can run rebase on a dirty worktree.
> ++
> +This option is only valid when '--rebase' option is used.
> ++
> +The default is --no-autostash, unless rebase.autoStash configuration

By the way, there is a trailing space on this line.

> +is set.
> ++
> +[NOTE]
> +Use with care: the final stash application after a successful
> +rebase might result in non-trivial conflicts.
> +
>  Options related to fetching
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.7.1.340.g69eb491.dirty

Regards,
Paul
