From: Sam Vilain <sam@vilain.net>
Subject: Re: Multi-headed branches (hydra? :)) for basic patch calculus
Date: Mon, 03 Apr 2006 14:09:42 +1200
Message-ID: <443083E6.9090204@vilain.net>
References: <1143950852.21233.23.camel@localhost.localdomain> <46a038f90604021815g453c57c9pf95a0f70a62f2fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 04:10:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQEWG-0000d4-O8
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 04:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWDCCJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 22:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWDCCJ6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 22:09:58 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:10897 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964811AbWDCCJ5
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 22:09:57 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 626745F3A; Mon,  3 Apr 2006 14:09:54 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 46C1C1011;
	Mon,  3 Apr 2006 14:09:46 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604021815g453c57c9pf95a0f70a62f2fbc@mail.gmail.com>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18302>

Martin Langhoff wrote:

>On 4/2/06, Sam Vilain <sam@vilain.net> wrote:
>  
>
>>If the plumbing or a porcelain could be smart enough to automatically
>>create hydra when patches are not dependent, then many of the benefits
>>of patch calculus might come for free, without having to create these
>>complicated sounding entities manually.
>>    
>>
>
>I'm not too excited about the benefits of patch calculus -- it seems
>to break  many general usage scenarios(*) and I haven't seen many
>examples of those benefits that aren't a bit contrived.
>
>* - For instance: the common practice of having a patch series where
>you create a new function and later add calls to it breaks quite
>seriously under patch calculus.
>  
>

Perhaps.  But forget the darcs implementation for a moment.

When you make a commit, you're labelling it with the previous dependent
commit for this commit to apply.

So, git-commit-hydra would do this calculation based on the files
changed.  git-commit would assume the prior commit.  You still have both
options available.

>Are there common usage scenarios where patch calculus helps more than
>it hurts? Preferrably without involving manual recording of
>dependencies or full language parsers that guess them.
>  
>

I am in the process of converting a live repository as if it had been
committed to in this manner.  I'll post results shortly.

Sam.
