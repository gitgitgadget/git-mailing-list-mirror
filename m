From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: autocrlf and git manual
Date: Wed, 11 Jun 2008 06:06:57 -0700 (PDT)
Message-ID: <m3d4moruhg.fsf@localhost.localdomain>
References: <1033a22d0806110453h16782758i7318ef4fce434ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John Yesberg" <john.yesberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 15:09:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Q3r-0008F5-ED
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 15:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbYFKNHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 09:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYFKNHA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 09:07:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbYFKNG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 09:06:59 -0400
Received: by ug-out-1314.google.com with SMTP id h2so99800ugf.16
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=o53VJNoqRVW5BMrRAOJ1TtpTo4oy7Udfc/Rw2cS5I7E=;
        b=s7/Anp/1ZCZasdXMCjwaRiYQFHz7PDylrXdAWMRP6472Wi3nOA0jj/NKJVqB8lipy4
         1zqfVEyu8vjCOZXmIvrRpRAi47J/dSUb2SBetEcqP0zxs0WM/KNIK/ZHZTRMB0s1TCQU
         U/xS+YD2CNR8mf1Qfeqm/PxA5af/yHDpDvKsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=KEwSQXH6kQwMjq5Zw0xFLJg12YWi+DP7rUN92brvwTTtBXFxnwODfD9oqsYiXbrZcj
         wf6oq9F2/AJYZHA+qHMli874FEr5tzePx54JEGQ69yoPnFYK9FLxTzh9tB1IoUAY5XQy
         By/4NBdW5cWozLioLvoTKDVKKr6HdnvRpFxdw=
Received: by 10.67.115.17 with SMTP id s17mr1144097ugm.56.1213189618160;
        Wed, 11 Jun 2008 06:06:58 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.225.81])
        by mx.google.com with ESMTPS id s7sm4120398uge.48.2008.06.11.06.06.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 06:06:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5BD6sal018660;
	Wed, 11 Jun 2008 15:06:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5BD6pjQ018657;
	Wed, 11 Jun 2008 15:06:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1033a22d0806110453h16782758i7318ef4fce434ba@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84607>

"John Yesberg" <john.yesberg@gmail.com> writes:

> I didn't see any contact details in the manual or on the web site. I'd
> be happy to contribute text if that helps: Is there a markup language?

Yes, all (almost all) documentation in git use AsciiDoc markup language.

> Who is the editor?

"Git User's Manual" is mainly creation of J. Bruce Fields (from what I
rememeber, and also from the number of commits).  So if you want to
add to that, it would be I think best simply to send patch (if
possible), Cc-ing him.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
