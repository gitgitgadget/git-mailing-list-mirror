From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: history missing
Date: Mon, 08 Nov 2010 05:29:20 -0800 (PST)
Message-ID: <m3mxpkeyh4.fsf@localhost.localdomain>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
	<20101108090230.GC2430@burratino>
	<AANLkTi=rT0S1H8pFt9d+FYVme4fjNNzY6O6evuBwo-ZB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Vitaliy Semochkin <vitaliy.se@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 14:29:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFRn2-0007G5-0C
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab0KHN3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 08:29:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41583 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab0KHN3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 08:29:22 -0500
Received: by fxm16 with SMTP id 16so3970741fxm.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 05:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=5xYYFcDAVE0ZFmBonwYmuTjEcrc0OL1giMeujUS7uBA=;
        b=ZTSp4jcShDZlZogMPOZEynujAl1DAzJ5ql5MlYYvdvZUZP9nMoiUq4Z5DWEWOmxGGN
         paH0edg90wEoK3IjZ3G5/Bozun7zUm+RbS6N7Uqi6VHw/l1Is57QEWuUsZeEr83jl3yO
         Zx0eFN/2vYyjyUEooinDK8Uooeo/pZ06k38w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=koa5DcC06sW4hHRg8WS3Fvk8R6P+jFxVpgKQhcc5egdGKcbd0oSQd5dqzyRxdbqxNP
         I4kEqi8CoREM5gP/PDyIgzSJsAh8u3R2r9s+0PJMzg/JZhhcMsZtTH0wjc4U0AwKqmA7
         2gZQ0gQQForFS9i+ogVBlHh0TL7wzHxO7Or2E=
Received: by 10.223.78.140 with SMTP id l12mr3719609fak.147.1289222961416;
        Mon, 08 Nov 2010 05:29:21 -0800 (PST)
Received: from localhost.localdomain (abvu240.neoplus.adsl.tpnet.pl [83.8.218.240])
        by mx.google.com with ESMTPS id k4sm2116353faa.8.2010.11.08.05.29.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 05:29:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA8DSjTA016967;
	Mon, 8 Nov 2010 14:28:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oA8DSOUx016960;
	Mon, 8 Nov 2010 14:28:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=rT0S1H8pFt9d+FYVme4fjNNzY6O6evuBwo-ZB@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160935>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> On Mon, Nov 8, 2010 at 4:02 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Vitaliy Semochkin wrote:
>>
>>> I cloned a remote repository
>>> to check recent changes in origin/master I do:
>>> git fetch origin master

This fetches into FETCH_HEAD _only_ from "origin" *remote*.

>>> git log origin master

This show log of 'origin/HEAD', which probably is 'origin/master'...
but which didn't get updated, and local branch 'master'.

>>>
>>> recently I found out that log doesn't show recent commits
>>
>> Yes, this can be confusing.
> 
> I agree and I believe this has come up a lot of times before. I talked
> to Jeff and Junio about this at GitTogether and Jeff said he has a patch
> for it that he would try to get up to date in a while. (Thanks, Jeff!)

How can this issue be solved?  The meaning of parameters in 'git fetch'
is different from meaning of parameters in 'git log'.

Unless it is about adding hint / advice for when doing 
'git fetch <remote> <branch>'...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
