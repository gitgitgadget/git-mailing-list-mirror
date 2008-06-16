From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 13:11:10 -0700 (PDT)
Message-ID: <m3y755nq99.fsf@localhost.localdomain>
References: <20080616110113.GA22945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8L3m-00041Q-4p
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbYFPULQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYFPULP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:11:15 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:31343 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYFPULP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:11:15 -0400
Received: by ik-out-1112.google.com with SMTP id c28so4267226ika.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=r4a+NxAHGbBquQHj4VZe3XdnM9eePyDM1i7gPLAR1VU=;
        b=TFvbxjKioFh31/s4RrNp2iiD3XUVjYlKVI13M6XBMv44oE12Mo2ci0/59L0jG3VN2s
         uu74a0MGtRpv5uriS8Igh4CJpaZe/XX7wmAoP+YTOA6wrFIUaBawHBhJVkeGk7nFPEz+
         bqH2GHkO49rM31Y/YmGn/+roq0wsipdkndrXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=WRcr44vShsBEMbmSsNApbp5sYFElauJF/mmtnz03RxaBFtQIsOYxRebrvm3vcMdq3k
         XU2A4NJJywHYdNwUkkMngNlE0cGDIwq3SA7p2dXhNRNziaff+VMVxJSAgQXCO6rOa89h
         YEQxPOpL4QevPPqCAAVj9fyHK5Scj5mO8Qd7w=
Received: by 10.210.91.17 with SMTP id o17mr6555204ebb.172.1213647071092;
        Mon, 16 Jun 2008 13:11:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.236.117])
        by mx.google.com with ESMTPS id k27sm2694466ugd.72.2008.06.16.13.11.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 13:11:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5GJHfHx026516;
	Mon, 16 Jun 2008 21:17:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5GJHdXO026513;
	Mon, 16 Jun 2008 21:17:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080616110113.GA22945@elte.hu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85224>

Ingo Molnar <mingo@elte.hu> writes:

> We are running a rather complex Git tree with heavy use of git-rerere 
> (the -tip kernel tree, with more than 80 topic branches). git-rerere is 
> really nice in that it caches conflict resolutions, but there are a few 
> areas where it would be nice to have improvements:
[...]

>  - File deletion: would be nice if git-rerere picked up git-rm
>    resolutions. We hit this every now and then and right now i know 
>    which ones need an extra git-rm pass.

>From what I remember some time ago on git mailing list there was idea
for git-rerere2, which would record resolutions on tree level,
i.e. record file renames.  It could probably record file deletion as
well... would someone implement it, and didn't it stay loose idea.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
