From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Links broken in ref docs.
Date: Mon, 22 Oct 2012 15:45:00 +1100
Message-ID: <CAH5451nFf_SY4K2DS52vhP6VeXSmeikUrc0zy8HK3xmGgs+UGg@mail.gmail.com>
References: <CAJr+XPGm4djBh+vacG5Ff=Y6aYmWbcUXOV9x2jekgnsGsk4b-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Scott Chacon <schacon@gmail.com>
To: Mike Norman <mknorman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 06:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ9tP-0002aT-2N
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 06:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712Ab2JVEpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 00:45:21 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49711 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2JVEpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 00:45:21 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1005014qad.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 21:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=viGHP50zOTZASszz/+eE01U62IH4lOsPbXp3MzIbsQw=;
        b=0h/moVoh8rHJu44WNIXy662NcA6vtO64kUWIB1REAEz11MHn5En4hM/jizXJh3rr1v
         b7AifNifRok7Z7hjXfGvPxNo6H/Awa+HSwao6JZjLSEM/4/eSZ4k7UT34fg8C6Rkx+ST
         vVlCAnZi4N1DoCGwlyVrAc31dqODBzk36W4KfhX0qOMvXlZ97q5ofcRvkvaIKIxhqCE3
         ZsXt3fS8EgdoM12i61JC7+bK+7SQ+Bs8wqSP5n6hdcHgoObOa4KZB0nloZH75EIyPF8m
         cADGrllm2pPPc7uBLPXuj8mV6D4fBwcG3m/nnyEPK4H1vNJZWMsZxv2ABcAwZ84Bjfar
         Bftg==
Received: by 10.224.189.65 with SMTP id dd1mr3533351qab.79.1350881120631; Sun,
 21 Oct 2012 21:45:20 -0700 (PDT)
Received: by 10.49.58.225 with HTTP; Sun, 21 Oct 2012 21:45:00 -0700 (PDT)
In-Reply-To: <CAJr+XPGm4djBh+vacG5Ff=Y6aYmWbcUXOV9x2jekgnsGsk4b-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208174>

On 21 October 2012 18:31, Mike Norman <mknorman@gmail.com> wrote:
> Many links on scm-git.org/docs simply reload the page.
>
> For example, all of Sharing and Updating section simply reload the
> docs page. And tons others. Must be a broken link or routing problem.
> Repros on FF 14.0.1 and Chrome. Good luck!
>

Including Scott Chacon as he manages this site (to my knowledge).

Looking at the request, I am getting a 302:

Request URL:http://git-scm.com/docs/git-fetch
Request Method:GET
Status Code:302 Moved Temporarily

Maybe those pages are not done yet? That doesn't seem right as this is
simply the reference manual, but perhaps there is something else going
on here.

On another (related) note, the wayback machine has some very
interesting entries for the scm-git.org domain [1] and it seems the
/doc directory is not indexed at all. Is this on purpose?

Regards,

Andrew Ardill

[1] http://wayback.archive.org/web/*/http://git-scm.com/*
