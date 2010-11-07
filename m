From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: first para of man gitignore should refer to 'git rm --cached'
Date: Mon, 8 Nov 2010 00:44:27 +0530
Message-ID: <20101107191425.GA32302@kytes>
References: <AANLkTim=QCcJDb0600Je-jePvXSXfFMe7FAQ0WMhZKn7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 20:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFAhF-0006Mt-Hz
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 20:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab0KGTO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 14:14:28 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39804 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab0KGTO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 14:14:27 -0500
Received: by yxk8 with SMTP id 8so2988770yxk.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aYXHiaA5adReXlFcXqKdL2OZfbuIw1iXnAst3uUibyM=;
        b=SPAZKzWaH4PF4SqEiSPZIo3OZpyiK24Y8OI4aJwcwSuN4Ei5yGy/w/wgvzdzoHN87v
         /NTD18/UpKbNzyYPDIyfNRMjPwfmoEV3y2Fg7JCJtO6RBh5Rb7851IVNy7fID0o2sA+W
         TELbuMtcmmeiD6+SeXsXrWwl5UR3NOnzgXtGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wQ/mTkZRsttEJHxtD+DiPINxldP8AxTdQ2bXsz//AbqycrG1wQXgw3BySWGksJbPuf
         j3E5iIWI0LTxb0HWRgi62orLgQ4CGj6gQSPi9ptFyX8l0gsHvIQQeQnq76AdLgPnFnw/
         Q16fIcX14tVBFX9585FGnHRy/fRM6s+mKSdrs=
Received: by 10.151.46.1 with SMTP id y1mr7115415ybj.243.1289157267214;
        Sun, 07 Nov 2010 11:14:27 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id t9sm2939532ybe.21.2010.11.07.11.14.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 11:14:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim=QCcJDb0600Je-jePvXSXfFMe7FAQ0WMhZKn7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160897>

Hi Sitaram,

Sitaram Chamarty writes:
> It's an FAQ that "why doesn't my gitignore work" when the files in
> question had already been added earlier, usually in error.  The most
> common remedy, I believe, is "git rm --cached" followed by a commit.

Er, no. The documentation says "in order to ignore uncommitted changes
in already tracked files". `git rm --cached` removes the file from the
index altogether- when the change is committed, Git will actually stop
tracking it.

> "update-index" does not seem to be the right answer.

>From the update-index documentation assume-unchanged section, "This
option can be also used as a coarse file-level mechanism to ignore
uncommitted changes in tracked files (akin to what .gitignore does for
untracked files)". It seems to be right.

-- Ram
