From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Print last time and committer a file was touched by for a whole repo
Date: Thu, 01 Jul 2010 13:12:21 -0700 (PDT)
Message-ID: <m3eifnner1.fsf@localhost.localdomain>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:12:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQ7c-0007zk-2W
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759Ab0GAUMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 16:12:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35990 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab0GAUMX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:12:23 -0400
Received: by fxm14 with SMTP id 14so1678133fxm.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=InIVQhe12735YQIdkp93YV64KtFw7YqzglLkT5o/124=;
        b=j4TaEjjDfKZ1UT1tlRiJy/Y2Cu3Xmmuiz0LyxnbhLEayxsSNeRXf2TT2SM5atjWBas
         4RIRAQpyqLGEYKKZ4Pe/fPtwp7Izx7tqyXVfTCBpd3OgA07GIh5YPt2QZwUo3b2z0ZLI
         2+G9qQ9Jq1PwXfDcL/OmuPujx9y8cT/VKgObc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OQc9hF3iPi3qRNAM0x4h3/eAO6CsY4pKFQZHuv8gg01cRXqNFdX0xBgarvZNr7jcMW
         laL+BWriyfLNJsyBRiKCFpEFSGi2fkRYpGoauggl56pjby2Jf0xrhFv27INH1HcjrGYp
         gvotommMxgVfGpODv3JnhOhYKq6l1Im+4CxwY=
Received: by 10.223.123.145 with SMTP id p17mr12752far.22.1278015141971;
        Thu, 01 Jul 2010 13:12:21 -0700 (PDT)
Received: from localhost.localdomain (abwm116.neoplus.adsl.tpnet.pl [83.8.236.116])
        by mx.google.com with ESMTPS id j23sm53967795faa.26.2010.07.01.13.12.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:12:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o61KC32u000834;
	Thu, 1 Jul 2010 22:12:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o61KC3TR000831;
	Thu, 1 Jul 2010 22:12:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150068>

Tim Visher <tim.visher@gmail.com> writes:

> I need to get a listing of the entire contents of my current repo (as
> in, I don't need deleted files or anything like that, just the current
> snapshot) with the time the file was committed and who committed it.
> 
> Thoughts on how to do that?

There does not exist a single git command that would do what you want.
You would need to use 'git log -1 --follow' for each file in current
snapshot ('git ls-tree -r HEAD').  IIRC there is some example how to
do that in GitFaq or GitTips on git wiki (http://git.wiki.kernel.org).

Perhaps in the future 'git blame <directory>' would provide such
output, or its equivalent (tree blame).


By the way, what do you ned this for?  Git versions whole project at
once, not individual files.  Is it some legacy from CVS?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
