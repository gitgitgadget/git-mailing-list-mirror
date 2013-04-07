From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] remote-helpers/test-bzr.sh: do not use grep \s
Date: Sun, 7 Apr 2013 05:04:05 -0400
Message-ID: <CAPig+cQVcD_Ba2ZPvi0=GcBVhn_eHQeeAukm427kK=AnDSpMow@mail.gmail.com>
References: <201304071048.31790.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 11:04:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlWG-0003h4-Mr
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 11:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950Ab3DGJEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Apr 2013 05:04:08 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36494 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949Ab3DGJEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 05:04:07 -0400
Received: by mail-la0-f52.google.com with SMTP id ej20so314427lab.39
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ADRsWB4ms24kCMPmUNCnsB8fKH3dXW55TS68LmEEjvo=;
        b=jGMlbffLcGDUtghDHfWqkTMTgpvh1SygdoUvPFWUGikwvLgsAiYjAptRe3AFx1qExy
         PfJhzS4k7oYck/cqzoP+mtnQuwC/pl0uff7GzyQ/LThXhEOUB2CBJkUVWgXCSz9If0X7
         lVH1UyVbQLN3OX9PisLQKtRIEBluYMPBbvDDzGW9CRonMAta/f6NkgCJGrhJdrMjaqhm
         eQwJlKmyz/gRQyD3/0oqSkVo5XafVFdjCARaFQ5ev0tmLwstpU41uXazdR4HPnWyvJWX
         8jIbgLVny0fYyhSunaxWs98y4qvwTqfqWxpRi9QGHP7P9kstJIQH4iN0xtiwZ9etZci1
         wTrQ==
X-Received: by 10.112.151.5 with SMTP id um5mr9243784lbb.120.1365325445929;
 Sun, 07 Apr 2013 02:04:05 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 7 Apr 2013 02:04:05 -0700 (PDT)
In-Reply-To: <201304071048.31790.tboegi@web.de>
X-Google-Sender-Auth: pGL1tEj6dk2ZQg9j7W19a_Sksoo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220302>

On Sun, Apr 7, 2013 at 4:48 AM, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
> Using grep "devel\s\+3:" to find at least one whitspace

s/whitspace/whitespace/

> is not portable on all grep versions:
> Not all grep versions understand "\s" as a "whitespace".
>
> Use a literal TAB followed by SPACE like this [  ] instead.
> The + as a qualifier for "one or more" is not a basic regular express=
ion:
> use egrep instead of grep.
>
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
