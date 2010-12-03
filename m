From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Problems using perl's Git.pm module
Date: Fri, 3 Dec 2010 09:14:14 +0100
Message-ID: <20101203081414.GB26070@raven.wolf.lan>
References: <20101202114003.GA26070@raven.wolf.lan>
 <7vipzcrrk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQsP-0005xR-W6
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758504Ab0LCIUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 03:20:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:42312 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab0LCIUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:20:12 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1POQsD-0002Z3-DR; Fri, 03 Dec 2010 09:20:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 5B51F76337; Fri,  3 Dec 2010 09:14:14 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vipzcrrk9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162770>

On Thu, Dec 02, 2010 at 09:51:50AM -0800, Junio C Hamano wrote:
> Josef Wolf <jw@raven.inka.de> writes:
> 
> >   jw@raven:~/testrepos> git st
> >   # On branch master
> >   nothing to commit (working directory clean)
> I take it that you have "alias.st.cmd = status".

Yes, I'm still strongly tied to svn ;-)

> Observe what this gives you:
> 
>     $ git st; echo $?

1

> If you are running pre-1.7.0 version of git, I think "git status" was a
> synonym to "git commit --dry-run" and exited with non-zero status to
> signal the caller that there is nothing to commit, which is...

It's 1.6.4.2, so I guess you're right.

Thanks!
