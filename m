From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Tue, 24 Apr 2007 17:18:18 +0200
Message-ID: <462E1FBA.9020109@op5.se>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com> <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com> <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com> <9e4733910704211059h16c06e11k967d0bdd3e4970fc@mail.gmail.com> <e5bfff550704211128i12035947i7597e920a0eca163@mail.gmail.com> <462E18C8.4070001@op5.se> <alpine.LFD.0.98.0704241058490.12375@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 17:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgMnb-00053Z-2n
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 17:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbXDXPSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbXDXPSn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 11:18:43 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:47178 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422727AbXDXPSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 11:18:22 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 126996BCD1; Tue, 24 Apr 2007 17:18:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.179] (unknown [192.168.1.179])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 477A06BCCF; Tue, 24 Apr 2007 17:18:19 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <alpine.LFD.0.98.0704241058490.12375@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45461>

Nicolas Pitre wrote:
> On Tue, 24 Apr 2007, Andreas Ericsson wrote:
> 
>> Using a more efficient compression algorithm for the objects 
>> themselves (bzip2, anyone?) will most likely reduce storage size an 
>> order of magnitude more than reducing the size of the hash, although 
>> at the expense of CPU-efficiency.
> 
> An order of magnitude I really doubt it.  Maybe 20% could be a really 
> optimistic prediction.  But if bzip2 could reduce the repo by 20%, it 
> will slow runtime usage of that repo by maybe 100%.  That is not worth 
> it.
> 
> This is also the reason why we changed the default zlib compression 
> level from "best" to "default".
> 

... order of magnitude *more than reducing the size of the hash*.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
