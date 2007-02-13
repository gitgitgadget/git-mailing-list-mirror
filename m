From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: darcs2git.py - convert darcs repository using gfi
Date: Tue, 13 Feb 2007 23:42:14 +0100
Message-ID: <45D23EC6.9000806@xs4all.nl>
References: <eqoaf7$loq$1@sea.gmane.org> <20070212011401.GK31488@spearce.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: clee@kde.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 23:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH6M4-0007W9-RA
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 23:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbXBMWmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 17:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbXBMWmW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 17:42:22 -0500
Received: from main.gmane.org ([80.91.229.2]:38965 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbXBMWmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 17:42:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HH6Ln-0001k3-N1
	for git@vger.kernel.org; Tue, 13 Feb 2007 23:42:15 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 23:42:15 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 23:42:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <20070212011401.GK31488@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39595>

Shawn O. Pearce escreveu:
>> The python script attached is a try at providing a sane
>> conversion from Darcs to GIT.  It tries to map darcs conflict
>> resolutions onto git branch merges.
> 
> Impressive.

If anyone's interested I've hacked at it some more, 
and the result is at 

  http://repo.or.cz/w/darcs2git.git

I've further improved the script so it generates nicer 
bifurcations, and does the conversion more incrementally as 
possible, and can be considered fast (as far as any darcs project
can be called fast) 

I've successfully converted a project containing
3000 patches with it.  

> This is harder than it sounds.  fast-import internally is built
> around the assumption of a branch, which has a name, and which lives
> in the branch LRU.  With the "from" command restriction lifted
> you can just import every single commit onto the same hardcoded
> branch name (e.g. DARCS_HEAD) then delete it when you are done
> (e.g. rm .git/DARCS_HEAD).  That's basically the same thing as an

will this be in git v1.5 ?

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
