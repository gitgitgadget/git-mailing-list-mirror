From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GIT_WORK_TREE not set as expected when changing git repository
 from a script using a git alias
Date: Fri, 4 Dec 2015 15:31:50 +0100
Message-ID: <CACsJy8BSca7qdxcPojaPEjGwur+Nnsq2KFWsKX4gcVKR2N6e6A@mail.gmail.com>
References: <CAE1CpdRY4fdppx35FyK9fqY8YNzrxvW+WPgqb73mh32tJUF3vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Gabriel Ganne <gabriel.ganne@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 15:32:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4rPN-0001yi-IW
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 15:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbLDOcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 09:32:22 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36752 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbLDOcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 09:32:21 -0500
Received: by lfs39 with SMTP id 39so109780040lfs.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 06:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3tZmqxvyih9GOAqcnqP0t5JX1F4ypcPkuPtTJ7JZaLA=;
        b=IClEx8t7qd4bUjsbsY+pNzkSGvv4AHw/JlmWi+vJxWVpW7014wy/erUj4yJS3VwJAP
         0oMpF8ejpCZPezdVlBtQCOG+BnxZjkhMHtabnhyYEUkaP6p0ONs0Y5IOb8UFzk5iLQ+w
         Vr+MfKUOLCDIJQUDqevUc1PI2V4J+pgC+YRoiq6NhFujnqXyAPPaWvj2nRw9/ZKLKm7U
         9rXoOPQlbySm4jFgQx1G7adeKmBh8bYqBT4XhAsXcwvt0Q7ljV0C/CQocfXVbRLc2Mps
         UOGoSClbQ/X6zfXW0TmEjat+TkKDz+Ev5wBLaQxAd6WZvzk1egN+oEBrT756yj7+TxxY
         4kPQ==
X-Received: by 10.25.168.6 with SMTP id r6mr8211695lfe.94.1449239539608; Fri,
 04 Dec 2015 06:32:19 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Fri, 4 Dec 2015 06:31:50 -0800 (PST)
In-Reply-To: <CAE1CpdRY4fdppx35FyK9fqY8YNzrxvW+WPgqb73mh32tJUF3vQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281981>

On Fri, Dec 4, 2015 at 10:54 AM, Gabriel Ganne <gabriel.ganne@gmail.com> wrote:
> Hi,
>
> Following commit d95138e695d99d32dcad528a2a7974f434c51e79 (since
> v2.5.1) the following workflow I use seems broken :

You are not the first one bitten [1] by that commit. A fix is being
worked on [2]. Sorry for the trouble.

[1] http://thread.gmane.org/gmane.comp.version-control.git/281608
[2] http://article.gmane.org/gmane.comp.version-control.git/281960
-- 
Duy
