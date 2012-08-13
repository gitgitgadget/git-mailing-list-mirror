From: Christopher Marshall <christopherlmarshall@gmail.com>
Subject: Re: git svn clone, a non-standard layout question
Date: Mon, 13 Aug 2012 13:27:05 -0400
Message-ID: <CANW+GuQ4ZkOySSXN38ot7f=BR1SbXs8d7UvGVmuMDcPSUUzxGQ@mail.gmail.com>
References: <CANW+GuQ=egge=NcdSakChYXXZkW=MsG9f3i9yNvoutXXVFcPzQ@mail.gmail.com>
	<20120813063132.GD10899@m62s10.vlinux.de>
	<CANW+GuRoQJtZW6ZCwDQEj9OQD4C3BqxqX--2JV+=jkddagQgig@mail.gmail.com>
	<20120813133847.GE10899@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:27:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0yQ6-0006D0-2l
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab2HMR1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:27:08 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54920 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2HMR1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 13:27:07 -0400
Received: by weyx8 with SMTP id x8so2690002wey.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0DPuJANngqFrhTLG6nAlCgLtVmW9GGbuANix5io14sA=;
        b=dWmpCveUp6faj/lxE8SDsrvxV1+DWE6mUj0cSibGXuvCOLEajZcsJOlv+U+x8odoj+
         GAVgna9sWc3/IE4rf+11GM2Y93kMOps4kLv9RSXi99YOI4LtOMNsZGagK6YI/9Qz2IF2
         28c1DURBLN2Dk98A14r4Fal4rWDEoUjGfTDjgYUjXEdLYDkNcZGtIzpji4OycXK6OgAv
         xxqvVOBlMdv44B4KlQkJgqE8q5/eHV8P4l/s2fvHv7lps+KdVQDZjUeaWbr0uy3KMyKB
         WKA4ZYKhl8543yNtC8tve2ph9s59Lxs+sTSoMKIGhDKCFWTKFye1srbv4hXCxRRdmiPc
         htZQ==
Received: by 10.217.6.14 with SMTP id x14mr6329082wes.174.1344878825388; Mon,
 13 Aug 2012 10:27:05 -0700 (PDT)
Received: by 10.194.34.34 with HTTP; Mon, 13 Aug 2012 10:27:05 -0700 (PDT)
In-Reply-To: <20120813133847.GE10899@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203347>

>> [svn-remote "svn"]
>>         url = file:///home/chris/programs/svn/repo
>>         fetch = trunk:refs/remotes/svn/trunk
>>         branches = branches/*:refs/remotes/svn/*
>>         tags = tags/*:refs/remotes/svn/tags/*
>>         branches = branches/bdir/*:refs/remotes/svn/bdir2/*
>>         ignore-paths  = ^branches/bdir$
>>         ignore-refs  = ^refs/remotes/bdir$
>>
>> It doesn't seem to change anything.
>>
>
> You need a git version new enough to include cdb51a13c3cf4830d499d1138160eacdd2b8aa46, otherwise
> it won't have any effect and will be silently ignored.
>
>> Chris
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

Peter:

I see what you mean.  I will download a version of git that includes
that commit and try again.

Thanks for all your help,

Chris
