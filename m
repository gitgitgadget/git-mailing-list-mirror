From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 14:25:15 -0700 (PDT)
Message-ID: <m3k4rsd1x2.fsf@localhost.localdomain>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern>
	<4BD6ACEF.1040909@op5.se>
	<alpine.LFD.2.00.1004272111540.5630@bbs.intern>
	<4BD73F64.1070604@op5.se>
	<alpine.LFD.2.00.1004272152190.11216@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 23:25:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6sHc-0000YO-Jm
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 23:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108Ab0D0VZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 17:25:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:38664 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab0D0VZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 17:25:17 -0400
Received: by fg-out-1718.google.com with SMTP id d23so3384478fga.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=RCCSiD3d+OiyMex4In70NQZzzilbfQVT8vOS9tfcFwg=;
        b=f9Zc25rbyxU6mD4UhetE9/Alo4GhwBNDcP7nBcYXSg4oIjzu+VaDDtfjjykgoyLlKv
         7FxDTK0rX8oGLn6prrKBdvl7Cytvr9A3CoZxdMzbaQbLUSgivceHAseWdIju5UZm86Kh
         4uwkPsZdPgzMjD15/Mt/5/fQicF8VPPIp823k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LSJJzQzkDsCkr1czSaJd4axCz3vmm8nBdOjmIEd/8ADJGURa7IW7qFOmtJ0eqZMSFO
         9Ws2dArF/Z0CEuPRPhI5RY0hwo0FmMd98OqfieRw1fM5iZiVKwTznxAu+42R0axNZVwR
         jr+M5PHHdkCS4RdtbLof3pXjzVfuL9pipACt4=
Received: by 10.87.15.35 with SMTP id s35mr6164357fgi.12.1272403515917;
        Tue, 27 Apr 2010 14:25:15 -0700 (PDT)
Received: from localhost.localdomain (abvy105.neoplus.adsl.tpnet.pl [83.8.222.105])
        by mx.google.com with ESMTPS id 19sm3985028fkr.9.2010.04.27.14.25.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 14:25:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3RLOg6X032247;
	Tue, 27 Apr 2010 23:24:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3RLOQZk032237;
	Tue, 27 Apr 2010 23:24:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.1004272152190.11216@bbs.intern>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145958>

Gerhard Wiesinger <lists@wiesinger.com> writes:
> On Tue, 27 Apr 2010, Andreas Ericsson wrote:
>> On 04/27/2010 09:38 PM, Gerhard Wiesinger wrote:
>>> On Tue, 27 Apr 2010, Andreas Ericsson wrote:
>>>> On 04/27/2010 07:23 AM, Gerhard Wiesinger wrote:

>>>>> b.) rights (basic: chmod, chow, chgrp, extended: extended attributes
>>>>> like ACLs and selinux), necessary for versioning e.g. /etc
>>>>
>>>> Sounds like you want a backup-program. Some projects have been
>>>> aimed towards this goal already. [...]. AFAIR, most of them work
>>>> with two hook-scripts that update a regular file with the
>>>> meta-data of all tracked files. [...]
>>>>
>>>> Adding it to core git would mean re-designing git's basic data
>>>> model, which is obviously not something we're about to do on
>>>> a whim.
>>>
>>> No, I'm NOT looking for a backup program. Every admin has the problem of
>>> versioning config files (for example /etc). Versioning of config files
>>> makes sense because one can track the changes and e.g. correlate to
>>> problems. A backup program doesn't have features like history, committer
>>> and comments on file changes. Therefore git would be a perfect tool also
>>> for versioning configuration. (Software development doesn't end with the
>>> build but typically also has deployment&configuration issues).

See IsiSetup, etckeeper and other such tools.

[...]
>> In short: What you want can be (and has been) done, but it's written
>> as addons and not integral parts of git.
> 
> A first quick look on them: They are only a workaround to the real
> problem. For example subversion therefore has generic properties which
> also can be user defined (e.g. svn propset/propget) and I think such a
> concept should also be integrated part of git.
> 
> Only my 2 cents making git (one of the SCM where I think it is very
> powerful and has also potential in the future) even better than
> competition.

Actually using *properties* is one of MIS-designs of Subversion.
Storing generic sh*t in repository is not a good idea either.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
