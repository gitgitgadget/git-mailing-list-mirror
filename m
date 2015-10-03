From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git feature request: mark a commit as minor
Date: Sat, 3 Oct 2015 20:12:22 +0200
Message-ID: <20151003181222.GA2024@paksenarrion.iveqy.com>
References: <560EF966.3000501@walltime.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Micaroni Lalli <micaroni@walltime.info>
X-From: git-owner@vger.kernel.org Sat Oct 03 20:13:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiRIr-0003Hr-NH
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 20:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbbJCSM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 14:12:27 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35764 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJCSM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 14:12:26 -0400
Received: by lbwr8 with SMTP id r8so40261519lbw.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rpKnAtWcjQdUk2VhTIo/ret1Sut/pdMBBHnnTlo28yI=;
        b=Y0eySA/CTrfXWZp70in+WkYEjtBTNPkEc6PcRta5Zg6lBm1HaZ79109xhMXEC+fU3Z
         81khH9Tw/O5cWjG7jC07yxJc6zfK6BDAvDt+XFEF4OfbZ91JkD4toCydZ0pbZSDsfpyA
         +CZAaEg/wKKUuQENaYq12YyRTp+Fjbd+b0FGlIrtkrYyLFJV7isBGe6aytTUIsRwH1Wd
         i5zq0guvSXT+XWA4zXUxqWnB0Buadv41/5lOlbUwVDbmU/mcEYSpnV8CFtbLp1XiMqrT
         icBNIGlTwdgXouWNfs7ABVEVTdQAT4phUMuZc1Tvcu7T0D8dOIOd8Qz8v7519I5EIb/i
         e1NA==
X-Received: by 10.112.158.1 with SMTP id wq1mr7964893lbb.67.1443895944343;
        Sat, 03 Oct 2015 11:12:24 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by smtp.gmail.com with ESMTPSA id ym7sm2572768lbb.13.2015.10.03.11.12.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2015 11:12:23 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1ZiRIE-00014g-L3; Sat, 03 Oct 2015 20:12:22 +0200
Content-Disposition: inline
In-Reply-To: <560EF966.3000501@walltime.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278981>

On Fri, Oct 02, 2015 at 06:38:46PM -0300, Felipe Micaroni Lalli wrote:
> A minor change (also called "cosmetic") usually is a typo fix, doc
> improvement, a little code refactoring that don't change the behavior etc.
> 
> In Wikipedia we can mark an edition as "minor".
> 
> It would be nice to have an argument like "--minor" in git-commit to
> mark the commit as minor. Also, filter in git-log (like --hide-minor) to
> hide the minor changes. The git-log could be optimized to show minor
> commits more discreetly.

I can see your problem and implement your suggest is a solution that
would work. However since this is a common problem, git already has a
solution, that is the interactive rebase.

You can read a discussion about when to use merge and rebase here:
http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg39091.html

This work method make the "minor" commits to go away. There shouldn't be
any minor, or "fixup" commits in your history (of course there's
exception).

Minor things should be caught in your code review process and then
fixed, rebased and the merged again.

Or do I miss a usecase here?

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
