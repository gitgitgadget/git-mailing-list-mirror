From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Questions concerning SCM Life Cycle Management and GIT.
Date: Fri, 10 Sep 2010 07:47:51 -0700 (PDT)
Message-ID: <m3d3slmza0.fsf@localhost.localdomain>
References: <9F0BA72CD5252845A09DBB8FEC3A1633756133@naeanrfkez06v.nadsusea.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Butler, Anna R CIV NSWCDD, W34" <anna.butler@navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 10 16:52:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou4xV-0006gD-DH
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 16:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab0IJOwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 10:52:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62059 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab0IJOwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 10:52:00 -0400
Received: by bwz11 with SMTP id 11so2271741bwz.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=d0Z/TofXyNYNsGHT3sq+BO1HHGhyS+Ub/+Ff7Y0tlpM=;
        b=IZtkIL4K6lzYwZBcwXL5JT1LOkdoLIAVH3Rx5DufhhOcJvn2lkJGyJasVIj7sg9aW1
         dqb5dBq6FLv8cl8vUbUerjblqFcNNx2ZX5s29BaxSkKeDnZo0Ttt9kV+J98uu5yYciY/
         6aruPAnXRngBhK++J8HmdqVUpyTSJ/6SaYpJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SsrH3DKxRNpFSfs8jWhOQgZbNQ0EQ8MFHj+9Af+16r2joGjewS98pFHDe3yFvAP9Kd
         S+vwzpcV56dxPRZATU6ScCowfRE/kyALWl7o31+dxOFMoVpnWE/HXPXYeiYQzEshDqHr
         IvaE1Aw/YBd41u5xF6AJ8tXdi8wkmntI2VzOs=
Received: by 10.204.81.130 with SMTP id x2mr470717bkk.210.1284130072715;
        Fri, 10 Sep 2010 07:47:52 -0700 (PDT)
Received: from localhost.localdomain (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id g12sm2055044bkb.2.2010.09.10.07.47.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 07:47:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8AElJCv017116;
	Fri, 10 Sep 2010 16:47:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8AEl48Z017112;
	Fri, 10 Sep 2010 16:47:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9F0BA72CD5252845A09DBB8FEC3A1633756133@naeanrfkez06v.nadsusea.nads.navy.mil>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155932>

"Butler, Anna R CIV NSWCDD, W34" <anna.butler@navy.mil> writes:

> Hello,
> 
> We are looking for Software Configuration Life Cycle Management
> Tools.  It looks to me that GIT supports Version Control only.  Is
> this true or did I miss something?

Git is distributed version control system only (following UNIX
philosophy "Write programs that *do one thing* and *do it well*").

> Does GIT track software defects? If so can you link elements in the
> software version repository to a defect?
>
> Does GIT track Requirements?  If so can you link elements in the
> software version repository to a requirement?  Can GIT link test
> cases to both a defect and elements in the software version
> repository?
> 
> I appreciate you attention to these questions.  Looking forward to
> hearing form you.

If you want/need *integrated solution* covering whole Software
Configuration Life Cycle Management, there are tools that come
to my mind:

1. Gerrit[1], a web-based collaborative code review tool for Git,
   which uses Git for version control.  It is used by Google for
   development of Android platform.  Open source (Apache license).

2. Kiln[2], from Fog Creek, with integrated code review and FogBugz 
   integration (a web-based project management tool), which uses
   Mercurial (other DVCS) for version control.  IIRC proprietary.

3. There is Launchpad[3], which uses Bazaar for version control.
   Used by Ubuntu.  Open source (AGPLv3).


GitHub offers paid plans, and also hosted GitHub:FI; it includes
issue tracker and a kind of code review.  Similar opensource solution
include Gitorious and InDefero.

HTH

[1] http://code.google.com/p/gerrit/
[2] http://www.fogcreek.com/kiln/
[3] https://launchpad.net/
-- 
Jakub Narebski
Poland
ShadeHawk on #git
