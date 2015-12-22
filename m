From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Define the term shallow clone.
Date: Mon, 21 Dec 2015 22:12:03 -0500
Message-ID: <CAPig+cR5_ybQ_gODu6iusXxib2ZEOfjYJ2RCe3qwh6LCF5Yw3A@mail.gmail.com>
References: <1450750180-1811-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Tue Dec 22 04:12:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBDMw-0007tK-8W
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 04:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbbLVDMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 22:12:06 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33554 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbLVDMF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 22:12:05 -0500
Received: by mail-vk0-f47.google.com with SMTP id a188so112405879vkc.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 19:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tNSoyowNYiX6Ui0W9Z+twXbuWltg5TV32heDnYTZL38=;
        b=fy/TcJMPtqfByHz/5qubHaziXUUnFqfI1O9uNWuqfXpgASSirPVCuu+gDA6WlNm/8R
         KXNdKzuS2TzMz1cIpw7mQDl9HhAgf/hC+7m9LtOmyAfBBL3buAKWs4krmOqdF4eQ/fUr
         RrFHRKZz5TBwAilQj4mkgQ2WHodj/QvtCunjgGHdSuI5yFmcAi0jMgNIOkIso5ggObFB
         lp7TSTydOf58/PxlDLiK8vtQIPOFvVNDUD6CW4Ikfhxa0vC1M8aZne9qVo6MP61UGMKi
         xptrDTKWeh3fGRTHMsXgfoJRZviSAG6qkzA6ywVVRGYssO1FENDPOInyaFHj42BL212z
         UQZQ==
X-Received: by 10.31.47.130 with SMTP id v124mr14353540vkv.117.1450753923471;
 Mon, 21 Dec 2015 19:12:03 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 21 Dec 2015 19:12:03 -0800 (PST)
In-Reply-To: <1450750180-1811-1-git-send-email-ischis2@cox.net>
X-Google-Sender-Auth: hd0qU62S6BJUy3CWPif3Q9JYd-U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282830>

On Mon, Dec 21, 2015 at 9:09 PM, Stephen P. Smith <ischis2@cox.net> wrote:
> There are several places in the documentation that
> the term shallow clone is used. Defining the term
> enables its use elsewhere with a known definition.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> @@ -531,6 +531,10 @@ The most notable example is `HEAD`.
>         "Secure Hash Algorithm 1"; a cryptographic hash function.
>         In the context of Git used as a synonym for <<def_object_name,object name>>.
>
> +[[def_shallow_clone]]shallow clone::
> +       A clone of a <<def_repository,repository>> which creates a
> +    <<def_shallow_repository,shallow_repository>>.

Botched indentation on second line of definition. Use tab rather than spaces.

>  [[def_shallow_repository]]shallow repository::
>         A shallow <<def_repository,repository>> has an incomplete
>         history some of whose <<def_commit,commits>> have <<def_parent,parents>> cauterized away (in other
> --
> 2.6.3.368.gf34be46
