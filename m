From: SungHyun Nam <namsh@posdata.co.kr>
Subject: Re: using merge subtree and move it..
Date: Tue, 09 Sep 2008 18:59:45 +0900
Message-ID: <48C64911.4020202@posdata.co.kr>
References: <ga4fho$5ib$1@ger.gmane.org> <48C61E1F.6000907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 12:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd027-0004YJ-MZ
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 12:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbYIIKAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 06:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbYIIKAH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 06:00:07 -0400
Received: from main.gmane.org ([80.91.229.2]:56323 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbYIIKAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 06:00:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kd00v-0004TI-4I
	for git@vger.kernel.org; Tue, 09 Sep 2008 10:00:02 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 10:00:01 +0000
Received: from namsh by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 10:00:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48C61E1F.6000907@viscovery.net>
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95366>

Johannes Sixt wrote:
> SungHyun Nam schrieb:
>> I used the subtree merge strategy. And then I moved the directory.
>> Now, can I use subtree merge for that new directory?
> 
> Sure. It should work just fine.
> 
>> $ git pull -s subtree klib master
>> remote: Counting objects: 5, done.
>> remote: Compressing objects: 100% (2/2), done.
>> remote: Total 3 (delta 1), reused 0 (delta 0)
>> Unpacking objects: 100% (3/3), done.
>> From ssh://192.168.10.10/git/libs/klib
>>  * branch            master     -> FETCH_HEAD
>> error: Entry 'klib/klib.c' not uptodate. Cannot merge.
> 
> Your problem is not related to subtree merge. Make sure you have no
> changes to commit before you merge.

It seems I forgot to commit after running 'git mv lib/klib klib'.
Oops! :( I'm not sure because the problem gone after I did some
stupid things.  The 'some stupid things' include 'git rm -rf klib;
...; git remote rm klib and re-doing using-merge-subtree.....'.

BTW, I have no idea how I can push 'local changes in subtree' to remote.
The 'Additional tips' in using-merge-subtree.txt said it is
possible using subtree. But don't know how? Could someone show me
a sample command/setup sequence?

Thanks,
namsh
