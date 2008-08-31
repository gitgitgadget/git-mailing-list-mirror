From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Announce: gitbuilder, an autobuilder for git-based projects
Date: Sun, 31 Aug 2008 02:25:35 -0700 (PDT)
Message-ID: <m3d4jpr0xk.fsf@localhost.localdomain>
References: <32541b130808302007r3d570aa8ka221f210251944ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git mailing list" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 11:26:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZjCn-0003Fv-N5
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 11:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYHaJZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754603AbYHaJZk
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 05:25:40 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:61226 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYHaJZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 05:25:39 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1470075muf.1
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=KWxeHiKSTq2FyAPDDt6hvcImvabM1jGHnkg3MOrOO3A=;
        b=fOgAu+t6ZkLomj3x0rsTko7Ux0EVqI0Q7F90bOx6bDZjgr3ML8AP3/Geyfje39OwWG
         CggCyWXCRHolmSD2beoFKIQFuEdHJMVG2+CdJ3XEAaxUKwvXoh86ZDTxpyissMPKsLTx
         YgohtujM4q3vge+LQBhcwtyBdEckjji28aqg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=d6zGrJ2ysBT1z46ud533Y6L9hltPx2IGBwqnsFWZ41VdqHor9s5JoS+7P4Y/ItU94L
         0z5ZAtKjf0ccD/3u5wIV0AzO3WYr/OE8jfIpt6Dievt15UnlZPOTww5QV4lePuTBYfDZ
         BNRQRiAwJM9kKvKav43Iz/lZd5HBAmtwutLQQ=
Received: by 10.103.176.20 with SMTP id d20mr3326060mup.136.1220174736611;
        Sun, 31 Aug 2008 02:25:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.200.211])
        by mx.google.com with ESMTPS id u9sm22882707muf.9.2008.08.31.02.25.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Aug 2008 02:25:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7V9PThT011244;
	Sun, 31 Aug 2008 11:25:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7V9PSLA011241;
	Sun, 31 Aug 2008 11:25:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <32541b130808302007r3d570aa8ka221f210251944ba@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94466>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Hi all,
> 
> I recently made the first public release of gitbuilder, a set of
> relatively simple scripts for automatically building your favourite
> git-hosted project, optionally running unit tests, and reporting
> pass/fail results.  In case of failures, it automatically uses "git
> rev-list --bisect" to try to track down the first commit that started
> failing.  It's also smart about branches; it knows how to build each
> commit only once, no matter how many branches include it, thus greatly
> simplifying future bisections.
> 
> You can also get an RSS feed of the autobuilder results in case you
> want live updates as things happen.
> 
> To find the scripts, see here:
> http://github.com/apenwarr/gitbuilder/
[...]

Thanks.  I have added it to Git Wiki:
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-f02930f5bac8c11ea580ec2d0ee91322fc108e94

Please check if the information is correct.

P.S. Should I add it as one of possible tools to Git User's Survey 2008
(to be started at 1 September)?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
