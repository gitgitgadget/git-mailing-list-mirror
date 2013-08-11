From: Kristian Freed <kristian.freed@gmail.com>
Subject: Re: How can I automatically create a GIT branch that represents a
 sequence of tags?
Date: Sun, 11 Aug 2013 12:13:18 +0100
Message-ID: <CAFw3YtSp4QLXHkycRmmQNYkvoR=2_qC9YYV1mFV3PiwfWHspzQ@mail.gmail.com>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
 <20130810232026.GF25779@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 13:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Taj-0000O2-Co
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 13:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab3HKLNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 07:13:41 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:33635 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3HKLNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 07:13:40 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so4573336wes.23
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pIeNFBGw8rgbY3RHD14nCOyGirl53Ejgz4dP1j+daHs=;
        b=stUHS12/uinqEWGDkg9ZG0T9UJr1fj+fatk+ok4xzxgSb57pIGfjbdOT86kyEoUw14
         tE116uvb7oZRPAC3juEKUpfk+r4EOtwO68Qcu2gzapdfBstri4mijXWh/puB5DeCiokx
         2cnxxBos+wTAi7+PMfXs60wFs/1rN97cVm55UuYxTnldNk/PxyOLgksVt6ui4CzRRMFX
         +mr77HQfc1eW0ETuMlKgYZ0Y9e2Zav57ftFpLykat2DRwOlF0mDTjx+MymxTQmmjbPZu
         8I40HV1va0W5VQpZemf8PH9rFF08DiebCTHr0smmZleZj+Qme9vTS+YD5vtZ8xhjIqCa
         R7RQ==
X-Received: by 10.194.172.9 with SMTP id ay9mr10522757wjc.54.1376219618774;
 Sun, 11 Aug 2013 04:13:38 -0700 (PDT)
Received: by 10.194.172.101 with HTTP; Sun, 11 Aug 2013 04:13:18 -0700 (PDT)
In-Reply-To: <20130810232026.GF25779@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232132>

On Sun, Aug 11, 2013 at 12:20 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> I don't understand, why is it better to find between which tags a error
> was found and not in what commit. It's much easier to find a bug
> introduced in a commit than in a tag/release. It sounds like you're
> doing the bug hunting harder. Could you explain this further?

For better or worse, the current state includes a lot of noisy "fixing
tests" type commits which I
would like to automatically skip over when hunting bugs. This is not
great and is being addressed,
but I am trying to make the most of the historical data we have today
- which does contain tags
for all builds that passed automated testing etc but does not have
only good commits on the related
branch.

> My suggestion if you want to do this, is to have your buildtool to
> checkout a special branch (let's call it tag_branch) do a git reset
> to get the worktree from the newly tagged commit and commit on that
> branch once for each tag it's creating, when it creates the tag.

I can see how this would work, but only for future builds. I would
need something like it but loop
over all existing tags as this is a problem with historical data.
Could you please be more specific
as to the steps required to automatically form a commit that
represents the change between
two commits (i.e. tags)?

Thanks,
Kristian
