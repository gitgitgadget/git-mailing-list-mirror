From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [git-svn PATCH] Add --no-rebase option to git-svn dcommit
Date: Thu, 03 May 2007 08:53:30 -0700
Message-ID: <m24pmtaop1.fsf@ziti.local>
References: <20070503054749.20115.53805.stgit@yoghurt>
	<87647aqu6i.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 17:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjdci-0004Xu-Cq
	for gcvg-git@gmane.org; Thu, 03 May 2007 17:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162139AbXECPxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 11:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162140AbXECPxg
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 11:53:36 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:20647 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162139AbXECPxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 11:53:34 -0400
Received: by nz-out-0506.google.com with SMTP id o1so555265nzf
        for <git@vger.kernel.org>; Thu, 03 May 2007 08:53:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=AEnRlIGtFk26K8xIpO13rPMjQEjXjhx77XKr6LjmG8IojbrIMK+ngtQrhr28tnLXyBXvQ2oT4hHUJV8W5bT0cL1i20LGyn2Z8nLJ7Awz2xP5ERSWJJhR/66DoCZwSbPVaBwoMJ5in0xrsH4WCssvjNsSL+uPza3xuWz9p5nGAso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=Cbb7f/9KwG/LWvobAWJ0YaVQkKMVBJT11Sp/rGBYrO71niqYhUCIL30fx+htfAPpOTFh9ZF3TmtQZ5xpWoo4yola0uaL/p32+uuPkcNekAKYkiXEKm0VW6dO/R+bg86SiQcP+Y6PBOOQ9gi0byUbFrT6vk20b2B18GWScmhJmWE=
Received: by 10.114.95.1 with SMTP id s1mr716651wab.1178207613769;
        Thu, 03 May 2007 08:53:33 -0700 (PDT)
Received: from ziti.local ( [140.107.156.111])
        by mx.google.com with ESMTP id q20sm6467512pog.2007.05.03.08.53.32;
        Thu, 03 May 2007 08:53:32 -0700 (PDT)
In-Reply-To: <87647aqu6i.fsf@morpheus.local> (David =?iso-8859-1?Q?K=E5ged?=
 =?iso-8859-1?Q?al's?= message of "Thu, 03 May 2007 08:48:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46090>

David K=E5gedal <davidk@lysator.liu.se> writes:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
>> git-svn dcommit exports commits to Subversion, then imports them bac=
k
>> to git again, and last but not least rebases or resets HEAD to the
>> last of the new commits. I guess this rebasing is convenient when
>> using just git, but when the commits to be exported are managed by
>> StGIT, it's really annoying. So add an option to disable this
>> behavior. And document it, too!
>>
>> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
>> ---
>>
>> Arguably, the switch should be --rebase instead, and default to not
>> rebase. But that would change the existing behavior, and possibly ma=
ke
>> dcommit less convenient to use for at least the person who implement=
ed
>> the existing behavior. Opinions?
>
> I don't agree.  The rebase behaviour makes perfect sense in the norma=
l
> case, and I've been using it without problems.  The special case is
> when you start using stgit, so that's when you need to tell dcommit t=
o
> do something out of the ordinary.

I'm happy with git-svn dcommit's current behavior.  Since it is
git-svn and not git-stGIT, I'm not in favor of changing a default to
make a stGIT use case more convenient.

+ seth
