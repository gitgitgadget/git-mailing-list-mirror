From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: Git svn fetches entire trunk on tags (change from 1.6.5.2 to 1.7.0)
Date: Wed, 17 Feb 2010 17:54:09 -0600
Message-ID: <5CFEDDA0-6C6B-43DF-8BB4-E303E91C24EF@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhtj7-0006yg-2i
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 00:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757863Ab0BQXyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 18:54:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63032 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab0BQXyf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 18:54:35 -0500
Received: by vws11 with SMTP id 11so143223vws.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 15:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date:cc;
        bh=JlKQPP47x2HJQpc90UGRLeIzhiwkiAzoVCDSdNf8Yqo=;
        b=ZDXLw2PxOM99wfGA3+tMkD0lAUYOfsSf4RIoFvSplbCkKeNM5Gpp0dfw5juUX5r02s
         sU01reYLtZjjD4hnh/6aaaDvD7GiwidgD/wn0HLCYvV9qESCrTo/vjFDHphVVhIai+qb
         6sV2L+jd3+ieCileuzorsRjDjGTYJbLd0DtwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        b=vq/sYWQSfaWqOQPWxuqUpSk2auMRsJWDSw8+Mj3TnZtyyDhWS9sLW57YSUtEt9X8hD
         hQec0DEdPNb0fx6jyx31Z4g+rHLIzVT09tXt+V7ro/33k05oKF+0u/3gv23rzTmcOHkC
         3zCa2LX3hZ1jArgLjNv8Oi9a2mKv7YNLzf7PY=
Received: by 10.220.89.194 with SMTP id f2mr6311689vcm.7.1266450873900;
        Wed, 17 Feb 2010 15:54:33 -0800 (PST)
Received: from ?10.45.136.129? (mobile-166-137-138-217.mycingular.net [166.137.138.217])
        by mx.google.com with ESMTPS id 28sm21697651vws.11.2010.02.17.15.54.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 15:54:33 -0800 (PST)
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140273>

On Feb 17, 2010, at 5:23 PM, Eric Wong <normalperson@yhbt.net> wrote:
> There was a rather large amount of changes between 1.6.5.2 so some
> regressions could've slipped in.  A bisection would definitely help
> us track down the cause.

I will attempt a bisection Thursday.

>
> Does the repository you're using svn:mergeinfo use by any chance?

The repository does use mergeinfo, but    much later in the revision  
history then when the problem shows up.

Do you have any advice on how to write a test for this behaviour,  
since the problem is not apparent from looking at the repo?  I do not  
like the idea of a test looking at a log but that is all I can think  
of right now.

Robert
