From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: `git checkout --orpan` leaves a dirty worktree
Date: Sat, 9 Feb 2013 01:41:20 +0530
Message-ID: <CALkWK0mdLabT7XyuYsDCROBC5FX+tDgyMnjMRbdkO41PTWd_Ug@mail.gmail.com>
References: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
 <20130208200402.GB8461@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uIm-0002Gu-FY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946950Ab3BHULm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:11:42 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42523 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946902Ab3BHULl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:11:41 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so4350847obb.9
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=R2qo0xUwtVb9HkRo/brO/88O7neyNQ4Voa4tQVOh6pI=;
        b=Qf3l2d2E7Nd0Y3Ixb4tEEGYWsbbu1kzXuGE6OPUI9vtP5mPhBzI5S1CV7+bwDFeTDw
         MDZgw59v1avllNPHfzZO/E+tJ/7jtt5S/k99fsrDNA0q6CQLS4D9aHrc7VOx0z9qkLeV
         jXVa4xpUNXXmkCnke2Gb+XOmxfrTN6Rt0i7J6ucXISj6fdTkyUtdl6pygv8FS54Y5XhA
         1yM7zXWt8hotkSHMP79YU0Hbsf/iiBMl8u1/CJYfhdiK9s+UAG+xLCTVbd0bxRdX7qnh
         WmH1oDX5MwW54Noaf2iD5zrtLDPA8n6dhxS3781AwK2sCXhlhEz/D/CJllzUT6XRjgdp
         w5oA==
X-Received: by 10.182.54.102 with SMTP id i6mr5153467obp.67.1360354300754;
 Fri, 08 Feb 2013 12:11:40 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Fri, 8 Feb 2013 12:11:20 -0800 (PST)
In-Reply-To: <20130208200402.GB8461@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215811>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> One designed for the "going open source" use case, where you have
> existing code that you want to put into a new branch without history.

> BTW, I suspect a clearer way to say what you meant is "Sounds like a
> misfeature" which is gentler and more focused than an implied "What
> kind of idiot designed this?"  Even if you are thinking the latter. :)

Yes, I do feel stupid now.

BTW, Is there a better way to clean out the worktree than `git rm -rf
.`, since that fails for submodules?  The impulsive `reset --hard`
obviously fails because there is no HEAD.

Thanks.
