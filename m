From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Branch dependencies
Date: Thu, 4 Aug 2011 19:38:39 +0200
Message-ID: <20110804173838.GA10298@vidovic.ultras.lan>
References: <20110801121946.GA575@fishbowl.rw.madduck.net>
 <CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
 <20110802190806.GA16674@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 19:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp1sg-0001lq-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab1HDRiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 13:38:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55803 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab1HDRip (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 13:38:45 -0400
Received: by wyf22 with SMTP id 22so693637wyf.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UAhmU3as0HdQiWMVZJ7fS5vWmA8xMV/AvWwManzGNwU=;
        b=X/FyOAnxhJDoITpJi6bQ6/1oV/HhiMsNo1wDNasDYkceTGRaXAmJoSC4UAvxIyvIcP
         q9P8ftGbT4rTsCj5Igdvn/LJrxsxW/wW1JuP2roELUTqTYZjHavEATA1lEnVr+LVp0uN
         notYwx3UFofswscCJkBGZoRaH2ypXN0He/UH0=
Received: by 10.217.7.10 with SMTP id z10mr1511605wes.95.1312479524031;
        Thu, 04 Aug 2011 10:38:44 -0700 (PDT)
Received: from vidovic.ultras.lan (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id u22sm1326858weq.39.2011.08.04.10.38.36
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 10:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110802190806.GA16674@fishbowl.rw.madduck.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178755>

The 02/08/11, martin f krafft wrote:
> also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2011.08.02.1506 +0200]:

> > For my first mentioned problem, I think a new 'system' needs to be
> > 'rebase' based, not merge based like TopGit.
> 
> The problem with rebasing is that you cannot publish the branches.

But you may make public the way to set up the builded branch. Say you
share A and B branches and you build M branch on top of them. You are
able to build M as long as others know M rely on A and B.

In a situation like

      a--+       (A)
         M--y--z (M)
      b--+       (B)

or

   a--+          (A)
      b--+       (B)
         M--y--z (M)

M is the builded branch. Commits y and z should not be public, IMHO.

-- 
Nicolas Sebrecht
