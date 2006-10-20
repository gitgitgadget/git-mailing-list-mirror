From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 17:34:58 +0200
Message-ID: <200610201734.59005.jnareb@gmail.com>
References: <200610180246.18758.jnareb@gmail.com> <200610201640.36640.jnareb@gmail.com> <Pine.LNX.4.63.0610201647420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 17:35:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GawP9-0003rn-12
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946274AbWJTPe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946379AbWJTPe6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:34:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:63961 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946274AbWJTPe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 11:34:57 -0400
Received: by ug-out-1314.google.com with SMTP id z34so653089ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 08:34:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HSbiYLm5vQFUAsbLS5dfff4sAJPXXvQbq5f32DhKZMic02huoSd6/seIrPBDx5/FXoaPSa5dhBlk04zJ0ehZns7YyUYA9/ddo01TsuzEmqXYDd/JGc5sLAQQKUmhPWZHhQ8gWYwTrybdLgauuD3pWALkElUCs08eIphz2a+tLa0=
Received: by 10.82.109.19 with SMTP id h19mr655157buc;
        Fri, 20 Oct 2006 08:34:55 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id b23sm1299833ugd.2006.10.20.08.34.54;
        Fri, 20 Oct 2006 08:34:55 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0610201647420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29490>

Johannes Schindelin wrote:
> On Fri, 20 Oct 2006, Jakub Narebski wrote:
> 
>> Jeff King wrote:
>>> 
>>> I was accustomed to doing such things in CVS, but I find the git way
>>> much more pleasant, since I don't have to do any arithmetic:
>>>   diff d8a60^..d8a60
>> 
>> By the way "diff d8a60" also works (unless d8a60 is merge commit, in
>> which case you would need "diff -c d8a60" or "diff -m d8a60").
> 
> I could be wrong, but I have the impression (even after actually testing 
> it) that "git diff d8a60" is equivalent to "git diff d8a60..HEAD", _not_ 
> "git diff d8a60^..d8a60".

Ooops, I mixed git-diff-tree (which behaves as mentioned above) with
git-diff, which according to documentation compares with working tree
(and not HEAD) if only one <tree-ish> is given.

git-diff(1):
       ?  When  one  <tree-ish>  is given, the working tree and the named tree are
          compared, using git-diff-index. The option --cached can be given to com-
          pare the index file and the named tree.

git-diff-tree(1):
       If there is only one <tree-ish> given, the commit is compared with its par-
       ents (see --stdin below).
-- 
Jakub Narebski
Poland
