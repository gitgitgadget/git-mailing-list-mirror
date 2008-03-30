From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add new git-graph command
Date: Sun, 30 Mar 2008 13:41:43 -0700 (PDT)
Message-ID: <m33aq8ueq5.fsf@localhost.localdomain>
References: <20080330195840.GA8695@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 22:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg4Md-0007Hq-HA
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 22:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYC3UmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbYC3UmI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 16:42:08 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:6307 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbYC3UmG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 16:42:06 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1936448mue.5
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=qiyGML6SNGIW4LlChNChDllaCagzjwUsjJbbr/3Cc7I=;
        b=DRk2ImJ1JWh3fi8kBkRsUssnV/58tEJs7IY8LKvI3zdMmEMvx45GXMR/zRJ/RBBEFMe5+8SESBu49xfGy5mwP0lPC2DytJ5i9slE2wBwSf1AqTXtpv+G/hj6dEOhcysGo7ZTST5k+2AN74i9Ht/9DPeW/2zIWqM+2YOBH8drLQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ZKStYi18KW/gLnaE0K+siUa521eASFIDn4P/TbJehjDAMTJc9tAENs5QKwmDrdoyr8+rVuD8crkNxQWfW/Yza5hbwVICkMbTPa2CsIdl4t/qc8yhMbS+NaQqZtCZvaIkzxGUr0JU61m9M5LP+AvFaHXQgXPSug7B6Bw8DoXGw7Q=
Received: by 10.78.135.20 with SMTP id i20mr18444982hud.18.1206909712574;
        Sun, 30 Mar 2008 13:41:52 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.216.205])
        by mx.google.com with ESMTPS id i8sm10465014nfh.1.2008.03.30.13.41.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Mar 2008 13:41:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2UKfcki007254;
	Sun, 30 Mar 2008 22:41:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2UKfMNo007249;
	Sun, 30 Mar 2008 22:41:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080330195840.GA8695@adamsimpkins.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78513>

Adam Simpkins <adam@adamsimpkins.net> writes:

> This is a first pass at a command to print a text-based graph of the commit
> history.  It is similar to the history graph shown by gitk, but doesn't
> require a windowing system.

Should I understand that git-show-branch has too cryptic an output?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
