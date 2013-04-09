From: Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Very useful script to SVG graph the git commits from a file
 orientated view
Date: Tue, 9 Apr 2013 16:02:34 +0200
Message-ID: <CAP8UFD2ja6DVUkXy6w-jfPsLAPJxWpkOaj3CxcOwbczTJFdZfg@mail.gmail.com>
References: <CAHQ6N+rPfYmNRjjU0EDx3B1O_K+c6zm9v=BT_bMEXZ1yQFXGhw@mail.gmail.com>
	<1344434918.1379702.1365497705958.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Tue Apr 09 16:02:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPZ8C-0004Uj-H7
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 16:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934468Ab3DIOCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 10:02:36 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:44966 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759089Ab3DIOCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 10:02:35 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so4632591vbh.26
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=W7QZ5QQkOVcD4iQVG13ga86FqKrG4ft//DB9lhIjkgs=;
        b=QuFspmlRDr72bLCHHU4eOEgG9r03mMcOuUJGwXL2Id/uVW/AV0eilwivk69YLJ5D9e
         ZlBZ+QMD24N6gTpjC5z0/VpXF0ZDol7LpjHJ2WjFvqKwmgCez6zfc3Y0hkG+ELlhUe7C
         sIwPqolhVlOdBvotR8KyZGTzYv2seicN7sW1yrBP6fbcDI1IrUWinYUJbmoY/1otD/vI
         rbstXdH8ZJtTsisvwKohY6bZSFgaBSEok0WMclxQe8t51ojbeemRvXLQz6TKy0lILhUJ
         Yb2FK05W0wMVrFw8sPdeHnd04Y/QfkMq66iP3JzNW40Iru0oUoSZY0v1gCQkecwVEE48
         WjaA==
X-Received: by 10.220.39.69 with SMTP id f5mr19546112vce.45.1365516154961;
 Tue, 09 Apr 2013 07:02:34 -0700 (PDT)
Received: by 10.58.120.97 with HTTP; Tue, 9 Apr 2013 07:02:34 -0700 (PDT)
In-Reply-To: <1344434918.1379702.1365497705958.JavaMail.root@openwide.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220571>

Hi,

On Tue, Apr 9, 2013 at 10:55 AM, Jeremy Rosen <jeremy.rosen@openwide.fr> wrote:
> looking a little bit more into this, I was very suprised....
>
> there seems to be little/no tools in the git ecosystem that studies the dependencies between commits based on the file they modified and/or the conflict they would cause.
>
> Is there any pre-existing tool to do that ? It can be done with git-log --name-only(the graph_git.pl is just a graphing layer above that command) but i'm suprised that I couldn't find anything else
>
> And that was at the file level, is there any tool to help find what commits can be reordered without causing conflicts ? I am not sure if there is an easy way to extract potential conflict information from git...

It looks like this tool will do "Proactive Merge Conflicts Detection":

http://commitq.com/

But it's true that it would be nice if there was something in git itself.

Thanks,
Christian.
