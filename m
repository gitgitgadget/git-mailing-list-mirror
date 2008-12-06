From: Deskin Miller <deskinm@umich.edu>
Subject: Re: Git Books
Date: Sat, 6 Dec 2008 18:48:10 -0500
Message-ID: <20081206234810.GA8809@euler>
References: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com> <20081206194515.GA4721@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 00:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L96u8-0006GY-Vp
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 00:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbYLFXsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 18:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYLFXsW
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 18:48:22 -0500
Received: from rn-out-0910.google.com ([64.233.170.190]:10251 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbYLFXsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 18:48:21 -0500
Received: by rn-out-0910.google.com with SMTP id k40so512723rnd.17
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 15:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=vNYk5VYdVikxxcK5j73HA0dYerxzwLZf/qtormtSirk=;
        b=eRF6RuiNNV3S1UAW5UyOJKFQlm8RAkgdIcD4meK0SP6bkAv/TmPCd/64SD3BzNQVPb
         u9Uh0XxjBAog1xJARVkxIsVIT90vQ8ZZQ4F/scPt1zXPAdcfxbWE20T0y8enFotSr3M5
         f0UvekGk6SDQJ001TZs3Rlp02/yznZGtBd5Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=TXYRWbqigFK95pgtitj0OKXnxRTdUpagBnq6ODi0m6vf4E5nagggUxhwhMr08GEfbt
         v1u6chdHAYbyi8TzbBrKsbUCuTCirCg4jQ9FGXAfclDxk/r43D1LJrgRHrgJcG68zNLF
         dx0hOLpZy1DqS/zcdDw4DDDws9Ht0mgzONPjs=
Received: by 10.64.3.5 with SMTP id 5mr1324994qbc.75.1228607300081;
        Sat, 06 Dec 2008 15:48:20 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id p9sm5271100qbp.13.2008.12.06.15.48.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 15:48:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081206194515.GA4721@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102486>

On 2008.12.06 03:58:28 -0800, Scott Chacon wrote:
> So, since I'm near the beginning of this process, I was wondering if
> the group had any feedback as to what might be super helpful to
> include.  I mean, I have a pretty good layout and all, but if you
> wanted to point me to some threads that tend to crop up in the mailing
> list and IRC channel from relative newcomers that I might be able to
> nip in the bud, I would like to.  I'm addressing the stuff that _I_
> hear a lot, and I'm scanning the IRC logs and list for topics, but I
> figured many of you must answer the same questions all the time, too.

I agree with pretty much all of the other suggestions made thus far.
One I'd vote for is to explain why pushing to a non-bare repository
doesn't magically update the working tree as well; I'd say it's easily
one of the most repeated questions on #git.

I also vote for addressing workflows heavily.  Also, I think a reference
section akin to Tv's 'Git for Computer Scientists' page[1] would be
handy; I find understanding how git represents the project to inform
almost every interesting question about how to accomplish one's goals in
a particular situation.

Deskin Miller

[1] http://eagain.net/articles/git-for-computer-scientists/
