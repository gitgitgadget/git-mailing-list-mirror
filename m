From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Problem with Cogito repository?
Date: Sun, 05 Jun 2005 23:08:24 -0700
Message-ID: <42A3E858.7070809@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 06 08:05:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfAjQ-00031x-QS
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFFGIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 02:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFFGIb
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 02:08:31 -0400
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:23467 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261179AbVFFGI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 02:08:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=mindspring.com;
  b=LUnaxabPTVFq3ZoPKdFu7PAG3n01SydW+beOps1FNSkkvnz+UI/eZ7bR8No8MBx6;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.164.169.109] (helo=[172.16.1.11])
	by smtpauth01.mail.atl.earthlink.net with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1DfAmf-0008Mc-SO
	for git@vger.kernel.org; Mon, 06 Jun 2005 02:08:26 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4d952c1ef0985169608e6b6bb22bd501a0350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.109
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've just updated my tree with cg-pull from 
rsync://rsync.kernel.org/pub/scm/cogito/cogito.git

There seems to be a problem with the repository object for tag 
"pull_from_pasky"

[philip@xray cogito]$ git-fsck-cache
bad sha1 entry '11ed64c1b141c9ba397a1ca76aef2cd250976007'
error: .git/refs/tags/pull_from_pasky: invalid sha1 pointer 
11ed64c1b141c9ba397a1ca76aef2cd250976007

And in fact 11ed64... _is_ bad:

[philip@xray cogito]$ ls -l 
.git/objects/11/ed64c1b141c9ba397a1ca76aef2cd250976007
-rw-r--r--    1 philip   philip          0 Jun  5 22:58 
.git/objects/11/ed64c1b141c9ba397a1ca76aef2cd250976007

Note the files is 0 bytes in size.

Or am I doing something wrong?
