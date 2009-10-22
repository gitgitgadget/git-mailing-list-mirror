From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 13:59:15 -0700 (PDT)
Message-ID: <m3hbtrdu1r.fsf@localhost.localdomain>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14kl-0004Ak-08
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbZJVU7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 16:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756669AbZJVU7N
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:59:13 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48442 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480AbZJVU7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:59:12 -0400
Received: by fxm18 with SMTP id 18so9673893fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DpwH5IrPevbHKrYFudSzKaBvoqOu4DT25UHlyUAKeR0=;
        b=cLtBwg7pwWPnsT0Kj6M/lZl8w4oCy0x8op6gL5eScKRq0ywUFQfozWLKz0ZdTilF5r
         dO3CRTsBJz23truJuue34shwd+EcpdCYMcYHtPW8Eyrx7kq5Xp37I1pn3DjO1DCR7JVF
         uuogO51sya/cFIjhgm9Vvb9/sJvePd1oHe8VU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=luQgB/MrWmCxLJq4s/ZtE5gGxwaKvqlGx9ob7pohUN8kosj2ORde945tJu+APVe5F6
         dbckWT3Qm1KzjFSKGUU+3+YwfdkB0o73tiaE3OjjHOJSQvah9c6M07b1XMWqgwKN/GxB
         WGmxAAZTbd737ketM8GhRqdxTtFZLV23/sk6c=
Received: by 10.204.20.142 with SMTP id f14mr1489555bkb.64.1256245156337;
        Thu, 22 Oct 2009 13:59:16 -0700 (PDT)
Received: from localhost.localdomain (abvi94.neoplus.adsl.tpnet.pl [83.8.206.94])
        by mx.google.com with ESMTPS id 16sm133646bwz.15.2009.10.22.13.59.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 13:59:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9MKxFXi022758;
	Thu, 22 Oct 2009 22:59:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9MKxDnj022755;
	Thu, 22 Oct 2009 22:59:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131060>

Howard Miller <howard@e-learndesign.co.uk> writes:

> I have a branch with a whole series of commits. I want to export this
> work to be customer (to their svn repo if that has any bearing on it).
> All the stuff in the history is irrelevant to my customer ("committing
> now, going to bed" etc.) so I'd like to create a new branch that only
> has one commit.. the end point with a new message. Is this possible?

You can use either "git merge --squash" or "git rebase --interactive"
(changing 'pick' to 'squash').

-- 
Jakub Narebski
Poland
ShadeHawk on #git
