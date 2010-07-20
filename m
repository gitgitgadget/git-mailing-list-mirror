From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Can I enforce required approval on some files
Date: Tue, 20 Jul 2010 15:03:24 -0700 (PDT)
Message-ID: <m36309n75a.fsf@localhost.localdomain>
References: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dominik Gront <dgront@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 00:03:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObKuT-0003ub-OL
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761787Ab0GTWD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 18:03:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65325 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761677Ab0GTWD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 18:03:26 -0400
Received: by fxm14 with SMTP id 14so3176792fxm.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=CfYal8nKp6aRdTzFbvqUBkeM2IpnGJVDZsc3aGwGP70=;
        b=FeE+X3yVB0k5OVssabfm6FhgSMnKdVxgKFxtCOytsRm/rGytpreeHlNm96gFA8u0MT
         K7/UvZyauePtE9H9SBrbWRX7ef+lDQVi+79Uij4WaZRnGgGE07lVAVDwZ+NVy+OGCPNg
         QseSj0biNjWGm2B/7TyJZOHEE/nm5dfnkKioE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ecbR9S1UE3smvxIV1jeqot52ULNyPUkFE7LcmTqUqJeQb2l3F4j3jCWzUYMZwW2axR
         K4fSet3vWiHEsInp9JZE8e3xGJV7e0QwqZBocY20RrNviETdY3ZJnid1aey5GwBss6+L
         xd7jyewagRUhYmInyNMIqWVfjkFvh3LHWWdwo=
Received: by 10.223.114.75 with SMTP id d11mr5982246faq.44.1279663405467;
        Tue, 20 Jul 2010 15:03:25 -0700 (PDT)
Received: from localhost.localdomain (abwd240.neoplus.adsl.tpnet.pl [83.8.227.240])
        by mx.google.com with ESMTPS id y2sm2615270fau.12.2010.07.20.15.03.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 15:03:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6KM34gU027300;
	Wed, 21 Jul 2010 00:03:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6KM2wbJ027296;
	Wed, 21 Jul 2010 00:02:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151370>

Dominik Gront <dgront@gmail.com> writes:

> I have been a happy SVN user for quite a long time, but now I miss
> some functionality in Subversion. I wonder if it could be done in git.
> If so, I convert to git right away :-)
> 
> There are some files in our repository that all their modification
> need to be approved by a project leader.  In general the desired
> behavior would be (examples given in svn commands) :
> - user runs "svn ci"
> - some files have status "pending" or "waiting for approval"
> - anyone can do "svn up", modifications to the pending files are not
>   retrieved, project leader can get the modified versions
> - project leader accepts the changes
> - anyone running "svn ci" sees all the modifications

Besides solution mentioned by others, namely integration repository
with moderator, you can also use patch/commit code review tool such as
Gerrit (http://code.google.com/p/gerrit/), equivalent of Rietveld for
Subversion, or Mondrian for Perforce.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
