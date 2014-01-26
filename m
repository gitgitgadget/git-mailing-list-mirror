From: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
Subject: Re: [PATCH] Added get sendmail from .mailrc
Date: Sun, 26 Jan 2014 12:11:47 +0400
Message-ID: <20140126081147.GA5048@kirill.netbynet.ru>
References: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
 <20140125223721.GA2684@dcvr.yhbt.net>
 <20140126073438.GA3858@kirill.netbynet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 09:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7KpI-0004UU-FT
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 09:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbaAZILw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 03:11:52 -0500
Received: from smtp3.mail.ru ([94.100.176.131]:45323 "EHLO smtp3.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbaAZILw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 03:11:52 -0500
X-Greylist: delayed 80685 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jan 2014 03:11:51 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=cJC8nClcu/rw8lAJCZVGbZ9i86Op5JZGxVfioSuDF5c=;
	b=dGUUSQ+/4SnKWJhZNlBRMmEEAI1iwtqfDDmwMZjIXGrxPBofCwZH2SM4XkwR6Gts5Fa/wmco+E3CXM34VUJlbXA6Ln4uuJHcybj1iiUmF1O7V/Ub2zK9ru7XHYIUPAZtLe/fInExJRVRtXaetFIK7/OnwNO3QIDcfPW+edwBNiA=;
Received: from [46.73.163.248] (port=10095 helo=kirill.netbynet.ru)
	by smtp3.mail.ru with esmtpa (envelope-from <brilliantov@inbox.ru>)
	id 1W7Koo-0005cX-0N; Sun, 26 Jan 2014 12:11:50 +0400
Mail-Followup-To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20140126073438.GA3858@kirill.netbynet.ru>
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241080>

On 2014-01-26 11:34:38, Brilliantov Kirill Vladimirovich wrote:
> On 2014-01-25 22:37:21, Eric Wong wrote:
> > 
> > We should probably avoid a new dependency and also remain consistent
> > with the rest of git handles home directories.
> > 
> > Unfortunately, expand_user_path()/git_config_pathname() isn't currently
> > exposed to scripters right now...
> > 
> 
> Ok, if new dependency is not allowed I see next ways:
> - add new argument
> - add new configuration parameters

Ok, git support setting path to sendmail-like program via sendemail.smtpserver
configuration option.
It is not very convenient because I need have separated configuration for mail
and git.
