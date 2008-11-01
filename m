From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sat, 01 Nov 2008 12:53:22 +0100
Message-ID: <490C4332.9040504@op5.se>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <m33aichgc1.fsf@localhost.localdomain> <20081031190157.GG17651@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:54:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwF43-0001PT-EM
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbYKALxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYKALxe
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:53:34 -0400
Received: from mail.op5.se ([193.201.96.20]:35430 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYKALxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:53:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A43C01B80347;
	Sat,  1 Nov 2008 12:48:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7tK+j61DQ4Ny; Sat,  1 Nov 2008 12:48:16 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id C8BC71B8035A;
	Sat,  1 Nov 2008 12:48:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081031190157.GG17651@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99737>

Theodore Tso wrote:
> On Fri, Oct 31, 2008 at 09:36:33AM -0700, Jakub Narebski wrote:
>>> +#if 0
>>> +	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
>>> +#endif
>> By the way, Mercurial names this command IIRC 'hg backout'. 
> 
> By the way, BitKeeper names this command "bk undo" (which is another
> reason why I would advocate against "git undo" as a syntatic sugar for
> "git checkout HEAD -- $*") --- not that I think there are too many BK
> refugees that might want to switch to git, but it shows that "undo"
> has its own ambiguities; gk uses "undo" the same way we currently use
> "git revert".
> 
> For people who argue that "git cherry-pick --revert" or "git
> cherry-pick -R" is too long, I'd argue that for most people its not a
> common command, and for those for which it is common, they can always
> make in alias for "git pick".
> 

Probably "git unpick" in that case.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
