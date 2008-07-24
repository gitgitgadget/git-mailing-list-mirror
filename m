From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Submodules: Publishing a locally created submodule.
Date: Thu, 24 Jul 2008 16:40:43 +0100
Message-ID: <18071eea0807240840g79da962ci8fbc65546d496323@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM2wt-0000xs-82
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 17:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYGXPkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 11:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYGXPkq
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 11:40:46 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:58977 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYGXPkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 11:40:45 -0400
Received: by yx-out-2324.google.com with SMTP id 8so502629yxm.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=9JweJiV9/OwfsrLwMUdGJdEfkhK3fGpLNMh8UPb+XGQ=;
        b=q8ztSZwcSM0ZOe3Pcbo2RDUr+FlPnkCmHf/JfcI93+sOTd0WcaaKR2eAEVqig6tYOo
         NqzU30zgCtPEYvw3ihtuPvlePdB9xo1Rdj45/jrxDx3sWOmOQa3IL1TXwm2mFV1qdyRl
         gIf0Ku3oP0Oq8RlaqUqDOs+es0+VGueUITNZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=OtzyhwVuTTTlw2IZRHZTeztU99Z8rybxcdwzHSRhsFvMJbgk+dGuWGLs6O8BH9JgB9
         u+x4AEwdSlrnAENLT7GFqbe+ch3dJUnhFn/8bXwU1rP8GCLaYu50GSsaf+2lOPVMJnzc
         iZusChIcd96pPv21t4yLgQWs2ixq+C/De8g04=
Received: by 10.142.222.4 with SMTP id u4mr134791wfg.329.1216914043260;
        Thu, 24 Jul 2008 08:40:43 -0700 (PDT)
Received: by 10.142.104.15 with HTTP; Thu, 24 Jul 2008 08:40:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89897>

Hello all,

I'm a little confused having read the submodule chapter in the GIT
users' manual and was wondering if someone here can help.

I've setup a bare repository with some submodule in it which I and
others are able to clone from just fine -- in that sense, it acts just
like an "ordinary" repository.

But I am a little stuck getting my head around a scenario:

Most us here work in a very CVS-like way.  I did the following:

git clone ssh://foo/bar/project myclone
cd ./myclone

In there is a directory which is a submodule.  At the time I created
the bare repo it was cloned already from a repo which had a submodule.
 I decided I wanted another submodule to be published so I did this:

cp -r ./mysubmoduleA ./mysubmoduleB && rm ./mysubmoduleB/.git

Now:  I want to make mysubmoduleB a submodule which I can publish to
the shared repository and when others pull, to see that submodule and
be able to treat it as such.

But I can't see how to do that.  Can someone help?

Many thanks in advance.

-- Thomas Adam
