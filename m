From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git problems on Kernel.org?
Date: Sun, 11 Sep 2005 11:54:03 -0400
Message-ID: <4324531B.3080209@gmail.com>
References: <4323E3C0.1090109@tuxrocks.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 17:55:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEU9p-00013K-Tg
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 17:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVIKPyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 11:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVIKPyM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 11:54:12 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:19269 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964816AbVIKPyM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 11:54:12 -0400
Received: by wproxy.gmail.com with SMTP id 71so224880wri
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 08:54:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CS8T7bdtNRWwBvEL8Ijl6E/exlXRTylCrLJx4AgFhN3VgqZ3XROv+WfD3jmXtOlhGeqygiaSbRaLNOEh0l8t+MRlJrE+mEWDtuDjnaRT7FIK06TAKkjGByNWYFpBnKR1+S7wxSN6nDklIH9MqHkZW+xCBJ36TUfU8xPN1IBUvKo=
Received: by 10.54.33.50 with SMTP id g50mr1864310wrg;
        Sun, 11 Sep 2005 08:54:04 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id d8sm378173wra.2005.09.11.08.54.04;
        Sun, 11 Sep 2005 08:54:04 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Frank Sorenson <frank@tuxrocks.com>, webmaster@kernel.org
In-Reply-To: <4323E3C0.1090109@tuxrocks.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8298>

Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Something appears to be something odd going on with the git repos on
> kernel.org, including both the git and linux trees.  I believe that I've
> tracked down the problem to differences that occur between the repos
> located at the various IPs that kernel.org translates to (zeus-pub1:
> 204.152.191.5 and zeus-pub2: 204.152.191.37).
> 
> In this case, it appears that the repo located at zeus-pub1 has been
> updated, but the changes haven't propagated over to zeus-pub2 yet.  The
> result is that one call fetches a list of objects, but the next call
> goes to the other IP, and it can't find an object it needs, so it ends
> up dying.
> 
> This is probably a temporary error that will periodically (and probably
> very rarely) occur when pulling from a source with more than a single IP
> and some lag before the mirror is updated.
> 
> Is this an issue that we need to watch for and program around (other
> than forcing www.kernel.org's IP in /etc/hosts), or is it just one of
> those things that should be such a rare occurrance that we shouldn't
> have to worry about it?

 From a gitweb perspective, one of the servers appears to be about 24 
hours out of date as of Sun Sep 11 15:50:53 UTC 2005. Broken rsync process?
