From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: RFC: reflog for deleted branches
Date: Thu, 03 May 2012 23:13:16 +0100
Message-ID: <4FA302FC.2040608@pileofstuff.org>
References: <4FA2F7DA.6020108@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri May 04 00:13:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ4H9-0004Ku-IE
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 00:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab2ECWNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 18:13:22 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:32086 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755943Ab2ECWNV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 18:13:21 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120503221318.QPDV28930.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Thu, 3 May 2012 23:13:18 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120503221318.OJGD3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Thu, 3 May 2012 23:13:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <4FA2F7DA.6020108@tu-clausthal.de>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=H9LAzG50idoA:10 a=u4BGzq-dJbcA:10 a=Q9fys5e9bTEA:10 a=TSbVqHtbAAAA:8 a=wst6j1OKC65MxSsbgBoA:9 a=PUjeQqilurYA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196967>

On 03/05/12 22:25, Sven Strickroth wrote:
> Hi,
> 
> an often heart question is how to restore deleted branches. Sometimes
> those can be restored by using the reflog of the HEAD.
> 
> But why not create a special (ref)log for deleted branches (with SHA1,
> date, name of the branch and maybe commit message of the last commit on
> the deleted branch)? This way people could just look up the SHA1 of the
> deleted branch and can recreate it (even if they moved the HEAD around a
> lot).
> 

Something like this may well be needed by an SVN importer, as it's quite
possible for an SVN branch to be deleted, then another branch forked
from it years later.  See the (brief) discussion here:

http://article.gmane.org/gmane.comp.version-control.git/195517
http://article.gmane.org/gmane.comp.version-control.git/195544

This is really Florian's area, but I expect it would be easy enough for
SVN import to build on top of any reasonably general solution if you're
offering :)

	- Andrew
