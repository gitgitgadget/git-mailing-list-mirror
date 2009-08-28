From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Merging in Subversion 1.5 (was: Re: Using git to track my PhD
 thesis, couple of questions)
Date: Fri, 28 Aug 2009 17:44:04 +0200
Message-ID: <op.uzdpzqr11e62zd@balu.cs.uni-paderborn.de>
References: <4A979690.1050601@gnu.org> <vpqk50pasek.fsf@bauges.imag.fr>
 <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>
 <7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
 <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul>
 <vpqpragt5bo.fsf@bauges.imag.fr> <4A97E1B1.7090107@gmx.de>
 <m3ocq0km5m.fsf_-_@localhost.localdomain>
 <32541b130908280829s6fcebbe5ja84b10e649de1eb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Matthieu Moy" <Matthieu.Moy@imag.fr>
To: "Avery Pennarun" <apenwarr@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh3ch-0007Kt-6T
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 17:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbZH1PoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 11:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbZH1PoG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 11:44:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:53347 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750761AbZH1PoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 11:44:04 -0400
Received: (qmail invoked by alias); 28 Aug 2009 15:44:05 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp062) with SMTP; 28 Aug 2009 17:44:05 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+wDTRaqHuwMV4NSuAZhW9DnRWGJ2DX0+ogdOVVh+
	FUzFoclte3XYsb
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KP3FPG-0004H0-JA; Fri, 28 Aug 2009 17:44:04 +0200
In-Reply-To: <32541b130908280829s6fcebbe5ja84b10e649de1eb3@mail.gmail.com>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127305>

Am 28.08.2009, 17:29 Uhr, schrieb Avery Pennarun <apenwarr@gmail.com>:

> I think they probably meant that it's the client's responsibility to
> set the property correctly, not the server's, and if your client is
> too old any you do a merge, it'll forget to set svn:mergeinfo, causing
> confusion for everyone.  There's discussion in the svn book
> (http://svnbook.red-bean.com/en/1.5/svn.branchmerge.advanced.html) but
> nothing implies that it's a non-replicated property.  Indeed, I can
> see no particular reason that anyone would want it to be, for the
> reasons you specify.

It is replicated, and the common remedy against older clients is to refuse  
commits from those clients that do not support mergeinfo. This is done by  
defining a repository hook on the server side that validates this. AFAIR  
such a hook example ships with SVN.

-- 
Matthias Andree
