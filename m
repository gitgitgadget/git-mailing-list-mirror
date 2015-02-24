From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 15:58:25 +0700
Message-ID: <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:59:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQBKW-0005mU-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 09:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbbBXI64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 03:58:56 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41007 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbbBXI64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 03:58:56 -0500
Received: by iecrd18 with SMTP id rd18so30283823iec.8
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dhCBLxdV4+oUWWyyue2hsuGg9QVV9XkI4DI+7RCx8NM=;
        b=hJQmOJbHMm3MxwiUuqVpR/iNEHOIjMkLSHDCjQ+Cpf2rcXCcy1FpYu2PCc2JVvxLJ0
         n07A3FQ1Wig86T4P3UiSZdcf0oj9NojERs+jKtesAo8DbWPeCvgOm+CbfrDwLLuYtiVA
         8oFMLQh0KXgo/oIqT6Du3xsrcakQU2h8vlr757anXrnspPTvFI97EH5sOupOT21Fc3Wk
         D3m0KjD51VQtR2xunRYMEq6TVNOc9W18Z4N5AC7lR2Fm5uoVIgbGZGW8W4ALAZISTzM6
         xOy6cxjyRmTnhyLD/6SPl4lhsYObtkmSq8orx7muawrhTYKlhXAcu3h6nJPWeTz5TQX0
         ZnxQ==
X-Received: by 10.107.11.140 with SMTP id 12mr19156011iol.5.1424768335545;
 Tue, 24 Feb 2015 00:58:55 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Tue, 24 Feb 2015 00:58:25 -0800 (PST)
In-Reply-To: <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264313>

On Tue, Feb 24, 2015 at 3:08 PM, Guilherme <guibufolo@gmail.com> wrote:
> Hello,
>
> I have already posted this to the users mailing list but i guess it's
> more appropriate to have it here.

Related thread about relicensing wildmatch.c for tss

http://thread.gmane.org/gmane.comp.version-control.git/259764/focus=259798

>
> ---------- Forwarded message ----------
> From: Guilherme <guibufolo@gmail.com>
> Date: Tue, Feb 24, 2015 at 9:02 AM
> Subject: Copyright on wildmatch.c
> To: "git-users@googlegroups.com" <git-users@googlegroups.com>
>
>
> Hello,
>
> I'm trying to implement support for gitignore files in
> the_silver_searcher (https://github.com/ggreer/the_silver_searcher).
> It is a source code optimized version of grep. And it is way faster
> than ack.
>
> The problems at hand is that I'd like to use wildmatch.c and some
> dependencies (hex.c, some portions of compat-util.h) but it seems that
> git is GPL whereas tss is Apache2 licensed.
>
> Is there any possibility to re-license the files above to Apache2 for
> the TSS project?
>
> If not, is there any c library that provides support gitignore patterns?
>
> Thank you very much,
> Bufolo
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
