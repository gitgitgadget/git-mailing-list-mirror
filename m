From: skillzero@gmail.com
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Thu, 12 Nov 2009 12:08:14 -0800
Message-ID: <2729632a0911121208r1f51cf9ewb0bc23e757275f30@mail.gmail.com>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
	 <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com
To: rocketraman@fastmail.fm
X-From: git-owner@vger.kernel.org Thu Nov 12 21:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8fxu-0000jQ-0X
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 21:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbZKLUIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 15:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbZKLUIK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 15:08:10 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:39609 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbZKLUIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 15:08:09 -0500
Received: by iwn8 with SMTP id 8so2059388iwn.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=rlPBKTMIZTRJXxzDGu5x+BiD/ZN6pHmblojIB8pzpls=;
        b=JGjORXRccFvhzUlZxKYmmzG5Jj5/F00ZhLFlkLP7DkwTHP2ckWLXQxxUJHBx1uHQTR
         rjE1+KqHEu6FyFuaRyfNBse2drqbqWo10JswKzmfkSuxSqbnjQxsVVXrIV+WRok1sSDq
         POIYGxIuQd/h9azqphaFCAn00oEOvZH/mGlg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DPA9M8ANRYjCxdVcpyWQS3i5APOWEfE/6dY2zkTH4sMlQa7kyIbig7S3mSbINv20K7
         fc3nFC+1EwiwsmBIU5zaQRX00n3GxsVwUImwI2Gu8I5j9nGNggO+n1n9A2pGkplriuvs
         NNq5BAzaYdBD89FJx8QdC/AJ0LmQQtImHVVK8=
Received: by 10.231.21.157 with SMTP id j29mr316403ibb.28.1258056494428; Thu, 
	12 Nov 2009 12:08:14 -0800 (PST)
In-Reply-To: <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132796>

> +.Update maint to new release
> +[caption="Recipe: "]
> +=====================================
> +* `git branch -f next master`
> +* `git merge ai/topic_in_next1`
> +* `git merge ai/topic_in_next2`

Shouldn't that be something like "Update next to new release" instead
of "maint"?

Should it also have 'git checkout next' after the branch command so
it's on next before merging?
