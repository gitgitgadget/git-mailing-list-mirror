From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] compat/regex: fix typos in comments.
Date: Sun, 6 May 2012 22:40:20 +0900
Message-ID: <CAFT+Tg8fvVawnCFwmXfBep1b+uonEB7J3eA3wJDMVSRcaXHMAQ@mail.gmail.com>
References: <1336308300-4858-1-git-send-email-semtlenori@gmail.com>
	<CACBZZX4K5vh7CjJ6SqX-reuuNqse7koONC=1HcXCuY0vbXRpbQ@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 15:40:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR1hJ-0006cD-WE
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 15:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab2EFNkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 09:40:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61821 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab2EFNkU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 09:40:20 -0400
Received: by obbtb18 with SMTP id tb18so6842242obb.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=GsGvlbjG9iHbUm0ufxF78VoaNzkoShCck7TuWiS4zG4=;
        b=cpOTdvO7Ep4bhNrmj0bunvlJIbfLYgKzIr4VgvL9W758pJfKtzf9to7lD2Yh+EIVDi
         fxxKEM67MX6mwbeAh7AL2qb/y6wZjNgc1FdNQp9iAyyDqrDy5t172wG/nrG16rmqMbnJ
         oNWwcWQyr21dBkyk5glp3jq8jmqtNo5PRuSbChWu57ADohKvfQwLxdBWAFjMsM3bZHAx
         5Pe4hdD47Eseah+XO0i3WsvySN11Z/2wQQlXzOwmeYEfoD4RRUm0PaF/BYGpV7hT3KOc
         hvMiuwI/YaC59L0Gv5G7aCYQXlyu01rwfIN678pdkgAPi7yy7bm/Z1O5sWFnNaqTdO1I
         hMgg==
Received: by 10.60.32.204 with SMTP id l12mr11344837oei.47.1336311620330; Sun,
 06 May 2012 06:40:20 -0700 (PDT)
Received: by 10.182.53.98 with HTTP; Sun, 6 May 2012 06:40:20 -0700 (PDT)
In-Reply-To: <CACBZZX4K5vh7CjJ6SqX-reuuNqse7koONC=1HcXCuY0vbXRpbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197186>

You're right. I will send this patch to gawk developers.

Thanks to your advice!

2012/5/6 =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>:
> On Sun, May 6, 2012 at 2:45 PM, Yi, EungJun <semtlenori@gmail.com> wr=
ote:
>> From: "Yi, EungJun" <semtlenori@gmail.com>
>>
>> occured =3D> occurred
>
> In d18f76d I changed compat/regex to use the engine from gawk, there
> have been a few fixes of ours to it since then, some of which may be
> applicable for upstream inclusion:
>
> =A0 =A0$ git --no-pager log --oneline --reverse d18f76d.. -- compat/r=
egex
> =A0 =A0a997bf4 compat/regex: get the gawk regex engine to compile wit=
hin git
> =A0 =A0de83172 Change regerror() declaration from K&R style to ANSI C=
 (C89)
> =A0 =A0b50f370 compat/regex: define out variables only used under RE_=
ENABLE_I18N
> =A0 =A0178b331 compat/regex: get rid of old-style definition
> =A0 =A0ce518bb Fix compat/regex ANSIfication on MinGW
>
> But I don't think we should be taking patches like these. I think the=
y
> should instead be sent to the upstream gawk developers who I'm sure
> would be happy to take them.
>
> But this is not code that we're maintaining, and patches like these
> just make it harder to merge the code from upstream.
