From: Akshay Aurora <akshayaurora@yahoo.com>
Subject: Re: [GSoC microproject help] Allow "-" as a short-hand for "@{-1}" in
 more places
Date: Sat, 7 Mar 2015 02:13:04 +0530
Message-ID: <CAPGnZZ=12707HPSfGmqSMohdoT4h+Y13+vBGT6AX_Syr4Onx8w@mail.gmail.com>
References: <loom.20150306T210409-558@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 21:43:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTz5S-00088e-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 21:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbbCFUnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 15:43:07 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:39047 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbbCFUnF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 15:43:05 -0500
Received: by wesu56 with SMTP id u56so18327181wes.6
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 12:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4TmCwCqUVqwPp+VCwScN92CWo/CA8+p8hWwgP2lMy2U=;
        b=L6HO4QpVC4DHgnwqMBdw6chwcEaeJoqbniXO9fXdaw/zgGOU72im48qtwtMbxqAK9Z
         LwSkUqmzOt31Skj+j5plNDj2bx8sdgMnWQOXIObGXSuehjJb6vuxkQj9mf+u9HEbORR+
         zEMbXr1uAdtLWK7Jphtu7qA1F5eq/xOPfSScnIVa5foweUFb0Yt4f0JKyxPO0wKyV6E9
         S9q0aDWEUjrVCExTcNC4wjpdczJPwgYqELtwbphnUBf/zlrK4FTLfi9GaH6bSVq3zdsd
         zjEX4W86JyF2n4emEiPkGBSrd9UeyIzuiiUEuSPGyeTOlOS9MAHcbxT1UTtSZm11e3Il
         m0oQ==
X-Received: by 10.180.75.233 with SMTP id f9mr7846344wiw.5.1425674584113; Fri,
 06 Mar 2015 12:43:04 -0800 (PST)
Received: by 10.27.45.1 with HTTP; Fri, 6 Mar 2015 12:43:04 -0800 (PST)
In-Reply-To: <loom.20150306T210409-558@post.gmane.org>
X-Google-Sender-Auth: Jjg1ok_eExJFx06Zzt8pearfxDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264959>

Hi Sundararajan,

Welcome to Git Community.

You need to look for commands dealing with branches, and allow  '-' as
shorthand for @{-1}.

You can look at patches already sent for this microproject. One of the
students has already started working on git reset command [0].

Junio, has raised some key issues you'll need to tackle on that
thread. Hopefully it should get you started.

Make sure the existing tests pass after making changes. You might also
need to add a new test case for your microproject.

[0] - http://thread.gmane.org/gmane.comp.version-control.git/264688

On Sat, Mar 7, 2015 at 1:35 AM, Sundararajan R <dyoucme@gmail.com> wrote:
> Hi All,
>
> I am a sophomore at Indian Institute of Technology Kanpur and am a GSoC
> aspirant for git. Although I have been using git from a long time, this is
> the first occasion when I have picked up reading its source code. Can
> somebody please help me by telling me how to start off with the above
> mentioned microproject?
>
> Thank you very much.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
AA
