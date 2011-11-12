From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] sequencer: revert d3f4628e
Date: Sat, 12 Nov 2011 16:40:12 -0600
Message-ID: <20111112224012.GA31766@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-6-git-send-email-artagnon@gmail.com>
 <20111106004257.GG27272@elie.hsd1.il.comcast.net>
 <CALkWK0=QHUeKH6ccVLYJVW_RxXbEaLfwafTVzJ94+s49j=8QjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 23:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPMLa-0006ua-GI
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 23:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab1KLWkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 17:40:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48406 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab1KLWkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 17:40:21 -0500
Received: by iage36 with SMTP id e36so5549483iag.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=E9pgRUjUm8NNzTNz3WBEehzgrbsCvJ6H9bOGQ5ua3Jg=;
        b=PI4n7XsS3KxNaa0Yqn8hRlNjCqahvI8GQaMugWet2a0D835KQeFHiABq1kTo2lZ3Pz
         ZSaOZsY7fEmI1ScCSPTL3gZJQ29C8ahfZXb/kjY/KqWwdofkQGQilkJ5Um/n1xW+1UyH
         SIUUa/kCtUgItYZqQ/31HfaSmvmR9qZ6LAFpk=
Received: by 10.231.84.8 with SMTP id h8mr4241128ibl.47.1321137620448;
        Sat, 12 Nov 2011 14:40:20 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z10sm22529870ibv.9.2011.11.12.14.40.19
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Nov 2011 14:40:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=QHUeKH6ccVLYJVW_RxXbEaLfwafTVzJ94+s49j=8QjA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185319>

Ramkumar Ramachandra wrote:

> I'm trying to
> "effectively port the inverse of the changes made by d3f4628e in
> revert.c to sequencer.c" -- would you still like to see a git-revert
> style commit message?  Don't you think it'll be misleading?

My main complaint is that the subject line (and then the body) didn't
tell me what effect the patch would have in a self-contained way.

I don't think a git-revert style commit message would be misleading.
Couldn't you avoid confusing people by providing the relevant
information directly?  "This commit was not made with 'git revert',
since there has been too much code reorganization in the meantime;
instead, I applied the inverse of the changes made by d3f4628e by
hand.  This patch also tweaks the test added in that commit instead of
removing it."

> Sorry about the shoddy commit messages though: I'm polishing the
> series now that I'm convinced that it's heading in the right
> direction.  Hopefully, I'll have more to show soon.

Thanks.  I'll try not to be distracted and to just focus on the code
for the next round.
