From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] Documentation/config.txt: document mailinfo.scissor
Date: Fri, 20 Feb 2015 12:11:48 -0500
Message-ID: <CAPig+cToo3+JKAuxiCraPWD61eHw5W+xY=8H1UuWiy-8RtEAPQ@mail.gmail.com>
References: <1424426947-26441-1-git-send-email-Matthieu.Moy@imag.fr>
	<1424428143-641-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOr7K-0004e3-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 18:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbbBTRLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 12:11:50 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:51897 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbBTRLt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 12:11:49 -0500
Received: by mail-yk0-f175.google.com with SMTP id q200so7791197ykb.6
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 09:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jop8dN9mghut2/z+MUdwQozDKWf2hXoacsn5nnpX434=;
        b=EyrH/8jMR5LkGyZNDr45aVlkVyOjdcsv6GyT5gwmjtDeJIYX39mreXdvc89Ooj8oZN
         1/sQJFtQQEcL9tYxrRM+y7bJPd1RWkt1TrbtjdVo7XDwv1Pzk8WzO/nluxx92Rdnkeny
         Gmtue84VfucTng5PLZTjN1UdlHExOC2Z75v5Dtvflce2PlmxLZmBOfjjjRquKvwgg7tS
         IS9X5c8YVW9NcgCNkUfa69k9R8s17a4vsh6YZ6nESW3B6iG/U+37loQTwNvl4dH93Yom
         BEVJSJ40BTA925ZJY+22v5RY+amn1ptUhJkYS96zqUKErGfaWKO3WTOcIv8Ai5zpsgzW
         nGFw==
X-Received: by 10.236.105.210 with SMTP id k58mr7688264yhg.52.1424452308927;
 Fri, 20 Feb 2015 09:11:48 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 20 Feb 2015 09:11:48 -0800 (PST)
In-Reply-To: <1424428143-641-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: Rdfb25-ae-0kZBxqyJ2ZBwgBaYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264173>

On Fri, Feb 20, 2015 at 5:29 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Subject: Documentation/config.txt: document mailinfo.scissor
>
> The variable was documented in git-mailinfo.txt, but not in config.txt.
> The detailed documentation is still the one of --scissors in
> git-mailinfo.txt, but we give enough information here to let the user
> understand what it is about, and to make it easy to find it (e.g.
> searching ">8" and "8<" finds it).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Changes since v1 for both patches : typos noted by Peff.

The same typo (s/scissor/scissors/) exists in the subjects.

>  Documentation/config.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ae6791d..15f8695 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1740,6 +1740,13 @@ log.mailmap::
>         If true, makes linkgit:git-log[1], linkgit:git-show[1], and
>         linkgit:git-whatchanged[1] assume `--use-mailmap`.
>
> +mailinfo.scissors::
> +       If true, makes linkgit:git-mailinfo[1] (and therefore
> +       linkgit:git-am[1]) act by default as if the --scissors option
> +       was provided on the command-line. When active, this features
> +       removes everything from the message body before a scissors
> +       line (i.e. consisting mainly of ">8", "8<" and "-").
> +
>  mailmap.file::
>         The location of an augmenting mailmap file. The default
>         mailmap, located in the root of the repository, is loaded
> --
> 2.3.0.157.g79e124b
