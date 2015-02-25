From: John Szakmeister <john@szakmeister.net>
Subject: Re: Build error with current source release
Date: Wed, 25 Feb 2015 05:30:22 -0500
Message-ID: <CAEBDL5VeKNV-RN-Q8MnC3PYRAdWa2=LbPEfRM+tcywUtFFHvmw@mail.gmail.com>
References: <03B16590-C319-478F-B19C-7EF3B51952BC@jrw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "J. R. Westmoreland" <jr@jrw.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQZEa-000649-QQ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 11:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbbBYKaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 05:30:24 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:33231 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbBYKaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 05:30:23 -0500
Received: by labgf13 with SMTP id gf13so2911731lab.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 02:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tn5nbBTDH4jQUCCzZzH+RP5ce/ZvxMDkWikHOPt2n7U=;
        b=ia8a+TTbA+LaU6fw6Ql9Zeoj+6pV9f+Se7f4FuR1KKTVE9b49y1ZePPNHmZ5PzJdNp
         tQ05uaDR4gd7fzTtBjeJGoiI55t0HUqMdZAYwGrubbI9d/lPhAbBy0qk9Zv7j1cWnL0M
         jTGF2jXwy8KGYUW0EAi/48jZ3d3PDTmr3kQ3S4FukJNqbubbznzqqMCB/dZwpmtyMw35
         65+CSi5HCwtwOXEAx6npjplEjkintN1oY7JRQTZwMrWBEz1DaS/8HbuQYdiLQH48+Bdz
         FO0mZB4pxLdU71WxHNER93xjjRoOKGq1lAwBuMp2Rsw2Vho8EKdnf7tNJZ4BQ/Kaqyd4
         pMcw==
X-Received: by 10.152.19.228 with SMTP id i4mr2130399lae.77.1424860222183;
 Wed, 25 Feb 2015 02:30:22 -0800 (PST)
Received: by 10.25.166.5 with HTTP; Wed, 25 Feb 2015 02:30:22 -0800 (PST)
In-Reply-To: <03B16590-C319-478F-B19C-7EF3B51952BC@jrw.org>
X-Google-Sender-Auth: OFiLxgA3XZNBmmrJxCxcY1GlUqM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264382>

On Tue, Feb 24, 2015 at 9:23 AM, J. R. Westmoreland <jr@jrw.org> wrote:
> Hi
>
> I hope it is okay to ask such a question here.
>
> I cloned the current source tree and tried to build it and I get the following error.
> Could someone tell me why and if there is an easy way to fix it?

If you aren't opposed to using Homebrew, then I believe installing the
docbook package will help you here.  I installed xmlto that way, which
automatically brought in the docbook packages for me.

-John
