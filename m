From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Thu, 25 Apr 2013 00:40:37 +0530
Message-ID: <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com> <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com> <20130424190638.GE29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:11:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV56B-000571-EC
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab3DXTLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:11:18 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:55798 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab3DXTLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:11:18 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so1969157iab.22
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nkIDgR06mSe0BvPMFzJBCHlA+Ccg054k52vBag5sQUs=;
        b=Cy31ypi7c/N/pEHNW4oaeTouEU6/YhB+XpT+uZGw11sZeNtsUnbf0ooVzw88mORp/Y
         +Fx20Y3pGBaeIkS0vPjXoAHP55iLL/65s5SwDhNms5p6Xy7sPOzDxZkGxx2Y+lHB8Rgp
         dGJgjMuxOe5DzertsAuEMLFGvBxHs8mRc/2wOlWaCE6G16ksBM9NsaZ72G01mEgBjYAJ
         QQiN6DEMBYGQUGKHi+X/k3qcGCJ59dObeQEsRYtVsiQVxbuOgDwSbHf0Odn914wFMp6e
         9ckjfryTvT+AeJ23w/+s0rsMPhAX+d9YvdFFai3/omaq+UrxmhldZZXAKj9vsVFPm9xe
         MCyw==
X-Received: by 10.50.72.65 with SMTP id b1mr3072707igv.63.1366830677589; Wed,
 24 Apr 2013 12:11:17 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 12:10:37 -0700 (PDT)
In-Reply-To: <20130424190638.GE29963@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222299>

Jonathan Nieder wrote:
> Maybe it would make sense to move towards eliminating the "implicit
> --no-index for paths outside the repository" trick.  I use "git diff
> --no-index" all the time, but I always spell it out to be careful.

Huh?  Why do you want to endure the pain of spelling it out, when your
intent is perfectly clear?

What would make sense is a tristate diff.no-index:
inside-worktree|outside-worktree|always.  I don't know why we should
even have a "never".
