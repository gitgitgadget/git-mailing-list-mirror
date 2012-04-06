From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC] Git to SVN bridge
Date: Fri, 6 Apr 2012 21:37:07 +0530
Message-ID: <CALkWK0=Mqo=PMv7+_sr22Dnm6xxzxzaXL=Zh+2LsvT=usC7csw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 18:07:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGBhK-0003s0-8r
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 18:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab2DFQHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 12:07:31 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53626 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757550Ab2DFQH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 12:07:29 -0400
Received: by wibhq7 with SMTP id hq7so668761wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=FeEhtDakz52sWm0v99jSp2atqPqfl+UJsKKzCdU3xJI=;
        b=F4axFJssHM2QIEBMDVtv5MsH50VrgWRwAHfFjpbhWkjr45CQmzTcv/fYkqtZXki+Hl
         C3R+0a9dAfVIaTk9ZyMKzbt2z0Ypdc4ksFA/fA16om+2TMSL0q4ig07aRzHlaw9kWtBK
         5hYGQSyiXGWcT+fLqJ1VbTQoFWoPxA4QmQ3cPzImC+EtrECHyuII2XaIsz69fnNp1T7n
         AjNbfK7/KXeESm+dYu6aZc87mIU4jWrZeCjLAuwNeToLuTH5mYBOa3pvQxlEzkNtl+8f
         JXALI4kTUt8+n/t17Z//Ap6YyKlC5qTbOUnfajBHyLKg9iGsywJKl9otdlUIGad8N380
         F4vQ==
Received: by 10.180.92.71 with SMTP id ck7mr12927658wib.21.1333728448018; Fri,
 06 Apr 2012 09:07:28 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Fri, 6 Apr 2012 09:07:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194878>

Hi,

Continuing the git-remote-svn effort from two summers ago, I want to
complete the Git -> SVN bridge.

Note: This is intended to be a very short proposal because I'm already
a regular Git contributor, and I have an incomplete version of what I
intend to build [0].  This is not a good example of a proposal that
the Git community expects from a new student.

-- 8< --
# The project

There's another prospective student handling the SVN -> Git side of
things.  I want to invest time in doing the reverse: Git -> SVN
conversion.  There's unmerged code from back then [1] [2] to get
things started.  This plus svnrdump (a tool that I wrote merged into
the Subversion tree) can help complete the Git -> SVN bridge and the
remote helper.

# About me

I was a Summer of Code student with Git the last two summers.  In
2010, I worked on a remote helper for Subversion, and in 2011, I
worked on building a sequencer.  Both of them are successful projects
and code has been merged into upstream.

Pick me only if you're sure that I'm not getting in the way of other
prospective student; I intend to work with Git this summer anyway, and
I don't want the community to lose new students.

[0]: https://github.com/artagnon/git/tree/svn-fi
[1]: http://thread.gmane.org/gmane.comp.version-control.git/170290
[2]: http://thread.gmane.org/gmane.comp.version-control.git/170551
