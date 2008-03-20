From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Importing all modules in a CVS repo with git-cvsimport
Date: Thu, 20 Mar 2008 15:33:35 +0000
Message-ID: <1206027215.24610.20.camel@pitcairn.cambridgebroadband.com>
References: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
	 <200803200646.08631.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 16:34:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcMmZ-0004Sq-EL
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 16:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387AbYCTPdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 11:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756393AbYCTPdj
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 11:33:39 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:40456 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbYCTPdi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 11:33:38 -0400
Received: by gv-out-0910.google.com with SMTP id s4so277916gve.37
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 08:33:34 -0700 (PDT)
Received: by 10.150.58.5 with SMTP id g5mr900430yba.158.1206027213194;
        Thu, 20 Mar 2008 08:33:33 -0700 (PDT)
Received: from ?10.0.0.166? ( [212.44.17.78])
        by mx.google.com with ESMTPS id i7sm464004nfh.14.2008.03.20.08.33.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Mar 2008 08:33:31 -0700 (PDT)
In-Reply-To: <200803200646.08631.robin.rosenberg.lists@dewire.com>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77665>


On Thu, 2008-03-20 at 06:46 +0100, Robin Rosenberg wrote:
> Den Wednesday 19 March 2008 19.35.36 skrev du:
> > Hi,
> >
> > I'm wanting to import the entirety of a CVS repository into git rather
> > than an individual module. However every approach I've tried to do this
> > fails as the underlying cvsps tool seems to only be able to deal with
> > modules rather than the whole project.
> >
> > Is there any invocation I could do that would do the whole import?
> 
> You didnt' mention anything about you tried, but I recall that using ',' for 
> the module name is possible. Some version of CVS do not like it however
> and will bug out.
> 

I tried:

git-cvsimport -v  -C /export/csrc/import_test/test.git -d $CVSROOT .
git-cvsimport -v  -C /export/csrc/import_test/test.git -d $CVSROOT ,

as well as the suggested ln -s tricks and none worked. I've now got a
copy of the actual repo from the cvs server so I'll try and fake up a
"supermodule" to contain the tree.

Any pointers always appreciated :-)


> -- robin
Alex, homepage: http://www.bennee.com/~alex/ Art is anything you can get
away with. -- Marshall McLuhan.
