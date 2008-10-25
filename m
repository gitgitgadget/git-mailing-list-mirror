From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Sat, 25 Oct 2008 09:48:24 +0200
Message-ID: <cb7bb73a0810250048q7ad8595bt565de05ec2ec37cb@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org>
	 <alpine.DEB.1.10.0810241254330.27333@asgard.lang.hm>
	 <cb7bb73a0810241313o341febccgbea1cd59b25b9cc4@mail.gmail.com>
	 <200810242230.49238.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Lang" <david@lang.hm>, "Junio C Hamano" <gitster@pobox.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 09:53:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktdxc-00023A-NA
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 09:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYJYHs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 03:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbYJYHs0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 03:48:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:21294 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbYJYHs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 03:48:26 -0400
Received: by wx-out-0506.google.com with SMTP id h27so547615wxd.4
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TZVu+qEtY7JfxHzgNjMvo40YRIu1i55qj+367Z8bp3k=;
        b=sXPoMkqPo28MbOqzJRGkRm2oGOHZ3iNnQvVud1vQPnhavKjslM0Je635GHmOm4J5Li
         JURwQQieW2911IGKxpv5oFa1EsCSsYMHEGc2kbFFo6CyqMVtG3CEQ9LvbERLU8yn3wLM
         MgnV5LdCuCOVLTeB3lasGkJ/MjA0Q83tti8zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nFtoItV0+VAmI8nceoALworCxvLoTasvMMC0DxHQ4ZErwEuf3iiXnqnGY8n1znw1KQ
         k+c159PytYb7aXPEecTme3OQt2+VDQ78m0jzRRuUYWukBvhD7X+5u+i2+WWojlPmX4+E
         STQJF/1ekz7yxQqwmb0O7qwWIRBtne/7YyG9w=
Received: by 10.151.111.15 with SMTP id o15mr7037336ybm.49.1224920904430;
        Sat, 25 Oct 2008 00:48:24 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Sat, 25 Oct 2008 00:48:24 -0700 (PDT)
In-Reply-To: <200810242230.49238.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99098>

On Fri, Oct 24, 2008 at 10:30 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Well, with all zit repositories in '.zit/' directory (similar to RCS/)
> you could have point core.excludesfile to _common_ '.zit/excludes';
> the pattern doesn't change from zit repository to zit repository?
>
> You could even use per-user ~/.zitignore (I'm not sure if git expands
> '~' in paths; there was some patch for it, but was it accepted?) or
> system-wide /usr/lib/zitignore or /usr/libexec/zitignore file.

System-wide means maximum space save, but it require system
administration to install Zit, and considering that one of the things
I love of Zit now is its being self contained, I would rather not
depend on anything system-wide anyway.

The user .zitignore file is probably the best approach: we can create
it ourselves (usually), and even if Git doesn't expand the pathname
itself, we can just use an absolute path. I'll go that way.

-- 
Giuseppe "Oblomov" Bilotta
