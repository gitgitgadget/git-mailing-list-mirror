From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can git reset or checkout be reverted?
Date: Fri, 06 Feb 2009 06:47:40 -0800 (PST)
Message-ID: <m3vdrnvczd.fsf@localhost.localdomain>
References: <20090206141940.GB7231@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVS0y-0004XM-5b
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZBFOro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbZBFOro
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:47:44 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:34912 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZBFOrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:47:43 -0500
Received: by ewy14 with SMTP id 14so1350884ewy.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 06:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=MPYKToj2Jwj1Oa6aH25juEBOIajFuh+aYanii4C7tH8=;
        b=TewpaVXahH2Q8jQEQ946xbmeJim2knDUfKxOQm80V68+3bRwJJcqA3Adx2nhvFxKJ3
         1SAr4Xpdmya1VLPftoNvIN+itNYpRzW/EZqS3A9zlx7gAlqsbrdbsXELP9KuM13OJGCX
         US927WhOaxlQmqDfBjHTrkavNctX1UtLbQd7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=l+SvmGo1ycYnZEIZDFXYYRr/uhjUOS+EOZ1Q6nQMuiZUMB+aqJeIBngrcSgKVTA1bE
         yMONrUQu4blGt8m8xGJwvo2/1ilQqaIkajz7nMgsrPTtoXQr5nNjQ0iYiyOr6YfhWopM
         8LFvQiO0Dd+HsRrB7+X6B5WP8Iw05ru2DHd30=
Received: by 10.67.89.15 with SMTP id r15mr574151ugl.59.1233931661228;
        Fri, 06 Feb 2009 06:47:41 -0800 (PST)
Received: from localhost.localdomain (abuz248.neoplus.adsl.tpnet.pl [83.8.197.248])
        by mx.google.com with ESMTPS id s8sm760888uge.40.2009.02.06.06.47.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 06:47:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n16Elb8m017136;
	Fri, 6 Feb 2009 15:47:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n16ElZMt017133;
	Fri, 6 Feb 2009 15:47:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090206141940.GB7231@b2j>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108721>

bill lam <cbill.lam@gmail.com> writes:

> If I want to recall a old version of testing by
> 
> git reset --hard sha1
> or
> git checkout sha1
> 
> then git log does not show anything beyond that commit. It does give
> some warning and recommend -b switch next time.  If I only do that by
> accident or ignorance.  How to revert to the original HEAD?

  git checkout ORIG_HEAD

or

  git checkout HEAD@{1}

You can check it out wrt. second form using "git reflog" ("git log -g").

-- 
Jakub Narebski
Poland
ShadeHawk on #git
