From: g2 <gerald.gutierrez@gmail.com>
Subject: Re: How to jump between two repositories ...
Date: Wed, 5 Dec 2007 07:28:02 -0800
Message-ID: <9F403ACE-62C0-4A6D-945C-3DA6DF0316B8@gmail.com>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com> <20071205061425.GE11098@fieldses.org> <47566526.9010900@op5.se>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Dec 05 16:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzwBF-0003hC-Hf
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 16:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbXLEP2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 10:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXLEP2f
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 10:28:35 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:19543 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbXLEP2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 10:28:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3663836rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 07:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=8lOOO+41XJWyti8CD6Uu2OPVpwM58za8B8oyQhz+UnE=;
        b=fwwfKqiFJShf+T0IkGit7CZbWDnn6q++/rCca/smXYAq9xndr56rG2W2pYG5Mg8nKc/gS6bNJ4iGMtsR+3rSvefMIk4VMrundz+0t17/WgJRMSbc4OwECkeERKORjy9oIbzqsp6F0AD1ezfzp2SRJdb0qKCFe10dPtHEqrxpJhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=I9D+fuQ3NGHmpNKBsUPZQP/Cfh0GmnOSIDxukcQHUoErOebQqsUT2InmI2c+29VYr9NnnJCNfeH2mZMhaokJuGtXFaWbSqD3XcR+msDbMcIprsak2yIjWyU7jXBhEiMppjL8Rw+AAgGLVBXA2Xlcluhx4DByVa6n64XLCSMxmmw=
Received: by 10.140.174.18 with SMTP id w18mr1233774rve.1196868512807;
        Wed, 05 Dec 2007 07:28:32 -0800 (PST)
Received: from ?192.168.0.200? ( [70.79.106.215])
        by mx.google.com with ESMTPS id f28sm108930rvb.2007.12.05.07.28.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 07:28:31 -0800 (PST)
In-Reply-To: <47566526.9010900@op5.se>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67159>


How do you safely push to the repository? Even if my receiving  
repository is pristine (the last command I do is a commit), after I  
push into it, some files in the work-tree are effectively out of date  
and git says so by thinking they are modified and staged for commit.  
My original set of example commands illustrates this. What set of  
commands do you use to avoid the problem?


On 5-Dec-07, at 12:45 AM, Andreas Ericsson wrote:
>
> Yes it does. It just supports it badly. If there is a work-tree  
> connected to
> the receiving repository and that work-tree is pristine, it would be  
> safe and
> sane to write the newly pushed changes to the connected working tree.
>
> We do all our integration fixups by pushing to repositories with  
> work-trees,
> simply because it's ridiculously inconvenient to add the  
> infrastructure to
> pull to those repos from each individual developer. In that  
> scenario, pushing
> to a checked out branch is highly useful and perfectly safe.
>
> -- 
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
