From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using a different index and HEAD
Date: Sat, 13 Nov 2010 09:25:46 -0800 (PST)
Message-ID: <m3aaldf863.fsf@localhost.localdomain>
References: <20101113152906.GA24903@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Enrico Weigelt <weigelt@metux.de>
X-From: git-owner@vger.kernel.org Sat Nov 13 18:25:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHJrO-0003u0-P5
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 18:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab0KMRZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 12:25:50 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab0KMRZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 12:25:49 -0500
Received: by eye27 with SMTP id 27so2436476eye.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0WtZuqIsjArpe01gYWDyktc/LtK5fUabij8UHfXJki8=;
        b=pWd2EUJgXoETE26u8DkC9YJizgQ13ZZ3Fodw5vQPKDX+Q6YWf7rBrG0nvtyEKAQf7K
         DeXrgkrwumBvvblFvXhgLnPHlyImPcfYv0fTbDc443/hQXxOMQG35aO29E8s4mOLMO5s
         iXvq+srA7qy/RVHcHKkuyveHpuTmYZdMvFoFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VuBY+aQL5J01BUR/bxG/mmz+k8pV1cVYF/D/MOcsb7VCZQaUu1WdaAQnxMzLElscPA
         XfkaC/lMvs5zZu5+gRiUvfdp+A2ww5mP/lG+vrNVkdQ0Ng1+siHCBKF9mItPvDuUlsMu
         si+fVyB+I6WB7hWtVNtuD9XhL56QfwddGzi5A=
Received: by 10.213.19.6 with SMTP id y6mr4180099eba.73.1289669148035;
        Sat, 13 Nov 2010 09:25:48 -0800 (PST)
Received: from localhost.localdomain (abwe118.neoplus.adsl.tpnet.pl [83.8.228.118])
        by mx.google.com with ESMTPS id q58sm4575385eeh.15.2010.11.13.09.25.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Nov 2010 09:25:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oADHPCQ0023178;
	Sat, 13 Nov 2010 18:25:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oADHOrW9023168;
	Sat, 13 Nov 2010 18:24:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101113152906.GA24903@nibiru.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161391>

Enrico Weigelt <weigelt@metux.de> writes:

> I'm currently thinking about an IDE toolkit entirely based on git,
> which eg. versions every single file save operation (so, IOW: an
> separately versioned workdir) automatically and later allows to
> rebase/rework this to tell what really gets committed to the
> actual working branch. For this multiple indices and refs/HEAD
> pointers would be very helpful.

UGFWIWNI (Using Git For What It Was Not Intended) ;-) ?

> 
> Is there already a way to tell other locations for index file
> and current HEAD symref on command line (just like we have w/
> --work-dir etc) ?

There is GIT_INDEX_FILE environment variable (see git(1) manpage);
you can maniplate symrefs such as HEAD directly using git-symbolic-ref
(and git-show-ref, git-rev-parse, etc.).

You can also check 'contrib/workdir/git-new-workdir' script.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
