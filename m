From: SungHyun Nam <namsh@posdata.co.kr>
Subject: using merge subtree and move it..
Date: Tue, 09 Sep 2008 09:21:10 +0900
Message-ID: <ga4fho$5ib$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 02:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcr03-0006RZ-AZ
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 02:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbYIIAVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 20:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbYIIAVY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 20:21:24 -0400
Received: from main.gmane.org ([80.91.229.2]:60009 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755933AbYIIAVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 20:21:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kcqyu-0007gM-Je
	for git@vger.kernel.org; Tue, 09 Sep 2008 00:21:21 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 00:21:20 +0000
Received: from namsh by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 00:21:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95321>

Hello,

I used the subtree merge strategy. And then I moved the directory.
Now, can I use subtree merge for that new directory?

I just tried 'read-tree'.. (klib was in 'libs/klib').

$ git read-tree --prefix=klib/ -u klib/master
error: Entry 'klib/Makefile' overlaps with 'klib/Makefile'.  Cannot bind.

Hmm.. just tried subtree merge..

$ git pull -s subtree klib master
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From ssh://192.168.10.10/git/libs/klib
  * branch            master     -> FETCH_HEAD
error: Entry 'klib/klib.c' not uptodate. Cannot merge.
fatal: merging of trees 31dd1721641a25bfb0225138a34c43483d870377 and 
bccba7da98b042817fdbd92c62b706919216b571 failed
Merge with strategy subtree failed.

Thanks,
namsh
