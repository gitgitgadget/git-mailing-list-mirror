From: Jakub Narebski <jnareb@gmail.com>
Subject: Strange message during fetch "remote: /2) done/2) done"
Date: Fri, 23 Feb 2007 18:14:07 +0100
Message-ID: <200702231814.07598.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 18:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKdxu-0007EU-5y
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 18:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946016AbXBWRMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 12:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946017AbXBWRMJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 12:12:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47521 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946016AbXBWRMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 12:12:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so420488uga
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 09:12:06 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qsCYa4CeFMaSivKWyOjDxEVfnu5ntuA0xXKaTa80aAE0vDZC3LZfwQFHiYtqHR4CSJO3HV44u3uMnJEuFRCDUlWOuujUrT9xTN1PDpmEjXD1Wpj5c2jRFxvcpxhjJDcOQL30gRyz2m3iKnnrqDbI8Yz55HlDuzEKYNFwVt36tw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e62sp1nZLZsIlbC22wWvVUS1jD7vnWi2ArbWZqH3PuEU6VQkyzfYxZ2ERVSaHeD18ksNNpdBVZ5UboGH4nzXKd197TzKGSM+OStjPL5WohYh0f/5f2dMobUK3y0EsXQVfzEamvGMtToI/NQTXhHl7byCz+kZoRJftIS1UOzgjtY=
Received: by 10.67.26.7 with SMTP id d7mr2558190ugj.1172250726384;
        Fri, 23 Feb 2007 09:12:06 -0800 (PST)
Received: from host-81-190-30-32.torun.mm.pl ( [81.190.30.32])
        by mx.google.com with ESMTP id b35sm2217365ugd.2007.02.23.09.12.05;
        Fri, 23 Feb 2007 09:12:05 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40451>

I got the following strange message during "git fetch origin":

 Auto-following refs/tags/gitgui-0.6.0
 Auto-following refs/tags/gitgui-0.6.1
 remote: Generating pack...
 remote: Done counting 2 objects.
 remote: Deltifying 2 objects.
 remote: /2) done/2) done
 Unpacking 2 objects

Notice next to last line, with "/2) done/2) done". Origin remote
is git://git.kernel.org/pub/scm/git/git.git, and I'm using git 1.5.0

-- 
Jakub Narebski
Poland
