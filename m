From: victor <liwenxi9999@163.com>
Subject: Re: Installed git 2.1.3 on sparc 8, but got core dump during 'git
 clone'
Date: Wed, 5 Nov 2014 23:38:27 -0800 (PST)
Message-ID: <1415259507566-7620694.post@n2.nabble.com>
References: <1415251144220-7620692.post@n2.nabble.com> <1415255667304-7620693.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 08:38:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmHeL-00081A-MV
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 08:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbaKFHi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 02:38:29 -0500
Received: from sam.nabble.com ([216.139.236.26]:58085 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaKFHi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 02:38:29 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <liwenxi9999@163.com>)
	id 1XmHeF-0006kE-IW
	for git@vger.kernel.org; Wed, 05 Nov 2014 23:38:27 -0800
In-Reply-To: <1415255667304-7620693.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

Thanks for your help, as your suggestion, I can compile/install git with
--disable_ptheads now.

While ran 'git clone', it still got core dump.

Would you please have a look at it? 

(gdb) bt full
#0  0xff0332ec in strlen () from /usr/lib/libc.so.1
No symbol table info available.
#1  0xff0866b8 in _doprnt () from /usr/lib/libc.so.1
No symbol table info available.
#2  0xff088ac0 in vsnprintf () from /usr/lib/libc.so.1
No symbol table info available.
#3  0x00137c18 in vreportf (prefix=0x190038 "cannot create thread: %s",
    err=0x190038 "cannot create thread: %s", params=0xffbeec88)
    at usage.c:12
        msg = "' for tags you want to propagate.\" >&2\n\t\t\texit 1\n\t\tfi               
\n\t\t;;\n\trefs/tags/*,delete)\n\t\t# delete tag\n\t\tif [ \"$allowdeleteta               
g\" != \"true\" ]; then\n\t\t\techo \"*** Deleting a tag is not allowed in t               
his repository\""...

Thanks,
Victor



--
View this message in context: http://git.661346.n2.nabble.com/Installed-git-2-1-3-on-sparc-8-but-got-core-dump-during-git-clone-tp7620692p7620694.html
Sent from the git mailing list archive at Nabble.com.
