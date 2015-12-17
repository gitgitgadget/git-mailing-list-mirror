From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: CruiseControl.NET hangs on git-submodule bad file descriptor
Date: Thu, 17 Dec 2015 14:54:58 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512171453140.6483@virtualbox>
References: <HE1PR08MB089107ED02BEA428A6BB37A5F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com> <alpine.DEB.2.20.1512171045230.6483@virtualbox> <HE1PR08MB089122D0784C67685EAF5A76F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Skrinnik <askrinnik@amtoss.com.ua>
X-From: git-owner@vger.kernel.org Thu Dec 17 14:55:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Z1b-0006VW-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 14:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934734AbbLQNzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 08:55:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:51828 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934631AbbLQNzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 08:55:03 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXZNq-1ZfKJJ1qZq-00WX0s; Thu, 17 Dec 2015 14:54:59
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <HE1PR08MB089122D0784C67685EAF5A76F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:iiumx9kDxeQesbVFpmVLB4U9JZhuSrCn+Y3lbfCVCz+GEyrkeVd
 Bh5M2nB+m35jlrw9GfcM2zwn+NOO86SsY7f8RIl9EB4PeHOFc93tgKUPMP0igFBYH1BodNL
 acSNOsu9oWG0o610xa2lm4tI3MbBA6CVprg8oMR08mnIXL4XhJgTyNy9WlX1dyzt2WmKqHf
 KkAyN5lKWQAKVFggFfFhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KQz+FFG/2iU=:r3IFFoKsRgzrbRUCFgM6QN
 5ePI89+JfJKEhWO8e+mT+iM9A3g//oEU9z89aQxeKpnAZxjec2VYbXTh8ULVgnTkAq5FVEsxg
 5jZ1SV7qO8RXzNltlffgbBDlWG4+2283i05pZ5uU4XvyPifmD16lzH05QfpnCE96yBcfB7OcK
 xKZEi8bCdeUaDnypgHudbqUM7BfZcrKcIf9wyr5wDK3HQTtwRlYTLTCK3IGHkRYYtAAwWuCuZ
 Xe21oBpflt0zfwqR5T5eXvqC1xWZZiQmYdhOJ/HWYlABqRrnBuEjqEeooteDHmaIC+9L4bSi4
 F/0GSR0Ko20Jh/GKE4MUszbocCtZE7uo0HOS46PpspS5rv/MnhWTU7EkTF+413lhCHA1HYlZj
 Bco/MFGDPHKDCgiusmj+3uCjKVl1wI2qkZ/8F/xrjcT4y+z4kAzLxMPI2BkXM7zjQEiofimNC
 G28iRKmrSVdh1JInyRUnCuTkELskAFP7R2hPfgoPk2ipvWjqxvo88ysw2UvCjxmX9c9glJsg3
 LZyWrltU0Q7VK5B0hg7w0gXUSuMbUNV3KcMvAcunXdaPKZ0kO7+Qs95bENySzBXucMUZaQ7Pz
 3o7Fu8KO1WXczZDjdH1f9ZhuKzhF0qsK9fsJCW4xXB3eY+EwZBUynDWhmp+/z00f8wXp5o9Qh
 J7tBbcJydpLmH6hFjWZG4L6RYzXGnnYDUg7HKuc0ebxLix3MZ9Zk0K9cGAQLH0LmNve7HW9F5
 apaf+RYUvBLffQ6zd2PBO5ENHnIxkKwtDrRToC0LHpQYO6UDgsoux8jWQ4fwgWNyHaGoepcX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282653>

Hi Alexander,

you might want to refrain from top-posting on this list in the future.
Just sayin' ;-)

On Thu, 17 Dec 2015, Alexander Skrinnik wrote:

> I found workaround, CC.NET invokes bat-file with command:
> git submodule foreach git checkout "myBranch" <NUL
> 
> It works fine. But looks like the issue is in git. Not in CC.NET :)
> If you have a chance, could you look into it, please?

Unfortunately, this is one of those problems where the bug reporter
expects me not only to fix the problem, but also to come up with an easy
way to reproduce the issue.

And even more unfortunate is the fact that I am really pressed on some
other, more critical issues.

Is there really no chance for you to have a crack at resolving this issue?

Ciao,
Johannes
