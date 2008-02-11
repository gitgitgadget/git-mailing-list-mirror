From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Mon, 11 Feb 2008 05:02:31 -0800 (PST)
Message-ID: <m3ve4vejdr.fsf@localhost.localdomain>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 14:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOYJT-0001vA-Ma
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 14:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYBKNCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 08:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbYBKNCg
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 08:02:36 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:3412 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYBKNCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 08:02:36 -0500
Received: by fk-out-0910.google.com with SMTP id z23so4492545fkz.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 05:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=6ELbfx9J6FqcchmFMxKWs+a/P5vNr5e1CPb+aEqmuFA=;
        b=Crnx6U2nFulN5i/JC8xf6URZn/sBLsBfhPrlekjfPgHLJNS6oAdEGMi6SckTGcVBZCM33Esta81CP6RQXjjFCBX410NMg/Sza7290wQlMk6NBVoL2ep1XqylazpzYUP4KV4GVKZFwcUtv/f1EV79IdsJs3HTosSaBnoCFkJr8JM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Em9+pxCsm3rUG0XMVTbpgQtb5eGYzsl5cSOLff783WsgMQtv3nmK74Nsq/bG273VRMdABkl7RwAO4CT8kZ2AMXhw00dMGJOc5SZbg70vVo7pGBa/Zid2nllnfyAPqtPiCvLcxxSD3tC3JnTSiogJ4finWPjdV54Wc3JxE9umfxA=
Received: by 10.82.159.15 with SMTP id h15mr29441926bue.36.1202734953664;
        Mon, 11 Feb 2008 05:02:33 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.19])
        by mx.google.com with ESMTPS id m5sm20206939gve.11.2008.02.11.05.02.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 05:02:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BD2P96005923;
	Mon, 11 Feb 2008 14:02:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BD2OE0005920;
	Mon, 11 Feb 2008 14:02:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73529>

Wincent Colaiuta <win@wincent.com> writes:

> Just noticed a bug (possibly bugs) in gitweb.
> 
> Look at a shortlog page like this one:
> 
>   http://repo.or.cz/w/git.git?a=shortlog
> 
> Mouse over the "next" link at the bottom and you'll see this is the URL:
> 
>   http://repo.or.cz/w/ARRAY(0x85a5318)?a=shortlog;pg=1
> 
> Which obviously won't work...

This is bug in repo.or.cz version of gitweb, which is slightly
modified as compared to the "stock" version. Such error would be
catched by the gitweb 'run as standalone script and check stderr'
test script.

I have CC-ed Pasky.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
