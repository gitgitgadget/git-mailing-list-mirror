From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More 'shortlog' statistics models?
Date: Wed, 15 Jul 2009 06:38:35 -0700 (PDT)
Message-ID: <m363duukvb.fsf@localhost.localdomain>
References: <alpine.LFD.2.01.0907141852400.13838@localhost.localdomain>
	<7v8wiqfj60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Sverre Rabbelier <alturin@gmail.com> Git Mailing List" 
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 15:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR4h5-0005ab-NR
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 15:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbZGONii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 09:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbZGONii
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 09:38:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:54905 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbZGONih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 09:38:37 -0400
Received: by fg-out-1718.google.com with SMTP id e12so871250fga.17
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=8gSjgvroQhSjFMAJ0+f/12Ezz3U3brwERXqPvxsOB6k=;
        b=bIyOt+vEZ5o7ijUp3mCog6xKwcO+D5VpDGkugzDCoK5VTAsNA0hA9Jzyx9DvFPB0AJ
         lvXscPIh+qlcHzqWeZDOJ9L8Hno9EySyNCmV8R7xTsqjLnv3DJoEHHLsA1yq560IUSvd
         /fv1LlSfP54oo380a/b8rXWBOsRMDoCcTcrN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Zp7MasEScBllUvVUT6f9I3plC0V5AEu5GOQItK8+GLUtUbT380kvV1Vr0w9ZeB2Am9
         FdZZF002o0O5YUVhGTUkczw68oDKHANpzvYYRjsrgVLChkOqRKgpWkREgdrHA9bkV74j
         yf0ZlHqLnIHGwNdm3ZXWvS8vlfWTrn11kXsbI=
Received: by 10.86.97.17 with SMTP id u17mr5081701fgb.55.1247665116395;
        Wed, 15 Jul 2009 06:38:36 -0700 (PDT)
Received: from localhost.localdomain (abuz24.neoplus.adsl.tpnet.pl [83.8.197.24])
        by mx.google.com with ESMTPS id d4sm802997fga.18.2009.07.15.06.38.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 06:38:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6FDcYBL004899;
	Wed, 15 Jul 2009 15:38:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6FDcXXf004895;
	Wed, 15 Jul 2009 15:38:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8wiqfj60.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123307>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Anyway, I can do all this with sorting, but it's fun enough that I wonder 
> > if we should make it easier?
> 
> Wasn't one of the GSoC project about git statistics?  Or was it a topic of
> last year?

It was topic of last year GSoC, see http://git.or.cz/gitwiki/SoC2008Projects
It was decided[1] that it would be better for it to remain separate
from git (for support for other SCMs).

  http://repo.or.cz/w/git-stats.git

CC-ed Sverre Rabellier (student for this git-statistic project)

[1]: http://permalink.gmane.org/gmane.comp.version-control.git/90691
-- 
Jakub Narebski
Poland
ShadeHawk on #git
