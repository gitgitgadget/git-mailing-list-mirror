From: Philip Smith <philip_smith@apple.com>
Subject: Using git and mvn release plug in
Date: Tue, 25 May 2010 15:11:25 -0700
Message-ID: <0AED808D-8CBB-47B9-9BBC-15067D19AC1F@apple.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 00:18:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH2Rz-00089b-TM
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758871Ab0EYWSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 18:18:10 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:62083 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab0EYWSJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 18:18:09 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2010 18:18:08 EDT
Received: from relay16.apple.com (relay16.apple.com [17.128.113.55])
	by mail-out4.apple.com (Postfix) with ESMTP id 586149B6601C
	for <git@vger.kernel.org>; Tue, 25 May 2010 15:11:25 -0700 (PDT)
X-AuditID: 11807137-b7c23ae000001561-83-4bfc4b0dce5c
Received: from pasmith.apple.com (pasmith.apple.com [17.228.32.42])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay16.apple.com (Apple SCV relay) with SMTP id 1A.44.05473.D0B4CFB4; Tue, 25 May 2010 15:11:25 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147728>

I want to use git to store my mvn projects. I have a bare git repository containing multiple projects and I have cloned the bare repository to a local repository and I am working in each mvn project.

$ cd $HOME
$ git clone ssh://mycomputer.foobar.com/Users/git/repository 

and then I have my mvn projects layed out as:

$HOME/git/com.foobar.mygroup/project.one
$HOME/git/com.foobar.mygroup/project.two
...


When I run mvn release:prepare all seems ok but it fails on mvn release:perform.

[INFO] [INFO] Cannot execute mojo: resources. It requires a project with an existing pom.xml, but the build is not using one.

I notice the working directory is target/checkout and this has the complete source tree of the repository which means the project pom.xml is found 2 levels down in target/checkout/com.foobar.mygroup/project.one.

I have browsed the scm and git plugin documentation and I don't find anything to tell me how to configure my project plug in to get a sub-tree of the repository rather than the whole repository.

Any help would be gratefully received.

Regards, Philip

Philip Smith
Senior Software Engineer
philip_smith@apple.com
408 862-1360 office
530 574-1659 mobile
