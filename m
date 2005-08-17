From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC] Patches exchange is bad?
Date: Wed, 17 Aug 2005 01:27:09 -0700 (PDT)
Message-ID: <20050817082709.28135.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 10:27:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5JGb-0007EW-LZ
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 10:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVHQI1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 04:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVHQI1T
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 04:27:19 -0400
Received: from web26301.mail.ukl.yahoo.com ([217.146.176.12]:33204 "HELO
	web26301.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750889AbVHQI1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 04:27:18 -0400
Received: (qmail 28137 invoked by uid 60001); 17 Aug 2005 08:27:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lg2mcC/DPNnzt7iwHdPdNvo20xKQiSRAlH09PfZF9pITKPdJA5EFmh+n1dDth6O9JO9h3jFFpsK996HP1xZeYNSIKRJkSLYVAXSFi19jbkj/R6cgVM0OivTr3/kT3Ml/aUWAsWtrfbyNy0kw+dtlLvm2jV57S5CGDqlXKVRn2Bs=  ;
Received: from [151.42.53.158] by web26301.mail.ukl.yahoo.com via HTTP; Wed, 17 Aug 2005 01:27:09 PDT
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:

>>2) Practical: The round trip git-format-patch + git-applymbox is the logical and
>>natural way to reach this goal or, also in this case, I intend to stretch some tools,
>>designed for one thing, for something else?
>
>
>I'd guess that git-diff-tree + git-apply (without the rest of the
>scripting) would be more effective when you're not doing anything with the
>intermediate files, since it saves doing a bunch of formatting and
>parsing.
>
>
It would be surely better, but I need to import also the original subject and
description. I can use git-diff-tree --pretty -p for the patch creation, but this
format is not compatible with git-apply* scripts, and the git command git-apply does
not import subject + description info.

Of course I can feed proper subject and description to git-commit but I would like 
to find something less intrusive as possible, ie. one command for patch export, one 
command for patch import.

Thanks
Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
