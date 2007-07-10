From: "Russ Dill" <russ.dill@gmail.com>
Subject: git-svn+cygwin failed fetch
Date: Tue, 10 Jul 2007 11:06:16 -0700
Message-ID: <f9d2a5e10707101106w305e28acy55f465e558485298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 20:06:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8K6d-00007L-Vs
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 20:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047AbXGJSGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762669AbXGJSGT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 14:06:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:10566 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759068AbXGJSGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 14:06:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so95890nfb
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 11:06:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dRreP4ixHw3EqjLi72KkedX7ba3/016yiuA7UCZdGX0oUjoGjOPY+63YtXx2jt84iUvLEzd3H5WE0CsgQnl98kxvMeB3RBYw6+372+m5iStn1MGGlltIGvRdIftTman5WuGM+oKvqYwTPNJECOJ8G4sLZtT/6q9oT7iNP64NzdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UjjMA3TCFvgo3WQRMzhwoQ7fomeWvQgvMYLGrh8dTeRNRxAdNcufmgvcYAVmFy8bYLYF331Apc3pr4NGNqrTz5Oeb15ub++BpHYyxHBvXPO8iwvjw33fDMENjEjDqJtHLlO4R2VfjJc2aM+3jXSdzcwBKBC/Rse8mej6AdRdfQs=
Received: by 10.82.105.13 with SMTP id d13mr9992640buc.1184090776946;
        Tue, 10 Jul 2007 11:06:16 -0700 (PDT)
Received: by 10.82.149.11 with HTTP; Tue, 10 Jul 2007 11:06:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52102>

[...]/src $ mkdir foo
[...]/src $ cd foo
[...]/src/foo $ git-svn init -t tags -b branches -T trunk
https://www.[...].com/svn/foo/bar/bla
Initialized empty Git repository in .git/
Using higher level of URL: https://www.[...].com/svn/foo/bar/bla =>
https://www.[...].com/svn/foo

[...]/src/foo $ git-svn fetch
config --get svn-remote.svn.url: command returned error: 1

[...]/src/foo $ git config --get svn-remote.svn.url
https://www.[...].com/svn/foo

[...]/src/foo $ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url =  https://www.[...].com/svn/foo
        fetch = bar/bla/trunk:refs/remotes/trunk
        branches = bar/bla/branches/*:refs/remotes/*
        tags = bar/bla/tags/*:refs/remotes/tags/*

[...]/src/foo $ git --version
git version 1.5.2.2

[...]/src/foo $ git-svn --version
git-svn version 1.5.2.2 (svn 1.4.3)

My versions of git and svn are the one that comes with cygwin.
