From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Sparse checkout in worktree
Date: Wed, 25 Nov 2015 21:50:23 +0100
Message-ID: <CACsJy8ALKZqY++gmabZ-GKvrxkTGAq1=yMQh9EApMs3yhUiK=g@mail.gmail.com>
References: <5655AC29.20801@drmicha.warpmail.net> <CACsJy8Acb0Z3sw7_r6QfTTz=GqedsU76QxjexWf4yZFg9O7W-w@mail.gmail.com>
 <56560FAE.3000605@drmicha.warpmail.net> <CACsJy8BGPk7C3d9JWjRwYrgh4OTUiiAjGzcKcRJy8+-5=x8=Pg@mail.gmail.com>
 <56561D94.7020503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:51:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1h1l-0002qR-ND
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbbKYUu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:50:56 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36027 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbKYUuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 15:50:55 -0500
Received: by lfs39 with SMTP id 39so72285234lfs.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 12:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gk8RCzXjAPzwb4aW2JKoX/tf+bNCs2RxRAtDU55wGQ0=;
        b=vK1ygU7EdvRJjRS/cl6g56RI1KgcyLcbUJU66xbSLMJZNlA8R0ofJCfbHZYhtM86/A
         M24hwLv58zYSfFUZPQ8WUgMD8vqWwTHUXEXdwm1vztV3si/4sUKIBnTgOJqv8DthXnqN
         JGq1VAZvZAcH53QQrc7qj30ypEWrQGa6gKi9qjD0vsq4fKhGJOEYQSV0hQiyKmN0ZZNq
         JnJ6yUU8fuhyTmpa8LBsgZm133elWC8ryLsTaX746FamHn7TUsRuhjsgi2kVMyC+YQb+
         uXKKDOPiLz8JE9/AVI6Jhr6IVJ6EDhvko3iJenv7YSMHYXANBop9LwWrd4/nrJC0UghC
         wWJg==
X-Received: by 10.112.202.168 with SMTP id kj8mr15982626lbc.12.1448484653248;
 Wed, 25 Nov 2015 12:50:53 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 25 Nov 2015 12:50:23 -0800 (PST)
In-Reply-To: <56561D94.7020503@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281744>

On Wed, Nov 25, 2015 at 9:44 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> OTOH, config is common: core.sparseCheckout
> So, the per worktree "switch" is the presence of the sparse-checkout file.

Oh.. but yeah, splitting config file per worktree is on my todo list.
Or you can help finish it [1] if you want to make it happen faster

[1] http://article.gmane.org/gmane.comp.version-control.git/266520
-- 
Duy
