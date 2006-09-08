From: Pavel Roskin <proski@gnu.org>
Subject: Re: Some issues with current qgit on exit ( aka "Crash this!" )
Date: Fri, 08 Sep 2006 19:25:03 -0400
Message-ID: <1157757903.9088.14.camel@dv>
References: <e5bfff550609081603s2fb1be98gdafb91681a4aeaae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 01:25:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLpim-0001ea-4h
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 01:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWIHXZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 19:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWIHXZK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 19:25:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:53473 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751282AbWIHXZI
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 19:25:08 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GLpic-0002Ng-J0
	for git@vger.kernel.org; Fri, 08 Sep 2006 19:25:06 -0400
Received: from proski by dv.roinet.com with local (Exim 4.63)
	(envelope-from <proski@dv.roinet.com>)
	id 1GLpiZ-0005ta-Nr; Fri, 08 Sep 2006 19:25:03 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550609081603s2fb1be98gdafb91681a4aeaae@mail.gmail.com>
X-Mailer: Evolution 2.7.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26725>

Hi, Marco!

On Sat, 2006-09-09 at 01:03 +0200, Marco Costalba wrote:
> >
> Thanks for reporting, bug (a subtle one this time) fixed and patch pushed.
> 
> I don't think you or someone else could crash qgit anymore ;-)

Wow, I've been clicking on it for 5 minutes like crazy, yet qgit didn't
crash!  Neither did it crash on exit.

However, qgit has produced some output you may find interesting:

[proski@dv qgit]$ qgit
ASSERT in lookupAnnotation: no annotation for src/git_startup.cpp
ASSERT in lookupAnnotation: no annotation for src/fileview.cpp
ASSERT in lookupAnnotation: no annotation for src/git.cpp
ASSERT in lookupAnnotation: no annotation for src/mainbase.ui
[proski@dv qgit]$

This message is quite easy to reproduce by "crazy clicking", but I
cannot do it if clicking slowing and noting what I'm doing.  I guess
it's a timing issue - something must happen before the annotations are
loaded.

-- 
Regards,
Pavel Roskin
