From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 00:32:09 +0530
Message-ID: <CALkWK0m3wQ7=fDOO5q3-h1T+ScFp7c29jtaDWq_0W37RVLsWdg@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <20140106183548.GG3881@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 20:02:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0FRu-0005iv-W5
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 20:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbaAFTCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 14:02:50 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62665 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbaAFTCt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 14:02:49 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so19040419ieb.22
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 11:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=domBcHmq4YLm4+J80n6dNavvQyVGe8JNFlaDFNMGK74=;
        b=LrNQiJU+2IFD4cdxtNXPvX7Ob6xrpfElOd9vBNPHOSY5a6q4aKAoLBKO/nJQNT5eDC
         4g+Ae5Z+tD9wRDHFUNeqKqGxX+8ZdE9w0dv7QxEOwmOPIN7U93H/Qa4mrQynCNWn6gjp
         gx1qwJoKrIArji3Id7aVhf2JM+kGZ+o38xv3pX/UScI4nJqgkQMgNwBzZIjYdi9tk8U/
         tFAgOls1pfQ6myiYyzgEmzVqOxCzAU7J2YEqwQZgQj8fVTHYCwIilcwwTwJq5RFFJv3s
         S5rTzJQ9D9RQ92esxcX88tK6i55VuJlbZ26FtUbWEfYVNgtcBZ0TC4nMwWT/cTz6/BIO
         Vz0g==
X-Received: by 10.50.36.67 with SMTP id o3mr21099990igj.47.1389034969396; Mon,
 06 Jan 2014 11:02:49 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 11:02:09 -0800 (PST)
In-Reply-To: <20140106183548.GG3881@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240050>

Jonathan Nieder wrote:
>  1. Most config settings are in noun form: e.g.,
>     "[remote] pushDefault = foo".  That makes their names easy to guess
>     and makes them easy to talk about: I set the default remote for
>     pushing by changing the remote.pushdefault setting.
>
>     '[url "<foo>"] insteadOf' is an exception to that and a bit of an
>     aberration.
>
>     This new '[format] defaultTo' repeats the same end-with-a-preposition
>     mistake, while I think it would be better to learn from it.

I agree that it's somewhat unconventional to allow people to put a
<revision> as a configuration variable value, but I think it's useful.
url.<url>.insteadOf is incredibly useful, for instance.

>  2. Wouldn't a more natural default be @{u}..HEAD instead of relying on
>     the user to do the make-work of keeping a local branch that tracks
>     master up to date?

Like I said in my message to Junio, @{u} is not necessarily the "best"
default for all workflows, although you can fill that into
format.defaultTo.
