From: "=?ISO-8859-7?Q?Christos_=D4rochalakis?=" <yatiohi@ideopolis.gr>
Subject: Re: Git Community Book
Date: Sat, 6 Sep 2008 21:26:45 +0300
Message-ID: <f7b87f7c0809061126y17f6b601iaeb9a3661c914391@mail.gmail.com>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2Vl-0007yf-Jm
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbYIFS0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbYIFS0r
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:26:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:30327 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYIFS0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:26:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so934515wfd.4
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 11:26:45 -0700 (PDT)
Received: by 10.142.213.10 with SMTP id l10mr4562477wfg.163.1220725605137;
        Sat, 06 Sep 2008 11:26:45 -0700 (PDT)
Received: by 10.142.222.16 with HTTP; Sat, 6 Sep 2008 11:26:45 -0700 (PDT)
In-Reply-To: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: b8cd84e88c5a7249
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95089>

On Fri, Sep 5, 2008 at 10:08 PM, Scott Chacon <schacon@gmail.com> wrote:
> Hey all,
>
> I just wanted to let those of you who are interested know that I've
> been making a lot of progress on the Git Community Book
> (http://book.git-scm.com)
> ...

Hello Scott!

Nice book, I just started reading it and I have a recommendation to
make, at "Chapter 4: Git Treeishes" you write

---------
http://book.git-scm.com/4_git_treeishes.html
Range

Finally, you can specify a range of commits with the range spec. This
will give you all the commits between 7b593b5 and 51bea1 (where 51bea1
is most recent), excluding 7b593b5 but including 51bea1:

7b593b5..51bea1

This will include every commit since 7b593b:

7b593b..
---------

This in not quite correct. "commits between A and B" cannot really
apply here. I believe that "commits reachable from B and not from A"
is more precise. Actually you are already using the "reachability"
explanation at the start of "Chapter 3: Basic usage".

This issue is also described at the rev-parse man page.

Apart from that, you could also include "a...b" syntax for completeness.

-christos
