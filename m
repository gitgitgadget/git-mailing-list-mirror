From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Fri, 21 May 2010 08:54:03 -0700 (PDT)
Message-ID: <m34oi1s13e.fsf@localhost.localdomain>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:54:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUY9-00064T-SS
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240Ab0EUPyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 11:54:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43650 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab0EUPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 11:54:05 -0400
Received: by fxm5 with SMTP id 5so987169fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=O0goNTye5DZIfjYwIF3WGO0U38U5fWMeaVEKky/CJoc=;
        b=UUhkPZU3Uelt7qa6j3OVDDi/uohhW5STJOvtOuHah+pKWR4dLl/1A/81P4chWAcrug
         5wOYExi6coRTaf6dRsvfLI++wiJ+lM5mvaWLlzVM8heqvrUHwxFAjWQwOgsfw70zpV8z
         q9aQT76w5SZ+h1gLiGL1y6K2qCEuIRmnXPN8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=f7jRvcebdMg0OYzepeCBY1maWAXsx1HU+vBp0X0/WHxSbQUQQyUozU4agByhZVAX33
         CV8U9UGLgMTKsDTq8dGDqDMnEX4mqrrDhqEkYWSZFa+v5O0amV1l5/hMmnQjU6Owtc8e
         ytpkqiTrUadFpU6dhJl7uScRqElbxAPeuHvcI=
Received: by 10.102.237.3 with SMTP id k3mr1798090muh.125.1274457243882;
        Fri, 21 May 2010 08:54:03 -0700 (PDT)
Received: from localhost.localdomain (abvl111.neoplus.adsl.tpnet.pl [83.8.209.111])
        by mx.google.com with ESMTPS id y37sm4273958mug.22.2010.05.21.08.54.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 08:54:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4LFrb6d011014;
	Fri, 21 May 2010 17:53:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4LFrQqA011010;
	Fri, 21 May 2010 17:53:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147471>

Daniele Segato <daniele.bilug@gmail.com> writes:

[...]
> I think that to introduce git in my company I should at least go throw
> this 5 points:

> 1. prepare a project management web application easy to use and
>    mantain (like github or gitorious for instance) on one of our
>    intranet servers.

Note that while Gitorious (in Ruby), InDefero (in PHP), and Girocco
(with gitweb, Perl + shell script, used by http://repo.or.cz) are open
source, GitHub is not.  There is GitHub:FI if you want [self] hosted
GitHub-alike, but it is proprietary and it is not cheap.

There is also Gerrit, a web based code review system, which runs in
any standard Java servlet container.

[...]
> Can you also tell me if you think there is some risk in migrating and
> what kind of difficult I could encounter in the process?
> For example: like any company we have a proxy and a firewall..
> For example: if i had to commit something working from home I connect
> to the Subversion via HTTPS and commit, with Git I should have ssh
> access which is something that I probably will not have.

Actually with never Git you can push and pull via HTTP(S) natively,
thanks to git-http-backend.  With older Git you had to use HTTP as
"dumb" protocol, using HTTPS + WebDAV to push (note that for "dumb"
servers git-update-server-info must be run, e.g. via a hook).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
