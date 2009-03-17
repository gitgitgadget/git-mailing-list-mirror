From: Giovanni Bajo <rasky@develer.com>
Subject: Re: [PATCH] Give error when no remote is configured
Date: Tue, 17 Mar 2009 01:12:36 +0100
Organization: Develer S.r.l.
Message-ID: <49BEEAF4.40403@develer.com>
References: <alpine.LNX.1.00.0903110139450.19665@iabervon.org>	 <7vocw2x7ob.fsf@gitster.siamese.dyndns.org>	 <alpine.LNX.1.00.0903161204240.19665@iabervon.org> <76718490903161301qca2214cta87411bad1b0b8b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, bernie@codewiz.org,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjX0Y-00010j-Md
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbZCQK5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbZCQK5V
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:57:21 -0400
Received: from trinity.develer.com ([89.97.188.34]:35312 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbZCQK5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:57:20 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2009 06:57:20 EDT
Received: (qmail 31508 invoked from network); 17 Mar 2009 10:50:36 -0000
Received: from mimax.trilan (HELO ?10.3.3.214?) (rasky@10.3.3.214)
  by trinity.develer.com with ESMTPA; 17 Mar 2009 10:50:36 -0000
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <76718490903161301qca2214cta87411bad1b0b8b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113458>

On 3/16/2009 9:01 PM, Jay Soffian wrote:
> On Mon, Mar 16, 2009 at 12:55 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> No default remote is configured for your current branch, and the default
>> remote "origin" is not configured either.
> 
> The use of "default" twice is slightly confusing. Perhaps:
> 
> No remote is configured for the current branch, and the default
> remote "origin" is not configured either.

I'm a total newbie with git. I must say that the above sentence means 
absolutely nothing to me (in either version) because of the confusing 
usage of the word "remote" (twice, one as a substantive, one as an 
adjective) and the word "origin" which is git jargon which I don't 
master yet.

My suggestion is that you should at least add a sentence that points to 
a likely solution. Something like:

   (use "git remote add" to configure a remote URL)

Note that I don't have any clue if this sentece is correct and/or is the 
correct solution. The above is just an example of a helpful error message.
-- 
Giovanni Bajo
Develer S.r.l.
http://www.develer.com
