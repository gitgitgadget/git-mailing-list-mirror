From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 21:13:40 +0200
Message-ID: <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 21:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGgDq-0002ik-Is
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 21:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbXHBTUb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757190AbXHBTUb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 15:20:31 -0400
Received: from mailer.zib.de ([130.73.108.11]:38153 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755704AbXHBTUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 15:20:30 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l72JCm2O022548;
	Thu, 2 Aug 2007 21:12:49 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l72JCmxK018276
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 2 Aug 2007 21:12:48 +0200 (MEST)
In-Reply-To: <46B215E2.8010307@fs.ei.tum.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54587>

Simon,

On Aug 2, 2007, at 7:35 PM, Simon 'corecode' Schubert wrote:

> Steffen Prohaska wrote:
>>   fromcvs's togit surrendered during the import.
>>   fromcvs's tohg accepted more of the history, but finally
>>     surrendered as well.
>
> Which repo is it you are converting?  Is this available somewhere?

Unfortunately not, the content is a proprietary software package.


> I'd appreciate any reports concerning "surrenders" of fromcvs.   
> Additionally, it seems strange that tohg should have worked  
> "better" than togit, as these are basically just different backends.

Some time passed since I did the tests. I had no time to do a
detailed investigation then. I'll have more time now and will
prepare a bug report, which is not easy because I can't sent you
the cvs repo, sorry. Any hints what would be most helpful for you?

I remember that togit reported a broken pipe. My feeling was
that git-fastimport aborted, which may be reason why tohg
worked better. I didn't try to understand more details. I never
read ruby code before and it was already a challenge for me to
get everything up and running (rcs, rbtree).

	Steffen
