From: Daniel Smith <dansmith65@gmail.com>
Subject: Fwd: git-new-workdir for Windows (#9)
Date: Wed, 15 Jun 2011 09:24:59 -0700
Message-ID: <BANLkTi=x+5yL3XuS8HF1=5S71rsY_=7O9Q@mail.gmail.com>
References: <git/git/pull/9@github.com> <git/git/pull/9/c1372088@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 18:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWsuF-0003jl-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 18:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab1FOQZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 12:25:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40329 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab1FOQZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 12:25:22 -0400
Received: by bwz15 with SMTP id 15so604666bwz.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=pO0ePdkkfDpysFFttfz2DGljzQA7X0oA1Np5RsJzOv0=;
        b=jj2ZHsJR0uLzTkqV6/z5k+G3/9HO2V5UCEPnYACSIxr/kN5akKWdFs6OnWpy50uStI
         zueq/ziFaZNPpKqgHF8DFYrJyvjmjrwrtxmzHZbvMNiKD/2Myf4VZsvOFpclbRdqKJXe
         UZZLWT1lOR6L8VdVhkTffpIzHDDpCqa1cjSlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=LbfUrj0vkEuOBY+yaL9l2aMvWAMMIOUpqK8KLPlxn33uV6HN1q9MniKSqJVqrR65z/
         hH2QGqcEpmrvt9SS8HowFuxW0GZhY2ayZ5PMjrKihFBqmB6IQxkdiWnviXC25ob5k59a
         A/4BXchSUO5TGzU9eV1sESIiiGuoULqB5hCTE=
Received: by 10.204.163.130 with SMTP id a2mr746315bky.108.1308155120303; Wed,
 15 Jun 2011 09:25:20 -0700 (PDT)
Received: by 10.204.57.143 with HTTP; Wed, 15 Jun 2011 09:24:59 -0700 (PDT)
In-Reply-To: <git/git/pull/9/c1372088@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175839>

The git-new-workdir script creates copies of files instead of symbolic
links, when run from Git Bash on Windows Vista. I modified it to use
mklink via cmd.exe.  I have an open pull request on GitHub:
https://github.com/git/git/pull/9.

I'm not sure how permanent that link is, so here is a link to the file
in my fork of git:
https://github.com/dansmith65/git/blob/master/contrib/workdir/git-new-workdir-win

- Dan

---------- Forwarded message ----------
From: snaewe <reply+i-1057590-454ecf9c3cc5385e5ea53b0726af874fd2ef4b00@reply.github.com>
Date: Wed, Jun 15, 2011 at 1:31 AM
Subject: Re: [git] git-new-workdir for Windows (#9)
To: dansmith65@gmail.com


I guess this might get more attention at the git mailing list at
git@vger.kernel.org.

--
Reply to this email directly or view it on GitHub:
https://github.com/git/git/pull/9#issuecomment-1372088
