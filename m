From: Ferry Huberts <mailings@hupie.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on
 Windows
Date: Tue, 23 Nov 2010 22:49:39 +0100
Message-ID: <4CEC36F3.5020908@hupie.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 22:49:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL0kH-0003nI-SI
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 22:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab0KWVto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 16:49:44 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:47817 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750798Ab0KWVtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 16:49:43 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.40.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id CF05658C993;
	Tue, 23 Nov 2010 22:49:39 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Thunderbird/3.1.6
In-Reply-To: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162030>

Are your users using the 'show my status in the prompt' feature?
If so, then disable all but showing the current branch, it makes a whole
lot of difference :-)

On 11/23/2010 08:08 PM, Dun Peal wrote:
> Hey,
> 
> We have a bunch of Windows users, unfortunately, and they're using the
> latest msysGit release (Git-1.7.3.1-preview20101002).
> 
> An interesting issue we've noticed is that the Time To Complete of
> their common operations start deteriorating inexplicably, and
> severely, some time after the clone.
> 
> For instance, immediately after a clone, `git status` takes about
> 5-6s. Which is slow compared to Linux (consistent 1-2s), but still
> usable (it's a BIG repo).
> 
> However, after a reboot (of all things), `git status` latency
> skyrockets to 14-15s, making the repo unusable.
> 
> Any idea what's going on?  We just recently switched from SVN, and
> those users are getting really frustrated. BTW, the only real
> alternative I'm aware of, Cygwin's git, is even slower.
> 
> Thanks, D
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

grtz

-- 
Ferry Huberts
