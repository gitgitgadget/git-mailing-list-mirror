From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 21:42:14 +0100
Message-ID: <CAHGBnuOZF+poa1OpgmayqAkwAuZWMESPQJPVqNjWwkS1i3t-OA@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
	<CAPig+cRpEvAjiQWZ08kW2oqwR6XZ=u7dE=3OfVyB9SZzf8+saw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 21:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbG7I-0007jr-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 21:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab3J2UmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 16:42:17 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35027 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab3J2UmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 16:42:16 -0400
Received: by mail-lb0-f182.google.com with SMTP id w6so504705lbh.13
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4lSYvmW0opp5V0sB8zoHifHo3nrtXuQUhaEr5RQzIIQ=;
        b=bqDjZuwz8Yb2s6QF3MfQjqJzqsIBmXV40ycKkGvCB5H78d/K8ElnHV/AJHD3m2JNOL
         w+5pxo1Ixitf/G8S9d1btbBVnIfVtl7HMg5J2JMakrQzaQDe14xJJ6eovsX17C5QTjKb
         bTtE8YKV4hUGCyLb0StX3kNCgy/KUkttwzziL9oVDYt4envkuqvsi9LuLYKoKA3jWpQD
         8VpVgQUso3OayDlwQfDPYAmg4/yKv0vG5n/BbBzqoWa49Ipb+tebUU7TcmlE/paogHi5
         dxDxrHN8FgW4G5qr6q/NAt8vpCuhvj9y4NJiGZKcFow69mXCB+0j08NWefw+UpElMZiL
         RCdg==
X-Received: by 10.152.36.170 with SMTP id r10mr824872laj.48.1383079334712;
 Tue, 29 Oct 2013 13:42:14 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 29 Oct 2013 13:42:14 -0700 (PDT)
In-Reply-To: <CAPig+cRpEvAjiQWZ08kW2oqwR6XZ=u7dE=3OfVyB9SZzf8+saw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236949>

On Tue, Oct 29, 2013 at 8:02 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:

>>> $ git contacts b0783baacd20be7007df40cf274985c4863d63fb
>>> fatal: More than one '-L n,m' option given
>>> fatal: More than one '-L n,m' option given
>>> fatal: More than one '-L n,m' option given
>>> fatal: More than one '-L n,m' option given
>>>
>>> From reading git-blame's man page it indeed seems to me as if only one
>>> -L option is allowed, so is this something that needs to be fixed in
>>> git-contacts?
>>
>> You are probably using a newer version of the script on an older version of Git.
>
> Right. git-blame learned to accept multiple -L's in 58dbfa2e59a1, and
> git-contacts started taking advantage of that feature in 4c70cfbfbc2d.
> A git-contacts prior to 4c70cfbfbc2d might work for you.

Ah, and 58dbfa2e59a1 is not in any release yet. Thanks.

-- 
Sebastian Schuberth
