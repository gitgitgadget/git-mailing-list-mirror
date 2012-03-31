From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Importing a subversion repository where some branches come from
 trunk subtrees
Date: Sat, 31 Mar 2012 11:07:37 +0100
Message-ID: <4F76D769.7040301@pileofstuff.org>
References: <CABaB1pJNs1FL6=CbJ97pq7O=jKK=G_4t-vsx-2c4vHXsuzr40g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "frnchfrgg.jr" <frnchfrgg.jr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 12:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDvEJ-0003Xm-Oo
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 12:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab2CaKHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 06:07:44 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:22524 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755578Ab2CaKHn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 06:07:43 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120331100740.MMAG9621.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 31 Mar 2012 11:07:40 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120331100740.ZQCS13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 31 Mar 2012 11:07:40 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CABaB1pJNs1FL6=CbJ97pq7O=jKK=G_4t-vsx-2c4vHXsuzr40g@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=nPi-Q3pzXAIA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8 a=kD2G1YbbSvJCIuL9lykA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194445>

I'm not an expert on git-svn internals, but I believe sub-project
branches are a limitation of its branching implementation.  svn-fe
doesn't have this problem at the downloading stage (and will do 20,000
revisions much quicker than git-svn), but requires you to split branches
out by hand.

I'm currently trying to document these strange edge cases as part of an
ongoing effort to add branch information on top of svn-fe's output.
Would you mind taking a look at [1] and letting me know if it's an
understandable description of your problem?  Improvements and other edge
cases are very much welcome, and I hope to have something in the coming
months that tackles these issues.

	- Andrew

[1]https://github.com/andrew-sayers/SVN-Branching-Language/blob/master/t/advanced/subproject_branch.sh
