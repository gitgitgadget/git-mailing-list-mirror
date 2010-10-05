From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Move tags to branch
Date: Mon, 04 Oct 2010 18:10:36 -0700 (PDT)
Message-ID: <m3mxqtfnrk.fsf@localhost.localdomain>
References: <AANLkTinzGy62ETZdry5y1qTi0djkt9d72_3soCP6K_Qn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 03:10:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2w3H-0006Ix-P8
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 03:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab0JEBKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 21:10:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38682 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab0JEBKi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 21:10:38 -0400
Received: by eyb6 with SMTP id 6so2313147eyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=6z0zRI3QImtJChKRy6SlzRo24zhtJKssDjWGWadboxg=;
        b=lz02/6CmuTT3/TU2nWjm0grNqRgyLd2Ysbb+Urcl8pqkA4COLsv5vqgkOowyhC1maJ
         xCnfUul6Ih7oOVJnSuAylSl7ZEnnnS2w5vbeA3VZIKfy6JEsVYkNKKln6QT0u+K0TkO3
         k5n6xlBiVRa8glnvjd4dvPz+yLB0se4CnueoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=B4ZbWiqcJ2U4eZjzBKt8ib7yBSJmnRo0xMcCdtCSZFfshDgfo/Sbixpom9rRLJbjxF
         dcXayU7WquVBUFQrg718IQ4Jb4uFeDicumFfKwjex24Djn4V+ep8ZGYyxSs3utNyd9UM
         gvxJ0yChCQzlJVef6vMKVNLbw+tVCkRGaVyrA=
Received: by 10.213.56.6 with SMTP id w6mr459691ebg.32.1286241037304;
        Mon, 04 Oct 2010 18:10:37 -0700 (PDT)
Received: from localhost.localdomain (aeho253.neoplus.adsl.tpnet.pl [79.186.196.253])
        by mx.google.com with ESMTPS id v8sm8291180eeh.14.2010.10.04.18.10.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 18:10:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o951AIqL029481;
	Tue, 5 Oct 2010 03:10:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o951A7hh029477;
	Tue, 5 Oct 2010 03:10:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinzGy62ETZdry5y1qTi0djkt9d72_3soCP6K_Qn@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158154>

Mathieu Malaterre <mathieu.malaterre@gmail.com> writes:

>   I have been using svn2git to start using git. However svn2git
> creates tags from HEAD instead of the branch. Is there a way to move
> tags back to the branch ?

Isn't it by a chance caused by the fact that Subversion does not
"enforce" tags to not change?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
