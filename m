From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: please show tags file history browsing
Date: Sat, 11 Sep 2010 10:40:00 -0700 (PDT)
Message-ID: <m3r5h0kwn5.fsf@localhost.localdomain>
References: <000001cb51be$ed214dd0$c763e970$@se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'git'" <git@vger.kernel.org>
To: "Tjernlund" <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:40:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuU3j-0002sD-L4
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab0IKRkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 13:40:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0IKRkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 13:40:04 -0400
Received: by bwz11 with SMTP id 11so3296591bwz.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xmCdGFrijhV0qJFNa3Tr74sSijRIcDNJshDLbSNgLsE=;
        b=k3rDvQvtFEV9vBFCpERuoG1tw3lJvk+3ThIz1JD3OzgU+Icxzim9QN3RKyUTL+BU/P
         bWJgSI/DP+Tjz143KWZZnHqIy6mRGqMpgyyicS+EmGbJADigQi6N1ZRdHCDmghVPn3CE
         LOsUxnDSSIkNhXtdXRdXszGHu/iFgTsdIVGM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=j69bcKb6OXVoJsSAX94IMwhGwq9xd8c6MV2xRw2Cs+x3qB6VpGvITFhWVPDfSxLy6B
         b/Gd+noQweiqNtSNq3nkq4Xf3su915ihl4Vu/O2phFmUL5NtXvVlY9GB+thVawAf9+Z3
         TzTdQeh725JyHAWp6wiyVcvzdDqKQZ7CxALjo=
Received: by 10.204.176.144 with SMTP id be16mr1675786bkb.53.1284226801594;
        Sat, 11 Sep 2010 10:40:01 -0700 (PDT)
Received: from localhost.localdomain (abvl188.neoplus.adsl.tpnet.pl [83.8.209.188])
        by mx.google.com with ESMTPS id f18sm3024264bkf.15.2010.09.11.10.39.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Sep 2010 10:40:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8BHdTDL004648;
	Sat, 11 Sep 2010 19:39:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8BHdAv6004641;
	Sat, 11 Sep 2010 19:39:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <000001cb51be$ed214dd0$c763e970$@se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156001>

"Tjernlund" <tjernlund@tjernlund.se> writes:

> I would really like to see where the tags are when browsing
> file or directory history in gitweb. Would that be possible?

Hmmm... that is second such request...

While it probably be possible to show tags in 'history' view, it would
be not easy.  The problem is that 'history' view shows only commits
that touch specified file or directory, and tagged commits usually do
not touch those files (at least if one is using "bump version number"
commits to tag them).

So you would have: 
1. Design where to show those tags - they would be between shown
   commits.
2. Create code which shows some/all tags that are between commits in
   the presence of nonlinear history, without affecting performance
   too badly.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
