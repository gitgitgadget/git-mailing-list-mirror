From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 03:57:45 -0500
Message-ID: <535e1809bf54a_338911e930cb6@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>,
	Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:08:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehY1-0003yb-77
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbaD1JIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:08:20 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:62372 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbaD1JIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:08:19 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so6930461oac.30
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=FSta4buJM4YEimO0Zk922yI6pobik9n1vCnFFA4lq8I=;
        b=f+pLGVknTh8UH576M2xoWxY7FmZ1sl/oL8adHEa4S3c6ULw+3SC2JX5kpf71KX034f
         PsPFzTe4OMTNugZk1m9zbs5LkV/u3Z44bYDEv8/i2HVHhgU+yffXZF+DQLpt042A9nMF
         0ANiu0ojaAcbetW6+v2jXB4qeDtYjFeLpVv6nCC+1JrNda9jV4xYO57lGBDt7TMO9s3l
         rWARsaMAYd4TOyMkAyNAMf7qFUCbfKfRawpkMurFAyEaA37QYJMjUpHj5TJl5oifA2nl
         vs9tSlBWZ+4ARvlc6eFm/SDJNtIoo3pXjpxb9MNgnR3t0eFSlloxGeVN9Sh+7YE8e2LH
         iq5g==
X-Received: by 10.60.155.72 with SMTP id vu8mr658554oeb.60.1398676099401;
        Mon, 28 Apr 2014 02:08:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm31700347obb.5.2014.04.28.02.08.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 02:08:18 -0700 (PDT)
In-Reply-To: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247256>

Johan Herland wrote:
> On Sun, Apr 27, 2014 at 7:38 PM, Jeremy Morton <admin@game-point.net> wrote:
> > Whatsmore, tracking down which branch a commit pertains to is still rather
> > difficult using this approach.  You can go back through the history and
> > find "Merge branch 'pacman-minigame'", but how do you know which commit was
> > the *start* of that branch, if they are not tagged with the branch name?
> 
> Once you have found the merge commit (M), git log M^1..M^2 should list
> all the commits that were made on that branch. The parent of the last
> in that list can be considered the starting point for the branch.

It's not that easy. There has been a lot of discussion in the mailing list and
StackOverflow of ways to do this [1]. The conclusion, at least for me, is that
there's no way to find that out, so it has to be recorded.

[1] http://thread.gmane.org/gmane.comp.version-control.git/198587

-- 
Felipe Contreras
