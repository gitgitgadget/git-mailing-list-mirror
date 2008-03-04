From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: tracking renames
Date: Tue, 04 Mar 2008 14:19:16 -0800 (PST)
Message-ID: <m3zltegmj0.fsf@localhost.localdomain>
References: <20080304135734.b2c2f473.akpm@linux-foundation.org>
	<590657100803041403q2cc68e21p1c92c244939eb148@mail.gmail.com>
	<20080304141029.52b12065.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Harvey Harrison" <harvey.harrison@gmail.com>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWfUc-0005Vk-8h
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 23:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241AbYCDWTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 17:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbYCDWTU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 17:19:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:3219 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990AbYCDWTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 17:19:19 -0500
Received: by nf-out-0910.google.com with SMTP id g13so652265nfb.21
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 14:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=orSZkx6ny+sVpqurwdlxY5J/c/DDFgCVhIwT3EbAnu8=;
        b=vcwcLma4hCmXsPfcEi2ye1zHA491tiX0eQhXk5vMkCeqXkp0doWGnka03uRZ9oI17LT+NrlZD7lvV5dhdjdf9vvpGo5C12/LQD17z8hWt0Bp4toAVMMPa+qp/+fyURVT2i2mPJQK06HGm8AIAsv4ZxZL90aY1bYdYkQEb8ByzzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=PqYQH2OVJi2UbxbogKflgWLHwqe8lmtS4yD3uydB524uIDx6NWOnK6VNRyeF2acZSAy/M3nHiWrPrsjIZjFg1SZxJjbcQ2qxmiPva59fOAy2nXDRwBmlvfFKta+RmeManZFIl00VQNd5Dhp10HfaQzr/pWnZcJyQwmdFWffUtYY=
Received: by 10.82.107.15 with SMTP id f15mr5231999buc.39.1204669157518;
        Tue, 04 Mar 2008 14:19:17 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id c25sm266428ika.9.2008.03.04.14.19.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 14:19:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24MJZMk016705;
	Tue, 4 Mar 2008 23:19:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m24MJWQ0016702;
	Tue, 4 Mar 2008 23:19:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080304141029.52b12065.akpm@linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76149>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 4 Mar 2008 14:03:54 -0800
> "Harvey Harrison" <harvey.harrison@gmail.com> wrote:
>> 
>> git-whatchanged --follow drivers/watchdog/iTCO_wdt.c
>> 
> 
> Oh.  Thanks.  It seems dumb that one needs to add an option to get
> it to do this.

In "git log <paths>..." or "git whatchanged <paths>..." the <paths>
option is "path limiter" and can be a directory. There can be more
than one path. And following renames is more costly.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
