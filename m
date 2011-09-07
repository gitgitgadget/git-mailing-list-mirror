From: Kyle Neath <kneath@gmail.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Wed, 7 Sep 2011 01:11:19 -0700
Message-ID: <CAFcyEtihOVz17-3QRZLSNE-4yS2vBHaaUzHng+ciwK0usSm1dA@mail.gmail.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <CAGdFq_h3KNuGuhhY2Zv-dHWqAY4Wq3HHBGh2f53rWzDT9PzSgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:28:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Lva-0001Tn-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab1IGR2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:28:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37575 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab1IGR2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:28:40 -0400
Received: by wwf5 with SMTP id 5so7793873wwf.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hIyFtddVd8vIe1o8L7daIo9yI/le/U2rWUgO4E2TcZE=;
        b=X3/IGPqUkhnLHDyupohdH+1s5zaCBUWdtvlAog5lKGaVfNis5+rwt9QvK6FQcgEesK
         V54QlbE5DZ4y1wiSwmHNxOOZRWPkR/X3sxV/FBw7wOIYmZz00yBIBI3M7x6YKSkzuOEH
         Vvc3ZAYAp5b+upMy2KdLnilLanbu+5AsL8E9c=
Received: by 10.227.8.214 with SMTP id i22mr6011507wbi.11.1315383099115; Wed,
 07 Sep 2011 01:11:39 -0700 (PDT)
Received: by 10.227.54.208 with HTTP; Wed, 7 Sep 2011 01:11:19 -0700 (PDT)
In-Reply-To: <CAGdFq_h3KNuGuhhY2Zv-dHWqAY4Wq3HHBGh2f53rWzDT9PzSgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180876>

On Wed, Sep 7, 2011 at 12:46 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Junio mentioned in WC that he wants to see some feedback on it's
> usage, perhaps that you can help provide this by providing a git
> patched with this functionality to some of your users and see how they
> respond?

Perhaps this is where things get complicated. Due to the nature of the people
I'm discussing (people afraid of SSH keys), getting them to run a custom
version of git is pretty far out of the question. Peff alluded to this in his
reply.

I think the best evidence I can provide is in context of GitHub for Mac.
GitHub for Mac defaults to Smart HTTP, with the credentials cached in OSX's
Keychain. Effectively, it functions as a patched git with credential caching.

Two months after shipping, we have around 20,000 people that use the
application regularly. In that time, we've gotten a ton of positive feedback.
So there is a great number of people interested in a git client that uses
Smart HTTP. One of the bigger complaints we get is that people constantly have
to enter their username & password if they choose to drop to the command line.

Of course, this is all fuzzy data since it's not really comparable with git
core. But it's the only data I have.

Then again, perhaps the fact that we spent development time hacking around
git's limitation is a data point in itself. Git GUI developers are spending
development time to fill a hole in git core.

Kyle
