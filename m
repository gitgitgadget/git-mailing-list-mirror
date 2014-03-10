From: demerphq <demerphq@gmail.com>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 12:28:37 +0100
Message-ID: <CANgJU+W+f3KUxehDGxd+f77RO24VadsnOV=szE2MkBXjs8wDCQ@mail.gmail.com>
References: <531D8ED9.7040305@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Dennis Luehring <dl.soluz@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 12:29:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMyOG-0007s0-9J
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 12:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbaCJL2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 07:28:39 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:63196 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaCJL2i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 07:28:38 -0400
Received: by mail-qc0-f173.google.com with SMTP id r5so7498032qcx.32
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7TD1iTmBu8dzyNP63MkPzifbyBIGaegepNBMpyl78vo=;
        b=lH/EwsMjNYTlAzqMv8tP3sO+05mX75Mg5HkADqe1EfDunxhvImjCdxqfi+EPMEd13B
         AAu9/cMriwa+VQwJMGprCH91p/gLCU21Qhs67PpThB6dthsr3oG2M0rGwqUvwPYHQ6Bz
         XVJI2zn2pYSyN2kvZ8JegdH3+wXFvJHcYJrMPKVOwlkrKxiSLyIduOrZvHgdD/mzStSN
         DES++6K82XObiFufFXJh+f7+DZZBG8tr+LZZ/u1BrubTGIyD/CzPCc+aqiksEK6OBqB3
         aSlE8iby/Dzb8rdI4b2ZyYq5v5qzbdV0IBH4HCQ18w2IU50bBv11V9TXUAz0cPt0TEMI
         SvOg==
X-Received: by 10.224.29.4 with SMTP id o4mr39819726qac.3.1394450917445; Mon,
 10 Mar 2014 04:28:37 -0700 (PDT)
Received: by 10.140.104.200 with HTTP; Mon, 10 Mar 2014 04:28:37 -0700 (PDT)
In-Reply-To: <531D8ED9.7040305@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243727>

On 10 March 2014 11:07, Dennis Luehring <dl.soluz@gmx.net> wrote:
> according to these blog posts
>
> http://www.infoq.com/news/2014/01/facebook-scaling-hg
> https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/
>
> mercurial "can" be faster then git
>
> but i don't found any reply from the git community if it is a real problem
> or if there a ongoing (maybe git 2.0) changes to compete better in this case

They mailed the list about performance issues in git. From what I saw
there was relatively little feedback.

I had the impression, and I would not be surprised if they had the
impression that the git development community is relatively
unconcerned about performance issues on larger repositories.

There have been other reports, which are difficult to keep track of
without a bug tracking system, but the ones I know of are:

Poor performance of git status with large number of excluded files and
large repositories.
Poor performance, and breakage, on repositories with very large
numbers of files in them. (Rebase for instance will break if you
rebase a commit that contains a *lot* of files.)
Poor performance in protocol layer (and other places) with repos with
large numbers of refs. (Maybe this is fixed, not sure.)

cheers,
Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
