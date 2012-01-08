From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Sun, 08 Jan 2012 13:57:03 -0800 (PST)
Message-ID: <m3r4z9eu36.fsf@localhost.localdomain>
References: <20120108213134.GA18671@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk0jp-00032f-8k
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab2AHV5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:57:08 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52487 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab2AHV5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:57:07 -0500
Received: by eaad14 with SMTP id d14so1778011eaa.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=P7iRrTbwvsIDrdrFoFBNMYBiZM7dOObNKVjPRJBoy0k=;
        b=H8x6olqcJXs21ZhgX2XMYWaa1j6FKFwD8fjq+Qy3S0WjHSC6r6uQHOwQcRA6NKUPCR
         2Q62fbde+Pa/NTlr4dw//0+uCwnTFm8TCgZs2yL5H4Tx0t9GYwRaYG4pcH7cQGfoxS7g
         q70nY6cFo8B0bnJO4F5wxFoCneBe6BkhJeLDY=
Received: by 10.213.28.193 with SMTP id n1mr1133980ebc.43.1326059825251;
        Sun, 08 Jan 2012 13:57:05 -0800 (PST)
Received: from localhost.localdomain (abwu182.neoplus.adsl.tpnet.pl. [83.8.244.182])
        by mx.google.com with ESMTPS id y12sm281275463eeb.11.2012.01.08.13.57.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 13:57:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q08Lv2k1019227;
	Sun, 8 Jan 2012 22:57:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q08Lv1hF019224;
	Sun, 8 Jan 2012 22:57:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120108213134.GA18671@ecki.lan>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188146>

Clemens Buchacher <drizzd@aon.at> writes:

[...]
> In order to determine a suitable range automatically, it is a reasonable
> heuristic to rebase onto the most recent merge commit.

Why not additionally / instead take into account remote-tracking
branches for "push" remotes?

> It does not
> guarantee that published commits are not included -- indeed there is no
> way to do that. But, the range is usually large enough to contain the
> desired commits. Also, this mechanism works regardless of whether or not
> branch tracking has been configured.
> 
> So instead of the above command, one can instead use the following:
> 
>  git rebase --fix
> 
> By default, the range is limited to a maximum of 20 commits. This can be
> changed by passing a different number to --fix, e.g.:
> 
>  git rebase --fix=50
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Nice idea!

-- 
Jakub Narebski
Poland
