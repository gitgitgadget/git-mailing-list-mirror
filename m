From: Matthias Lehmann <mat@matlehmann.de>
Subject: Re: git-apply fails on creating a new file, with both -p and --directory specified
Date: Thu, 29 Apr 2010 10:20:17 +0200
Message-ID: <hrbfg2$t5m$1@dough.gmane.org>
References: <201004281429.26579.mat@matlehmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 20:32:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7v0f-0002wd-So
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 20:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933932Ab0D3S3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 14:29:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:49041 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933808Ab0D3S1i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 14:27:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O7Pue-00018t-1l
	for git@vger.kernel.org; Thu, 29 Apr 2010 11:20:04 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Apr 2010 11:20:04 +0200
Received: from mat by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Apr 2010 11:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: KNode/4.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146042>

Matthias Lehmann wrote:

> Hi all,
> 
> the subject of this mail may read familiar to some - there was a
> discussion in November last year (see
> http://kerneltrap.org/mailarchive/git/2009/11/23/16899/) concerning this
> problem.
> 
> Today I had this same issue with git 1.7.0.4. Reading the above mentioned
> discussion and seaching the net did not help me in finding a solution to
> the problem.
> 
> I have to apply patches from one repository to another repository, which
> have a different layout (I am working on splitting one big repository into
> several smaller ones, while development still continues on the big
> repository).
> 
> So I did
> 
> big-repo$ git format-patche -o /tmp/foo
> small-repo$ git apply -p2 --directory=some/path --check /tmp/foo/*
> 
> and get
> 
> fatal: git diff header lacks filename information when removing 2 leading
> pathname components (line 37)
> 
> the patch looks like this:
> 
> 35| diff --git a/xyz/bar.jpg b/xyz/bar.jpg
> 36| new file mode 100644
> 37| index
> 
0000000000000000000000000000000000000000..3dcce2e1f68586ed2089d86b1bf4e7e41c818d97
> 38| GIT binary patch
> 39| literal 8791
> 
> 
> 
> Since this problem was discussed before - is there a solution?
> This is something like a showstopper for me right now, so I am very
> thankful for any hints.
> 
> Best regards,
> 
> Mat

Is there anything I can do to get some feedback to this issue? I don't want 
to be impatient, it's just quite important to me. 

Since I have not much experience in reporting issues to a mailing list, it 
might well be, that I did something wrong - so please correct me and direct 
me to how I can be of better help.

Best regards,

Mat
