From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 13:27:51 +0200
Message-ID: <200806031327.52175.jnareb@gmail.com>
References: <200806030314.03252.jnareb@gmail.com> <vpqabi2zvci.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 03 13:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Uh9-0000mj-OJ
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 13:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbYFCL2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 07:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757345AbYFCL2A
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 07:28:00 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:48729 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbYFCL17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 07:27:59 -0400
Received: by ik-out-1112.google.com with SMTP id c28so455374ika.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 04:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=7H1f3XAfxFnJ2DESOz/V0vQ4ipN2+I1O6AojxWuQjVc=;
        b=O41ruU6fkDevIFny3I8XB1nqKRJ5kHv/XlXJDuJ+ZpPkJSW2MOXhu1Em9FHYrcJBaEAglmWtiPTpJi2Tfp1JHyhyWo19yGF0FcgpyeQyi3z15AORrOnPW0PGPhnJOJPxPc8Y5r9LAu6XCouwc8Hw44HLlEjW2lpuFY7ljyHvZj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Nx35e5Nm2bBg/+iP9XOIqettVEtNe2YquDLsEddukEwTYLgMxLPmhRVxCj3he8wbjS1MnxH6mwweuQ9nrNGscgRjw3KCmT0DYsF1zqYSUlCrg2Hn6K7odmmyB27820SRtna0JkUE2bnONStReZJZpyChXm+v/0IyQG462/k6WzE=
Received: by 10.125.77.15 with SMTP id e15mr709289mkl.109.1212492477474;
        Tue, 03 Jun 2008 04:27:57 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.244.52])
        by mx.google.com with ESMTPS id c25sm5297209ika.11.2008.06.03.04.27.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 04:27:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <vpqabi2zvci.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83641>

On Tue, 3 June 2008, Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> I think that octopus merge (merge with more than two parents/legs) is 
>> feature which is unique to git (isn't it?).  
> 
> bzr can do similar things:
> 
> bzr merge some-branch
> bzr merge --force some-other-branch
> bzr commit
> 
> Since bzr doesn't auto-commit after a merge, the above commands
> actually creates only one revision with 3 parents (the --force is here
> to let merge do it's job with uncommited changes in the tree).

But does it store octopus merge as octopus: commit with more than
two parents?  In git making octopus merge is easy, perhaps too easy...


True, the above actually could be inferred from mentioned blog post
  http://vcscompare.blogspot.com/2008/05/meet-candidates.html
namely that there were problems with converting git repositories
containing octopus merges to Mercurial (and there was a bug in 
git-fast-export which made bzr-fast-import crash on them).

-- 
Jakub Narebski
Poland
