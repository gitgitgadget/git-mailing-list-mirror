From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Re: how do I exclude a commit from set of commits to be pushed.
Date: Sat, 3 Jul 2010 23:07:54 +0530
Message-ID: <AANLkTimmCdCn1dkbogdVqzPBMeGQDNEesM8zdarFL_wv@mail.gmail.com>
References: <AANLkTiko8joz_a94QwHwdDwlsjXslu8LdWAnJuvShFFI@mail.gmail.com>
	<201007031804.33350.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jul 03 19:38:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV6fB-00024e-73
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 19:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab0GCRh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 13:37:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57512 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab0GCRhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 13:37:55 -0400
Received: by gxk23 with SMTP id 23so2058740gxk.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ThiT07HmJDfbSBf1oGDZNoy6Qoc5b0ALlJMtu2VapNc=;
        b=fqHkRkQfK6BmsYVXdHIfSgDEiqMl4mh2DAndZXk3pcOJqP2cYPz1kxgiRp1preea1F
         FPKY/8mq3DoDWs5yOF6eGrsXgqqdCwCzd2PfKYMpkGg4f4697BPbp/Vpj0sXdf2Z07Tp
         xaTBVp1RvH+Uk+cdz4+HlsABVJ3n3uOBZcTbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=S+HNs8gD7zpCsNxVQ6s/6tEpPYW2t64HXAqz/Pc+8LS3PgBfRn1GIFLd5qZEJ48YNQ
         dlcIBSyxBNhF1vwymiQJETAsA3hNE6RIZs6bGldwlvLePPiToe46RfneoG4XV9Ek3aEt
         KTuGsuJxmZuf0uv7Sui8hEoNMxqFSTlcgTdiY=
Received: by 10.90.94.17 with SMTP id r17mr960489agb.5.1278178674388; Sat, 03 
	Jul 2010 10:37:54 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Sat, 3 Jul 2010 10:37:54 -0700 (PDT)
In-Reply-To: <201007031804.33350.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150196>

Hi

Thank for the pointer; Do you think following scriptlet is good for
modifying specific commit ? and do edit.

cat ./modify_specific.sh
git rebase -i $1 && git commit --amend && git rebase --continue

Thank you in advance
-Mahesh

> You probably want to squash C5 into C4. Look up 'git rebase --interactive',
> and the 'squash' instruction. A good intro can be found at either
> http://book.git-scm.com/4_interactive_rebasing.html or
> http://progit.org/book/ch6-4.html
>

>
> You may want to read the entire Pro Git book ( http://progit.org/book/ ) to
> get a firm grip on the Git object model.
>
>
> ...Johan
>
> --
> Johan Herland, <johan@herland.net>
> www.herland.net
>



-- 
Thank you and best regards.
Mahesh Vaidya  / 9740500144
http://www.twitter.com/forvaidya
