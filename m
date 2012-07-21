From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git with large files...
Date: Sat, 21 Jul 2012 10:40:50 -0400
Message-ID: <CACPiFC+G4_3cZZW+wuKX47denO9D+g+C5MxG2i77yod3gtCWOA@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com> <86fw8mf3gp.fsf@red.stonehenge.com>
 <CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com> <CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 16:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsasU-0007YO-US
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 16:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885Ab2GUOlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 10:41:13 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37085 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab2GUOlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 10:41:12 -0400
Received: by vbbff1 with SMTP id ff1so3655830vbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VQQQk9y2cfUYPJuoRjHbn51SowLAsBYrqkMFYUreM0w=;
        b=Fd+C/MDG5pLwxfS0QGAJgXImEBdlGq3VOCCDV7VwNopXe7jukJLU02hUBaZ3S7vLKN
         Tf+gGK2/t98KRBzHHstL9plVK+ALrhTwchQ/xhxTeDwvTNVcrlFWGZ/NteOhFnzmcdYl
         F14sOrwxY4UxxImjLWxYx71CEEJX/RmNyJIrigOjwQZ/UFfguiZconEN1QNOVZx4bSb6
         OyP3Wwxmj1/hjlUlqeYLXD2ix9GRauJ5NyNDa+3mIPk3/tUxd5GE+lHyqmI/GngwMvol
         gRab0m7d1WoSKENhqUQcgghDAQ8bf1ntCIstYstKi6c2uNz6R/MwuVQ6Z/X8+HM6s3dO
         GQ2g==
Received: by 10.52.26.242 with SMTP id o18mr1500790vdg.38.1342881671253; Sat,
 21 Jul 2012 07:41:11 -0700 (PDT)
Received: by 10.52.162.34 with HTTP; Sat, 21 Jul 2012 07:40:50 -0700 (PDT)
In-Reply-To: <CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201808>

On Fri, Jul 20, 2012 at 11:47 PM, David Aguilar <davvid@gmail.com> wrote:
> I'm not sure if it was the "big files" part that Randal was responding
> to.  IIUC it was the "using git for deployment" part.
>
> Packaging tools (Makefiles, .rpm, .deb, etc) are a better suited for
> deploying software.

Fair enough. On that topic, I have to say that git, with suitable
scripts controlling it, has been good to me for deployment to
webservers (ie: synchronized deployment on server clusters). Limited
to interpreted languages (py, php, etc).

I am not afraid of Makefiles, rpms or debs but sometimes they are a
bit too much overhead.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
