From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Requirements for integrating a new git subcommand
Date: Fri, 23 Nov 2012 21:21:46 +0100
Message-ID: <CAP8UFD1aGJJMx74RXGTy4hO=Wdv3dDuX4P3UEEGgYvcA_j=M1A@mail.gmail.com>
References: <20121122053012.GA17265@thyrsus.com>
	<CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com>
	<20121122221107.GA16069@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Nov 23 21:22:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbzlD-000064-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 21:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab2KWUVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 15:21:48 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39488 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab2KWUVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 15:21:47 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4018116bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 12:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b+QCFBh+LG44VF6N9mWkkNwhLgtVDveUtMFhQFiGjFg=;
        b=bwCCzV3O75L/UaKlXgKnc72rGtGFBQgocojSGAPWqfyii4thVraOPjkLr0mo41h5ym
         owpIk/+8tA0RgqfNyDHVYs4OlRfbbQ6ZGOpv0SIPOvBJMsbTpp5udd41dRFgxkudBxKq
         Ckw5sIKGlUac/VE+08Ic11Rw4IKVRAMrPqA1/kqF8YZly4eu/uqFgQ2KTZIWC7WcGhYG
         ih1JW/7Jz9WcToKMvvb7tIucml3bxFlmqjqPFFeAxCOFKxmq44GFIW3h1dcH+0AkkNnG
         hiAUxHfOgv08ImLObJgqACcSZ2ZHbf9QoqeFhLWvC9JoI6vXLaFfBnUXhKFOqfNA4Jtf
         wKKA==
Received: by 10.205.129.17 with SMTP id hg17mr1540142bkc.41.1353702106261;
 Fri, 23 Nov 2012 12:21:46 -0800 (PST)
Received: by 10.204.129.70 with HTTP; Fri, 23 Nov 2012 12:21:46 -0800 (PST)
In-Reply-To: <20121122221107.GA16069@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210272>

On Thu, Nov 22, 2012 at 11:11 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Shawn Pearce <spearce@spearce.org>:
>> [Lots of helpful stuff ended by]
>> > 4. How does "git help" work?  That is, how is a subcommand expected
>> > to know when it is being called to export its help text?
>>
>> IIRC "git help foo" runs "man git-foo".
>
> OK, that makes sense.

"git help" can also launch a browser to display the HTML version of
the man page.
It is looking for man pages and HTML docs in the paths given by "git
--man-path" and "git --html-path".

Cheers,
Christian.
