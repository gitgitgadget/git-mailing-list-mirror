From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 17:32:24 -0700 (PDT)
Message-ID: <m3y6nya8vo.fsf@localhost.localdomain>
References: <h9nlhj$heq$1@ger.gmane.org>
	<m33a66br69.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anteru <newsgroups@catchall.shelter13.net>
X-From: git-owner@vger.kernel.org Tue Sep 29 02:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsQeG-0000zl-0V
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 02:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbZI2AcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 20:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbZI2AcY
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 20:32:24 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:38276 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbZI2AcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 20:32:23 -0400
Received: by fxm18 with SMTP id 18so4106239fxm.17
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=SV6M2hvWWfcJO/IgSpDguMSePCDTaDRwAaRHHHwgZgw=;
        b=RJJJKXK2MW4xy39d15ATcUNZXrfCtjWIv0UJPoeiBzkGEuIf/9noXuZP40n9Ltfqun
         wFZS0/RsR0luJ1GfNj8K8ZiHqLrvhVHzXhL9PK/WeOtsKofLT2sAvR863fug/GZe0xOC
         9gqqR/q/sb0tUXob21MPKt2T0u9WQu5WngGE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mFNcy3W4kfA8BiWIZ5c8Ful0XQb4B1x6JJZF03fjEmJRk/bCuCPRbRdj8n0nBNDJey
         gTfyfrqHCg6EYrX+OL0Wl9ADYZl671m85KC+KD3GbloS5aUDNj+f8vp3S0GpFFLVvm8e
         XyphmqltO9ZNFpvCsH8Mp8ktiqJPPTXklf0TU=
Received: by 10.86.251.40 with SMTP id y40mr3786432fgh.57.1254184346741;
        Mon, 28 Sep 2009 17:32:26 -0700 (PDT)
Received: from localhost.localdomain (abvk246.neoplus.adsl.tpnet.pl [83.8.208.246])
        by mx.google.com with ESMTPS id l12sm3692fgb.5.2009.09.28.17.32.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 17:32:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8T0WIjX020565;
	Tue, 29 Sep 2009 02:32:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8T0WH7m020562;
	Tue, 29 Sep 2009 02:32:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m33a66br69.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129279>

Jakub Narebski <jnareb@gmail.com> writes:

> Anteru <newsgroups@catchall.shelter13.net> writes:
> 
> > I'm currently evaluating DVCS for a project, and we're at a point where
> > it comes down to either Mercurial or Git. Right now, I'm advocating for
> > Git, while my co-workers like Mercurial, so I'd like to provide some
> > good arguments in favor of git. Unfortunately, I'm not a git expert, so
> > I hope I can get some help here ...
[...]

> > So far, my key arguments are that git is more robust (more projects
> > using it, larger developer base), of course git's excellent performance
> > and the much better support for SVN, which is important for us as we can
> > slowly migrate from SVN->Git, while hgmercurial is still in the making
> > (and Python's SVN->Hg switch is for instance waiting for it).
> 
> hgmercurial? or hgsubversion?
> 
> There is also fact that git has superior support for multi-branch
> development, which I think is the workflow most suited for distributed
> development.

See also http://whygitisbetterthanx.com/#hg

-- 
Jakub Narebski
Poland
ShadeHawk on #git
