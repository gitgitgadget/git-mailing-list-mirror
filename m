From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracability in git commits
Date: Wed, 30 Apr 2008 03:06:43 -0700 (PDT)
Message-ID: <m3lk2vodw4.fsf@localhost.localdomain>
References: <1209473739.5642.31.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 12:07:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr9E8-0001Zf-2S
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 12:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbYD3KGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 06:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbYD3KGr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 06:06:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:28248 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbYD3KGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 06:06:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so97392fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=+DSLMw21N6NWoEq4IdxotGVy20INW7mKMFSK5HJ5EC0=;
        b=CualjSo7JJF1pvnwhnE2G+sCAMqYfVu/1SlkLVhpumCo7L6wirEkDrS2H+s4aei6JsW01ddrPvyydseKFEu+WbM4kqn04yZSyA0HiYK8c6O2I7JvXm2ce92NCosX81r6pSw++ydmCPTWQ+N0Txc1TQO7WWh4F7XkQpQnpPCRGkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=WZTvhkB07pit+xcsarhnmuhsq1wVa1REbPIkGh/jDWSxkR0ZNsimJyBicqnhZcTsTMvem04/0dsVBJuVcs1LDYy9LiR+3odvxqg9o9n/1DZRn0haGXz7hisQpbXW9n/fMy1geUbSZAWNd6ccKAWBZU0+A84t3z43FklY5snfnuA=
Received: by 10.86.74.15 with SMTP id w15mr765957fga.4.1209550005068;
        Wed, 30 Apr 2008 03:06:45 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.201.205])
        by mx.google.com with ESMTPS id d4sm354367fga.4.2008.04.30.03.06.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 03:06:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3UA6bwr001436;
	Wed, 30 Apr 2008 12:06:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3UA6Zvv001433;
	Wed, 30 Apr 2008 12:06:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1209473739.5642.31.camel@dax.rpnet.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80820>

Richard Purdie <rpurdie@rpsys.net> writes:

> I've been wondering about whether its possible to provide some degree of
> traceability of commits to a shared git repository. The potential
> nightmare scenario is one developer making a commit pretending to be
> someone else.
[cut]

If you really need that, perhaps you would be better with using
Monotone, with its elaborate security and trust-related features?

IIRC we recommended Monotone to IPSec folks here...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
