From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Sat, 6 Oct 2007 08:43:36 +0100
Message-ID: <200710060843.38567.andyparkins@gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <1191599763.7117.18.camel@hinata.boston.redhat.com> <47067F68.2080709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marko Macek <Marko.Macek@gmx.net>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 09:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ie4KR-0001Nd-S6
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 09:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbXJFHny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 03:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbXJFHny
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 03:43:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49292 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbXJFHnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 03:43:53 -0400
Received: by ug-out-1314.google.com with SMTP id z38so593488ugc
        for <git@vger.kernel.org>; Sat, 06 Oct 2007 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=fEg1r20vdDznwf9n+4YHFirdwGj9iFTbTXiPte0+Avk=;
        b=gGrnXeukMkwAyf1wQoy6SW3+YJ4Q52YIYkJ7lqEkXiFocOYGlBYx0VShK+8jnDN55/iblfQkRkw3iVd98s8eP/nxeXoF8Iw3inB2jIbcnoY5JCCREoJNnUorU6mEpzhQy1tkSJ/aGo5T8ob5BKwh164uKzdNkmOHpRODvO8sYIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iF59TZR9m2zfcELa6RGpYo2clJ+g9u25xehBoRtGg+T1KjAO6RNL19MD3aISa+EWIfQZAeO0BlMu8wscSzj5ish4OjMCuImO3vhooDIsARPmNrR5Eh3nL+UxDIYccTIeIXmmVZYIasKFXMGJUt5igeUaZswBJwByU4L/f5z7TLw=
Received: by 10.66.224.3 with SMTP id w3mr4216832ugg.1191656632192;
        Sat, 06 Oct 2007 00:43:52 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id k30sm10517755ugc.2007.10.06.00.43.50
        (version=SSLv3 cipher=OTHER);
        Sat, 06 Oct 2007 00:43:51 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <47067F68.2080709@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60139>

On Friday 2007, October 05, Marko Macek wrote:

> In CVS and subversion (which has nicer working-copy command line
> interface IMHO), I simply make a copy of the working copy, revert the
> non-commitable parts, build, commit the minor changes, and then update
> the first copy. For larger projects, where this can be slow, I use
> diff/revert/patch.
>
> Small checkins are nice for git-bisect, but if they don't build...

Who cares?  Commits that build isn't the only reason for small commits.

git-bisect is nice and small buildable commits is something to aim for.  
However, there is more to software history that buildable commits.

I hardly ever git-bisect, and I hardly ever checkout old revisions, however 
I read the log _all the time_.  The smaller the commit and the better the 
log message the more quickly I'll understand what was going on.  In the end 
even if the commit doesn't build as long as the log message is a good 
description of what the commit does and that thing is an isolated change 
then the revision has achieved its goal for me.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
