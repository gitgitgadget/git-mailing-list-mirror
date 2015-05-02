From: Josh Hagins <hagins.josh@gmail.com>
Subject: Re: multiple source file extensions
Date: Fri, 1 May 2015 20:49:14 -0400
Message-ID: <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 02:51:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoLee-0005DB-OU
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 02:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbbEBAvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 20:51:14 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33960 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbbEBAtp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 20:49:45 -0400
Received: by ykft189 with SMTP id t189so21637095ykf.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4OM81KNYDTTUZYqudMNZ7AQHtUIv0G3JrrSmmedW7Hk=;
        b=O+epJtrRrTV0QM0Ki8pXOglxZcEB/xFCUu94TT9/B0KY1MCPz2J9MJ2MbW8SLjCt2P
         TADjYiVU9gU2NvQFkpFtSVEnLIOPDlSC8m81gulDbBZoA25Xakx8xr0xgmtT3rLTTncl
         wToi06ySV+2SSsio8Pp5lTvyfgsfLoUvNX2qN0ErE2DnACqhtRShTlFm6SWmLTyD0Dlp
         OrBTDyqZzjeukxE1R3wlED0TWxTJTV1dPKvt+6v1kw69koQg9I4tRjZvRFaFD9+etTeT
         p7dmodaCZlRpIa38fBIs+6KUgNEPY5nVNpmyadnRyl+oHBdquFDk5BMCdlwqVY7QOpZP
         NW4Q==
X-Received: by 10.236.19.100 with SMTP id m64mr807427yhm.168.1430527784725;
 Fri, 01 May 2015 17:49:44 -0700 (PDT)
Received: by 10.13.245.129 with HTTP; Fri, 1 May 2015 17:49:14 -0700 (PDT)
In-Reply-To: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268204>

If you're using a recent version of bash, you could enable the
'globstar' option:

    $ shopt -s globstar
    $ git grep 'pattern' **/*.{cc,cpp,h}

Does that work?

On Fri, May 1, 2015 at 8:40 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> Hey!
>
> How do I tell 'git grep' to search only in .cc, .cpp and .h files?
>
> From http://gitster.livejournal.com/27674.html it seems possible to do
> some filter, but in this article grep is told to search only in C
> source files.
>
> Bye!
>
> --
> Thiago Farina
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Josh Hagins
College of Engineering
Cornell University '14
(843) 847-6008
