From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: git weird pulling issue
Date: Thu, 3 Jan 2008 15:11:14 +0300
Message-ID: <20080103121114.GE8046@cvg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 13:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAOvm-00029g-KR
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 13:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYACML0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 07:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbYACML0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 07:11:26 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:25514 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYACMLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 07:11:25 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6630029fkz.5
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 04:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=sxN6k1x5v9dvB84TbZq9tGAcDBA/CvWcuTehBdacQr0=;
        b=uL1DGLAYlho/K2lQA8XPKkaAmPpxMMG9/YYy3GN3yHpoXEZXRbuYCWKcwO5auSqCeTiHHSoaqK4soI8lp7pzDmHInWyS2LSmAOWMRT9ix8d5vmrVRNOaFeZU6Ud/5rafYX1ZpueoZGDrIizW63inLE0xn/G2GYbUAL1dwDsUj28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=jFUEWqk82oETEj0kBS8dzDlAv/LApvamI5487RAf+SjYBXwUpOBoRkRcxZBzLb5Ce64fC/Irhdq8JV5Y6MijHkpdsnCrrPdwiWF6dmR8yXg3KG5cXjA+tGHp8AYHIKpompxqtbaknrXwo8yTIHcan86Q/zuUlVtleNspnaFjDys=
Received: by 10.82.116.15 with SMTP id o15mr14575818buc.3.1199362282980;
        Thu, 03 Jan 2008 04:11:22 -0800 (PST)
Received: from gorcunov ( [91.122.85.165])
        by mx.google.com with ESMTPS id z40sm23961334ikz.4.2008.01.03.04.11.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2008 04:11:22 -0800 (PST)
Received: by gorcunov (Postfix, from userid 1000)
	id 515997B1D; Thu,  3 Jan 2008 15:11:14 +0300 (MSK)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69524>

Hi git-list,

i've a weird problem with pulling remote tree. look i've linus's tree
as a base repo. then i've created x86 branch to which i pulled
ingo's x86 tree. So all further pulling is made over this branch.
And even having '--force' option at moment of pulling changes from
Ingo's tree i've got something like that:

---
cyrill@cvg linux-2.6-x86.git $ ./git-update.sh 
Updating "x86"
remote: Generating pack...
remote: Done counting 15 objects.
Result has 9 objects.
remote: Deltifying 9 objects...
remote: /9) done/9) done
remote: Total 9 (delta 7), reused 3 (delta 1)
Unpacking 9 objects...
 100% (9/9) done
Auto-merged include/asm-x86/msr.h
CONFLICT (content): Merge conflict in include/asm-x86/msr.h
Auto-merged include/linux/ptrace.h
Auto-merged kernel/ptrace.c
Automatic merge failed; fix conflicts and then commit the result.
---

I would really appreciate if someone helps me to resolve this
problem. If you need an additional info - just mail me.

Please Cc me 'case i'm not subscribed to the list.

Thanks in advance,

		- Cyrill -
