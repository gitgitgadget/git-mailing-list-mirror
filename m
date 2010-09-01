From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Additional remote on a local clone. Where do the objects go?
Date: Wed, 01 Sep 2010 03:34:19 -0700 (PDT)
Message-ID: <m339ttoiqh.fsf@localhost.localdomain>
References: <i5kudr$dp7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:34:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqkeB-0007HR-7K
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab0IAKeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 06:34:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62920 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0IAKeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 06:34:21 -0400
Received: by wyb35 with SMTP id 35so9071767wyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ioTnEpeqCqP2Yxus4gQ9a48DQxiQ9SeLJhyLinrdmIk=;
        b=IQfY5f8otqeqkaSoJ2XmyRDNpjIQmL5VqM95b6Rv+wTXtWSqcABU+J91O+KODHzb3L
         jdSWDGSjVgDjAMwzeV79a50LxuCviT0dGQ0yKc1VF6E30MBWeNqAwdkKK+lgr5SVzb8L
         AiNcjTTDvqQWP/TzNvlbFB94EOoMRcYp9DayA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LEAqb5No7hjuQsGE8y9sk4XuI8xg6Piky7Pbp+6ds6jJOyxycT06ndAbMOwy25hoPS
         qhCsrgj3VewcRwKWNIeqewNXTI9eyHvB//6n0oWJRBymLz3twQpH7KTQZqsUTT8euiMn
         v8Sk+T6BN0IestcRNewJHlBTVNpxvxTKO8DCk=
Received: by 10.216.159.6 with SMTP id r6mr129221wek.55.1283337259984;
        Wed, 01 Sep 2010 03:34:19 -0700 (PDT)
Received: from localhost.localdomain (abwf138.neoplus.adsl.tpnet.pl [83.8.229.138])
        by mx.google.com with ESMTPS id o49sm6007163wej.19.2010.09.01.03.34.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 03:34:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o81AYKYk024533;
	Wed, 1 Sep 2010 12:34:31 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o81AYFuK024530;
	Wed, 1 Sep 2010 12:34:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <i5kudr$dp7$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155036>

Stephen Kelly <steveire@gmail.com> writes:

> The aim is to have multiple local checkouts of different branches of Qt 
> while sharing the same object store. [...]

Why not use git-new-workdir shell script from contrib/worktree/ in
git sources[1]?

[1] http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/workdir/git-new-workdir

-- 
Jakub Narebski
Poland
ShadeHawk on #git
