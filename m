From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 04:01:01 -0500
Message-ID: <535e18cdc7bce_338911e930c72@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:11:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehbC-0008RI-7b
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbaD1JLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:11:38 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:59880 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbaD1JLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:11:37 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so6887833oag.20
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=3/FHwfHhK1vli7wkkG5xM+JZrGhCiJvK9dYREtIg5qA=;
        b=vdk5AkRAKlZbc+7SLoi+TJFt0w/UaDEtx1UFi1lkmO18e5ic2yhF2y7FUZWZrXpG3R
         yRje/MxHsn9gtAriSgMLPMHAgkeL3eaTEiYLwTmies5HdvAfpujf6Uy5ov9LHgjJOXuz
         AAVHxTNHsidvUMieWrWyedLtmvjcd/7HpN7qi8kcKdNjJoSYaPEXOIUFBE/bbtXHLLNw
         azmcV8xfTBl8cOAUa6R8gkTbV3ittnBITAOs+ryDtwvJ4pXjyA/MuzGEmiDIRsHkE4SB
         kAWkhw805yfDvQ4U/gKpwzfWjh2AeW1sbGfI9aQOzfYomVNcVzJ2NVbD/rvbQOab1vBW
         FhKQ==
X-Received: by 10.182.40.201 with SMTP id z9mr6194828obk.45.1398676296669;
        Mon, 28 Apr 2014 02:11:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm71107911oeb.13.2014.04.28.02.11.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 02:11:35 -0700 (PDT)
In-Reply-To: <535D6EB1.9080208@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247259>

Jeremy Morton wrote:
> On 27/04/2014 20:33, Johan Herland wrote:
> > The problem is not really "less tidy commit trees" - by which I gather
> > you mean history graphs that are non-linear. IMHO, the history graph
> > should reflect parallel/branched development when that is useful.
> > Blindly rebasing everything into a single line is IMHO just as bad as
> > doing all your work directly on master and blindly running "git pull"
> > between each of your own commits (which results in a lot of useless
> > merges). The merge commits themselves are not the problem. Merge
> > commits are a tool, and when used properly (to introduce topics to the
> > master branch like described above) they are a good tool. When abused
> > (like blindly running "git pull" and accepting useless "merge
> > bubbles") they create more problems than they solve.
> 
> Sounds like the default behaviour of "git pull" might not be ideal if it 
> easily causes these problems.

It's not idea. Virtually everyone agrees with that, even Linus Torvalds, and we
have the patches to fix it, but it's not going to change.

The Git project doesn't welcome change.

-- 
Felipe Contreras
