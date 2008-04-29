From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 22:44:17 +0200
Message-ID: <20080429204417.GC6301@steel.home>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:45:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqwhL-0007QJ-00
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759853AbYD2UoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759632AbYD2UoV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:44:21 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:57079 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758530AbYD2UoU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:44:20 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+D1WRsg==
Received: from tigra.home (Fabc8.f.strato-dslnet.de [195.4.171.200])
	by post.webmailer.de (klopstock mo8) (RZmta 16.27)
	with ESMTP id f072e3k3TJgkND ; Tue, 29 Apr 2008 22:44:18 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 388D3277BD;
	Tue, 29 Apr 2008 22:44:18 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0485B56D28; Tue, 29 Apr 2008 22:44:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4816D505.1000208@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80729>

Paolo Bonzini, Tue, Apr 29, 2008 09:57:57 +0200:
>> Failing that, would you get slightly annoyed, or perhaps even quite
>> vexed if you find out that insert-program-used-to-do-some-work-with-here
>> did omething stupid that made you lose some of your work?
>
> Sorry, how does the patch make you lose some of your work (as opposed to  
> some of your time, which is possible as is the case for every backwards  
> incompatible change)?
>
> 1) what about the reflog?

It could not be enabled in repos before May 2006 (as the feature did
not exist back than).

> 2) the patch does not touch refs/heads/* unless you are tweaking your  
> configuration (and quite heavily so).  IMHO that's using enough rope  
> that you really ought to know about the reflog and... look for backwards  
> incompatible changes in the release notes!

Since when do you depend on people reading release notes and
immediately and correctly changing their behaviour?

> 3) your complaint was that it gave errors.  Alex did talk about losing  
> his work, but questions 1 and 2 would apply to him too.

Yes. And I can loose my work if "git fetch" (which I type without
thinking) will now update some remote I didn't mean it to.
Remote references can be shared - updated from different sites (think
mirros like kernel.org and repo.or.cz). Setups like this are used
elsewhere too (I use them).

> 4) one man's stupidity is another man's... [fill in]  In particular, did  
> you understand the rationale for this change?  Do you have any  
> alternative ideas?

Do you have a convincing one by now? And an acceptable transition plan?
("Read RelNotes!", yes, you mentioned. Another one?)
