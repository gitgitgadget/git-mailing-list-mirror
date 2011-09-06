From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3 5/5] branch: allow pattern arguments
Date: Tue, 6 Sep 2011 16:26:06 +0200
Message-ID: <CAGdFq_jmW+VZygVj73EP_1oB5DDNp5rYZgZq+i9zf3w6BpsMYA@mail.gmail.com>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
 <0c487086643fbf0334140365f20fef62242b7dac.1314543252.git.git@drmicha.warpmail.net>
 <4E661BDE.1080204@elegosoft.com> <4E662C6F.7000205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 06 16:26:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0wc0-0006KW-55
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 16:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab1IFO0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 10:26:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44462 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1IFO0r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 10:26:47 -0400
Received: by yxj19 with SMTP id 19so2999689yxj.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BELrcwI4QljCDQt48k+ZiUVilupd/XmKIWY5oAIA5E0=;
        b=LZh8yS6a+aIans6JP9Lvkz9V7ukUhvDQ6HWE+IEoYzvYzJ4MLQc6woQET0MFqjbYIl
         yo1yuXUq8gN3KCgSly4kNWkzsNyvEOWtrbyHrJzwW78qFIYtiaGuonVNaxqIvk7Yijn7
         GFvydI6cxjEK0gvXldAhCwqwt4J0agfl3klvA=
Received: by 10.68.26.133 with SMTP id l5mr1067052pbg.299.1315319206045; Tue,
 06 Sep 2011 07:26:46 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Tue, 6 Sep 2011 07:26:06 -0700 (PDT)
In-Reply-To: <4E662C6F.7000205@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180803>

Heya,

On Tue, Sep 6, 2011 at 16:21, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Have you ever tried to delete a remote branch?
>
> git branch -r -d origin/maint # workee
> git branch -r -d remotes/origin/maint # no workee
>
> Without -r, it doesn't work either.

Heh, I read this as "worktree" / "no worktree" at least 4 times.

-- 
Cheers,

Sverre Rabbelier
