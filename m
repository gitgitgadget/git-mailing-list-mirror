From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git submodules
Date: Sat, 17 Oct 2009 10:27:00 -0700 (PDT)
Message-ID: <m3tyxydj8f.fsf@localhost.localdomain>
References: <f488382f0910171015j1a6d4d9fg690867154334c514@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	crawl-ref-discuss@lists.sourceforge.net
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzD3k-0002cU-Ls
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbZJQR07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 13:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbZJQR06
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:26:58 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:37957 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbZJQR06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 13:26:58 -0400
Received: by fxm18 with SMTP id 18so3544989fxm.37
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zOxrza9R0OCB465Vex6DDCAArPOfo2f9B70bByMCAiI=;
        b=hlWompvFiaz1WfDgsa2TpKfR70byghpQUtknr9KNY9MMNDXPtXDJrCtEGMR2pjmirI
         JUxRcKK8VlOikw5HnIHN7XkseBrD9Jyp1puoqZhVCz7xSnO97H9uvCNrWnmL7f2OjCEE
         b8QmKoW8wGWEWjfPyughCOsJ7Kt3Zu5m37UQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rowCoafzXbAHiKhhKcYdfgR5u0dfVKtjyMthDHiK+/vtMKEwZu6fIuhlVU1MBlDuUM
         +G4c+H99sE6ukUCz9Wga/lKXhUZsneIZslY3+dHj6TdHr4pZ9IMTemoXQF04hxSBt9d3
         zkKCOUiOtybYVc4B6exExKGvYCRwMxh2nBtv0=
Received: by 10.103.78.7 with SMTP id f7mr1218419mul.95.1255800421970;
        Sat, 17 Oct 2009 10:27:01 -0700 (PDT)
Received: from localhost.localdomain (abvw176.neoplus.adsl.tpnet.pl [83.8.220.176])
        by mx.google.com with ESMTPS id s10sm2603387muh.54.2009.10.17.10.27.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Oct 2009 10:27:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9HHQw4j000911;
	Sat, 17 Oct 2009 19:26:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9HHQvb8000908;
	Sat, 17 Oct 2009 19:26:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <f488382f0910171015j1a6d4d9fg690867154334c514@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130569>

Steven Noonan <steven@uplinklabs.net> writes:

> We're using git submodules for the contributing libraries. When I
> commit changes to those contribs, it correctly shows in the parent
> repository that those folders have different revisions than what's
> currently committed. However, if someone pulls those changes, it
> doesn't automatically update the contribs to match the committed
> version. But doing a pull or merge _should_ update the working tree to
> match the committed versions. It does with file data, so why not
> update the submodules? Especially if the submodule revision matched
> the committed version -before- the pull. Why are we forced into using
> 'git submodule update'?

Because you might want not to use most current version of submodule,
so git-pull shouldn't update submodules by default.  And because
git-pull didn't learn --recursive option yet.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
