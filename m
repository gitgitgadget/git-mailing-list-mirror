From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: git for subversion users
Date: Tue, 26 Jun 2007 09:19:51 -0400
Message-ID: <e2a1d0aa0706260619u48943163r7f85da944bb88672@mail.gmail.com>
References: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com>
	 <46809733.2060200@vilain.net> <4680A341.5000208@midwinter.com>
	 <4680AA15.6040501@vilain.net> <4680C057.5070202@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 15:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3AxW-00034o-Kz
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 15:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbXFZNTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 09:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbXFZNTx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 09:19:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:30449 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbXFZNTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 09:19:52 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1702007nzf
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 06:19:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M5ULPKyMfzLrccY7828zJk8bjwkzm8Re/AVzIhSxP1v0RsFrAxyCukfgXr4upnwsf5DPuUh6QPbCHb8a9Ugs03kMNUHIc8rnxPmXPxLI4sR7n9xbzFgkrkE8TQvuQUjHQKMIhgTdBpq++CiUei4/rDn1fjni1dFFGmgmblN/hzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kOlKfMPdkfh+Wv9w5CznPl1oawlia8H4+NXG8VZIr9qU9I5NgaFJ4hiCQOOK5ETLYeUYTh0+k9Bv6k1E4Ht9tTlA2at+OcW7mgkp1HpbV4hacVjTjBcGvMhh9G89zWdl9DXSDN4dcKInjoOroxK/AtKQLURlp1z08Wzo3Ty5SKg=
Received: by 10.114.60.19 with SMTP id i19mr6420872waa.1182863991627;
        Tue, 26 Jun 2007 06:19:51 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Tue, 26 Jun 2007 06:19:51 -0700 (PDT)
In-Reply-To: <4680C057.5070202@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50959>

Thank you all for the tips and pointers,  especially to Sam, who has
given me something to digest, and to Steven, whose mode of operation,
"I can vouch for all of that as well. On some of my repositories I use
git solely as a fancy Subversion client, no interaction with any other
git repositories. And hardly anyone at my company even knows about
it"; precisely matches what I am trying to do.

It seems that a large part of my original problem was with the fact
that FC6 only has git-1.5.0.2 on it.  When I installed 1.5.2.2, things
started working much more smoothly for me.

I still have one issue... say I start a project in git and later want
to publish it to the subversion server, history and all... how do I do
that?

Right now, I do the following:

$ svn mkdir url://to/svn/repo/newproject -m "made directory"
$ git-svn clone url://to/svn/repo/newproject
$ cd newproject
$ git pull url://from/project/started/in/git
$ git log
-- shows the history of my git based project, along with the "made
directory" log message
$ git-svn dcommit
-- commits only a single change to the svn repository with a log
message that reads something like "merged
url://from/project/started/in/git"
$ git-log
-- no longer shows the history of my git based project, it just shows
the subversion history

Is this related to the follow-on discussion regarding handling merges properly?

Is there some other way to "export" a git repository to a subversion
repository, maintaining the history along the way?

Once again, thanks for your help.

--wpd
