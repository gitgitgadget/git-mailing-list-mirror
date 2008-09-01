From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2008, #09; Sun, 31)
Date: Mon, 1 Sep 2008 15:16:23 +0700
Message-ID: <fcaeb9bf0809010116p68a638dck4f8e31d49e51c3fb@mail.gmail.com>
References: <7vd4jo1jc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 10:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka4bN-00073W-7J
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 10:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYIAIQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 04:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYIAIQ0
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 04:16:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:12731 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYIAIQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 04:16:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1272448fgg.17
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HdcwvhobWxjMq/3la5P7Fw/GD0ZWCt45jIeH80FK/y4=;
        b=daY7hf4NuCf/Zu1a7bRIJiAfFEqVBjhafRjj02m3YtRJPzrDb825FIbPNL8Uy2wbD4
         rAcgGc7/ZC5wm4dXy7V3dIu8vd50+YUgArF6wxz+SYzuPynRB9ZYFtUm8ga0u5sqcElX
         +5LGDdZdC/dPd53Gfe2Kuap3WDAlSqSP7ywWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iKXhM6G5BhjCWOlBNP0DkQuVsKG8QfS2kQ0IIMKcrnhn9NBHwE61Nh1m95+6tlgJMw
         BTfy/zW4FlmZAmLjRyTBurdELC4b1XhF15l7mH7kpY6nh8UgIAkvyoHMf1qb6rsQjCxM
         XpNQLAoh18IoH21f00h23fykY1Mc4bTgMqE3E=
Received: by 10.86.94.11 with SMTP id r11mr4371661fgb.0.1220256983621;
        Mon, 01 Sep 2008 01:16:23 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Mon, 1 Sep 2008 01:16:23 -0700 (PDT)
In-Reply-To: <7vd4jo1jc6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94540>

On 9/1/08, Junio C Hamano <gitster@pobox.com> wrote:
>  * nd/worktree (Sat Aug 30 16:15:32 2008 +0700) 5 commits
>   - setup_git_directory(): fix move to worktree toplevel directory
>   - update-index: fix worktree setup
>   + read-tree: setup worktree if merge is required
>   + grep: fix worktree setup
>   + diff*: fix worktree setup
>
>  The last two fail test suite.

"make test" on pu did not fail on my machine. What tests failed?
-- 
Duy
