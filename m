From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 13:03:13 +0100
Message-ID: <20141113120313.GB15503@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
 <20141113114919.GA2737@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:03:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xot7Q-0005iZ-Cv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 13:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbaKMMDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 07:03:16 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:36073 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329AbaKMMDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 07:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415880194; l=1114;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=7AO/tfxC8xbSX3M6c19YagXQYEE=;
	b=BGi3Xh4F3czfipP+E/5o+mdk89Mu/kR1tuVnBEejPyPDqxCMlQA2LI7283Bo9iN9/LB
	wHnp+FYgpoz+7DrVwYriWuWKfENq6sNhcMDPyZUuei8sagMl+xryS9q+uFNyjcC0/O6PR
	qhh+nbJky2LkskeLfmnNHAwBXUMXRUNI+Ug=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id f03037qADC3EjUp
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Thu, 13 Nov 2014 13:03:14 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 8DF1C50172; Thu, 13 Nov 2014 13:03:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141113114919.GA2737@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, Fredrik Gustafsson wrote:

> On Thu, Nov 13, 2014 at 12:14:44PM +0100, Olaf Hering wrote:
> > 
> > How can I reduce the disk usage for multiple copies of the same repo?
> 
> You can use --local och --shared. As you say --shared can be dangerous.
> If you don't understand the man page enough to know how you should
> manage your clones you should probably not use it.

Perhaps its more a lack of doc how to use the result.

> --local seems to be what you're looking for.

I will try this.

> However as a side note I'm curious about what your use case is. Why do
> you need this many repos?

Because I do work in each copy, poke around, or do commits and push
them.

> Your setup looks familiar to me for a subversion user switching to git
> and trying to use git as subversion. The common usecase is not to have
> multiple worktrees but to do a checkout to the worktree you need to work
> on. This is possible with git since it's very fast and I recommend you
> to try to use one worktree.

Switching branches will invalidate timestamps, causing a full rebuild.

Olaf
