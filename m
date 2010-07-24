From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git workflow with upstream repository
Date: Fri, 23 Jul 2010 22:39:13 -0400
Message-ID: <AANLkTi=dgjoa8c=UN1VvMDgo_RAptTr1YFk+n_7M9sdM@mail.gmail.com>
References: <AANLkTinyUGLMTQ=ruk69pptDUQ3VyaQ7CwtO+QfeJUVC@mail.gmail.com> 
	<AANLkTik5U0oh8p42hK-871iwnTA5a66Yj-8pU4xSZS40@mail.gmail.com> 
	<AANLkTi=82NDSfizCCjoJ-Sj05DzwXfa35ro60MiWSQdz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 04:39:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcUeR-0002y8-TP
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 04:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab0GXCjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 22:39:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62515 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477Ab0GXCjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 22:39:42 -0400
Received: by wwj40 with SMTP id 40so5259620wwj.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9qjXmXIW4x/6LrF++kQdJHLUdASvw7Dt5IHB8AuYfzs=;
        b=FcBQx4Xvi7vRRcn5N72JOp8V9r6Vz1/4r9PZitJERaLJIEN/YevaijKablvyrG7003
         m7shSj7BGTmJVH/ESz+KtkaFBzyjfROVrQ+re6rTQiXqlQd8Gx9/S31Q0ApLbz2Dfnuj
         sSTpgqDVBJkOSCPg5kkadEQCUAcT/RK1tOsP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KJPfA8+78GbF6xOQ53YifCaBESrUsqgZgmbaQCWCkuO0NdwQhZMzwCW+I4wsZ6+r7t
         Mn1xmCAsJYOVI9pcVJE44Lj/Ry3nnSlM0DVMkwheSSsnLwBSZ6biWE8J7p/1XOzUeOzC
         yeLzcEw37hTI3BiEuszR4ERjm1HbBp9Uzpl4c=
Received: by 10.227.140.154 with SMTP id i26mr4281813wbu.199.1279939173236; 
	Fri, 23 Jul 2010 19:39:33 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 19:39:13 -0700 (PDT)
In-Reply-To: <AANLkTi=82NDSfizCCjoJ-Sj05DzwXfa35ro60MiWSQdz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151600>

On Fri, Jul 23, 2010 at 9:43 PM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> Thanks, I'll check those out! So, I take it there is not a way to get
> a simple message like what git status tells you when you're local
> branch is behind the remote branch:
>
> "Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded."

As far as I know, any given branch can only "track" one particular
branch, and that message is only generated relative to the branch
you're tracking.  You can adjust which one you're tracking by editing
.git/config.

> Is there even a concept of a fast-forward merge when pulling from a
> remote repo that is not the remote to which your branches are
> tracking?

Yes.  Tracking branches are really just a notational convenience.  In
fact, they don't do very much more than generating the above message.
(The other thing they do is make 'git pull' do something by default
when you don't give it any other parameters.)

You might enjoy this article:
http://eagain.net/articles/git-for-computer-scientists/

> Is it possible to rebase based on a branch that is *not* the branch
> you're currently tracking? Is that what the --onto flag is for?

Yes, it's possible.  The question of when you do or don't need the
--onto option is a little more complex than that, but yes, that's
what's it's for, more or less.

Have fun,

Avery
