From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: config for merging master to test branch
Date: Tue, 29 Dec 2009 12:56:08 -0500
Message-ID: <20091229175607.GA3683@panix.com>
References: <20091228233838.GA28052@panix.com> <20091229164343.GA17546@panix.com> <7vvdfphgbu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 18:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPgJC-0004n2-WB
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 18:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbZL2R4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 12:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbZL2R4K
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 12:56:10 -0500
Received: from mail1.panix.com ([166.84.1.72]:50399 "EHLO mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbZL2R4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 12:56:09 -0500
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail1.panix.com (Postfix) with ESMTP id 3E3C91F091
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 12:56:08 -0500 (EST)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id 295282422B; Tue, 29 Dec 2009 12:56:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vvdfphgbu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135816>

Hi Junio:

> Good.  That is how it was designed to be used ;-)

Thanks for the reassurance.


>     [branch "test"]
>         remote = origin
>         merge = refs/heads/master
> 
>     When on branch "test", "pull" and "fetch" by default interact with the
>     "origin" repository, and "pull" integrates what was found on the
>     'master' branch from that remote into your history.

Excellent.  Initially, I wasn't sure what the following commands did:

   git config branch.test.remote origin
   git config branch.test.merge refs/heads/master

Between further reading and your explanation I now understand it better. 
"refs/heads/master" refers items displayed by "git show-ref".

So what is "refs/remotes/origin/master", please?

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409
