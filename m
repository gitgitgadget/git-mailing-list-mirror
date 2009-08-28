From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 15:54:57 +0200
Message-ID: <4A97E1B1.7090107@gmx.de>
References: <4A979690.1050601@gnu.org> <20090827203402.GC7168@kisimul>	<vpqk50pasek.fsf@bauges.imag.fr> <20090827203402.GC7168@kisimul>	<9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>	<20090827203402.GC7168@kisimul>	<7v1vmxq6nw.fsf@alter.siamese.dyndns.org>	<20090827203402.GC7168@kisimul>	<fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>	<20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul> <vpqpragt5bo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 15:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh1v2-0005o5-JR
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 15:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbZH1Ny7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 09:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZH1Ny6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 09:54:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:44313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751261AbZH1Ny6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 09:54:58 -0400
Received: (qmail invoked by alias); 28 Aug 2009 13:54:59 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp050) with SMTP; 28 Aug 2009 15:54:59 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+NzhxObi+NojEOYCF4oBKgnO2Hp/3xhOoUmVXvQO
	wIDPbX46kQkycX
Received: from localhost ([127.0.0.1])
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KP3ANL-0001W8-QU
	for git@vger.kernel.org; Fri, 28 Aug 2009 15:54:58 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <vpqpragt5bo.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127298>

Matthieu Moy schrieb:
> seanh <seanh.nospam@gmail.com> writes:
> 
>> In response to Matthieu and Paolo, I'm not sure I understand the git 
>> internals involved in the discussion around merge --squash, I had a 
>> feeling this would produce a 'merge' that git in some sense would 'not 
>> know about',
> 
> Yes, that's it. Git does a merge, and immediately forgets it was a
> merge. The consequence is when you merge again later, Git will not be
> able to use the merge information to be clever about merging. Somehow,
> Git will be as bad as SVN for merging if you don't know what you're
> doing ;-).

To be fair, SVN versions 1.5 and newer can track merges. If the repository
predates 1.5, it has to be updated on the server side (see the release notes for
details). It just tracks which revisions have been merged and which not, for
further details, see the svn book. (http://svnbook.red-bean.com/ IIRC)
