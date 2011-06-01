From: =?UTF-8?B?IkRvbWluaWsgXCJTb2Nla1wiIETFgnVnYWpjenlrIg==?= 
	<dominik.dlugajczyk@codepill.com>
Subject: Git svn dcommit -> ignore one commit
Date: Wed, 01 Jun 2011 08:21:30 +0200
Message-ID: <4DE5DA6A.8020201@codepill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 08:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRepU-00031p-6S
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 08:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab1FAGWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 02:22:47 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37227 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab1FAGWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 02:22:45 -0400
Received: by wwa36 with SMTP id 36so5654982wwa.1
        for <git@vger.kernel.org>; Tue, 31 May 2011 23:22:43 -0700 (PDT)
Received: by 10.227.195.197 with SMTP id ed5mr1795886wbb.104.1306909363592;
        Tue, 31 May 2011 23:22:43 -0700 (PDT)
Received: from [192.168.95.84] (pc185120.godula.net [194.33.185.120])
        by mx.google.com with ESMTPS id ex2sm508239wbb.31.2011.05.31.23.22.41
        (version=SSLv3 cipher=OTHER);
        Tue, 31 May 2011 23:22:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174848>

Hi.

In my company, we need to use svn repository, but we want to use git. W=
e=20
decide to use git svn. Everyone will commit and push changes to git=20
repository. One guy will pull from this repository and dcommit it to=20
subversion. Everything looks ok, but in this repo we need some=20
submodule. This submodule is already in subversion as "external". I hav=
e=20
a commit, that adds submodule. This commit always fails when I use git=20
svn dcommit. I can remove this commit by git rebase, but i have to do=20
this always when I use dcommit.
My question: is there posibility to make dcommit ignore one specyfic co=
mmit?

Thanks
Dominik "Socek" D=C5=82ugajczyk
