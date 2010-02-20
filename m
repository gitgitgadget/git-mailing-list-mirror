From: Andrew Benton <b3nton@gmail.com>
Subject: Configuring git to for forget removed files
Date: Sat, 20 Feb 2010 10:37:39 +0000
Message-ID: <4B7FBB73.70004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 11:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nimib-0007Ey-5Y
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 11:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab0BTKhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 05:37:43 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:51392 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab0BTKhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 05:37:42 -0500
Received: by ewy28 with SMTP id 28so1056005ewy.28
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 02:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=hAPIdUZvuw4vcfc1fA5yZtzhk2uZV91cAyuXN6+ddRA=;
        b=oCGRjow4s3ZqZLMTOJm2UTpC0cvjWOW2grE4UGanKQoUqtlrdOdxeYZYgn0T56lSla
         DjZfFBcD9QJ+9BVJEzmsdZncsBwQwT6OXbdCFEjjPGg1xGpU0NCL4uGShHByIQMVbWr6
         F3k2UyceT6xe18Go7gi31iQ8N3luriLtXOo0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=V09RiP+4/LtG+kiz+EEde2+9cvwjGUVx8n2NgDNq0UtLNAY/bN3XcfMlRil/bTDuOh
         FgsV4Ngx5rCu8fRHGXQovanQmBmAbiTckEOzWJhk7lpLh5SwpkIW3NJXeeuIBYXGBIa+
         /pisi5RFsGRYpFVCHqKOcfZITpnLDEpADeAHA=
Received: by 10.213.99.142 with SMTP id u14mr1899109ebn.29.1266662261140;
        Sat, 20 Feb 2010 02:37:41 -0800 (PST)
Received: from ?192.168.1.5? ([86.112.48.122])
        by mx.google.com with ESMTPS id 13sm692966ewy.13.2010.02.20.02.37.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 02:37:40 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.3a2pre) Gecko/20100212 Shredder/3.2a1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140524>

Hello world
I have a project that I store in a git repository. It's a bunch of source tarballs and
some bash scripts to compile it all. Git makes it easy to distribute any changes I make
across the computers I run. The problem I have is that over time the repository gets ever
larger. When I update to a newer version of something I git rm the old tarball but git
still keeps a copy and the folder grows ever larger. At the moment the only solution I
have is to periodically rm -rf .git and start again. This works but is less than ideal
because I lose all the history for my build scripts.
What I would like is to be able to tell git to not keep a copy of anything that has been
git rm. The build scripts never get removed, only altered so their history would be
preserved. Is it possible to make git delete its backup copies of removed files?

Andy
