From: Timo Hirvonen <tihirvon@gmail.com>
Subject: git pull fails
Date: Tue, 28 Mar 2006 16:28:31 +0300
Message-ID: <20060328162831.af1bd4c0.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Mar 28 15:28:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOEFH-0000oc-EU
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 15:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWC1N2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 08:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWC1N2Y
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 08:28:24 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:27890 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932159AbWC1N2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 08:28:24 -0500
Received: by zproxy.gmail.com with SMTP id m22so1614717nzf
        for <git@vger.kernel.org>; Tue, 28 Mar 2006 05:28:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Ibt4WrDKuGhoHul5Nn2eer8M+3Ot2TOHnzjqslJOSEm56YpiEFTKS0V0rw2mD3F+NcURnE6wAD68RzR3lp7hzmuT7em7lAXqYfPf8BNncgsBTOvAFWXM5h8dfrBjnS/AKDcsBiyvup5Qntun1HzwyqiktRnovssHAZ3+PCU8eJ8=
Received: by 10.64.148.19 with SMTP id v19mr487098qbd;
        Tue, 28 Mar 2006 05:28:22 -0800 (PST)
Received: from garlic.home.net ( [82.128.200.167])
        by mx.gmail.com with ESMTP id c5sm476479qbc.2006.03.28.05.28.20;
        Tue, 28 Mar 2006 05:28:22 -0800 (PST)
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18120>

I think fast-forward check in git-fetch is too strict:

28 16:13 /usr/src/git: git pull
Unpacking 33 objects
 100% (33/33) done
* refs/heads/todo: same as branch 'todo' of git://git.kernel.org/pub/scm/git/git
* refs/heads/maint: same as branch 'maint' of git://git.kernel.org/pub/scm/git/git
* refs/heads/origin: same as branch 'master' of git://git.kernel.org/pub/scm/git/git
* refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
  not updating.

After removing "exit 1" added by a9698bb22fb7b66e5882c3a5e7b2b8b53ea03f90 from
git-fetch "git pull" worked again.

-- 
http://onion.dynserv.net/~timo/
