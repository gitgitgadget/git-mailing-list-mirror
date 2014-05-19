From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: Any difference to unstage files using "git checkout" and "git rm"
Date: Mon, 19 May 2014 22:41:42 +0630
Organization: CognitiveClouds
Message-ID: <2609761.VA4bvU75e5@linux-wzza.site>
References: <6833494.47nikG189t@linux-wzza.site> <20140519160107.GE20289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 19:11:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmR60-0007jI-LN
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 19:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbaESRLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 13:11:24 -0400
Received: from nm2-vm4.bullet.mail.sg3.yahoo.com ([106.10.148.107]:25714 "EHLO
	nm2-vm4.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752965AbaESRLX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2014 13:11:23 -0400
Received: from [106.10.166.123] by nm2.bullet.mail.sg3.yahoo.com with NNFMP; 19 May 2014 17:11:21 -0000
Received: from [106.10.167.173] by tm12.bullet.mail.sg3.yahoo.com with NNFMP; 19 May 2014 17:11:08 -0000
Received: from [127.0.0.1] by smtp146.mail.sg3.yahoo.com with NNFMP; 19 May 2014 17:11:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400519481; bh=n5wNwt846cRZID9s3Psble85tek+/LjAVO4QzR6NnCo=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=Vid6sF9AsoW0s0/bnH3BBhGcOleDqCwtHzlLRdWIMvLaHahGAca5bNyhyskR3NbtbPw+khptm5k/KlKr9+gdQMJa4PZOz4Taa1aowbwX+ZkVyp2QyChleJ9yZrdqMKrVS/llcysPUyBIX2Q8CLU7LaisDfxQ0eibfAMjEhuCagY=
X-Yahoo-Newman-Id: 669520.48378.bm@smtp146.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: AFT7SWUVM1lMflI23Jk9gkmG0l2x2nyyIVJVxQl7PABmYyE
 IuHvd40.7bII8FMWA1X9vBZkS7gEXQI8ZQGrPkVXunvDhfD14dR675r5K7KV
 JSve8eqYttiTtgbSZxHCj_LTVyfmJltHDPFEBUFitzxPEg5ux02vMGPSXpuS
 KZwcGGrWA3OvkKcM0hCNXPJS07tzEhVUxAU_78xjmVmNQRRLtFraN25.9o6x
 vOn.FilndHtga4GAtnDWK5.dAPqf.IGKlx0aD4m3iLZDjqio5dhfTbIBmCIq
 NNX4g9.wqByVXCOlrE9MBo1lQ4KgnFTLtCUf.3wWRtsEYMzlB81FTI0HQTfv
 wiJ_TciYtOHJhq8FInd6oZatw1WH6LUsXAgm01FGI6uCnZphBjr2i9hJrQtx
 OY8CRi77zlgxypWLguts.ir32qGdw_WtXm42bvweYbIsvCAntmzxBgl4Up0U
 aI8A5VjZpbu2F6.F4XKRGRo_8fMB6Hz1FTp9ggb_dKZr1peCCB18KGap3m29
 ND4o6_vHsSuvq0wcDtai69sjfQA--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.174.115 with plain [106.10.150.171])
        by smtp146.mail.sg3.yahoo.com with SMTP; 19 May 2014 10:11:21 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
In-Reply-To: <20140519160107.GE20289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249602>

On Monday, May 19, 2014 12:01:07 PM you wrote:
> On Mon, May 19, 2014 at 09:12:47PM +0630, Arup Rakshit wrote:
> > Is there any difference between the below 2 commands ? I didn't see
> > anything.
> > 

> 
> Does that help?

For me who is in Git just 6-7 days, It is huge. On your way, I was walking to 
test those out. But I got some messages from Git, which made me confused to 
think, about the *philosophy of those*.

arup@linux-wzza:~> mkdir Git_tutorial
arup@linux-wzza:~> cd Git_tutorial/
arup@linux-wzza:~/Git_tutorial> LS
If 'LS' is not a typo you can use command-not-found to lookup the package that 
contains it, like this:
    cnf LS
arup@linux-wzza:~/Git_tutorial> ls
arup@linux-wzza:~/Git_tutorial> echo "welcome to git" > test.txt
arup@linux-wzza:~/Git_tutorial> ls
test.txt
arup@linux-wzza:~/Git_tutorial> git init
Initialized empty Git repository in /home/arup/Git_tutorial/.git/
arup@linux-wzza:~/Git_tutorial> git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       test.txt
nothing added to commit but untracked files present (use "git add" to track)
arup@linux-wzza:~/Git_tutorial> git add test.txt
arup@linux-wzza:~/Git_tutorial> git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file:   test.txt
#

NOTE :- While, I have a new file in my repository, and I staged it, it is 
telling me to unstage it using *git rm -- cached <file>*. But once I committed, 
and the file became a tracked file in my repository, *Git* internal message got 
changed, *for unstaging*, Which is why, I asked this question. Look below -

arup@linux-wzza:~/Git_tutorial> git commit -m "commit1"
[master (root-commit) 20bf27f] commit1
 1 file changed, 1 insertion(+)
 create mode 100644 test.txt
arup@linux-wzza:~/Git_tutorial> echo "How are you enjoying?" > test.txt
arup@linux-wzza:~/Git_tutorial> git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   test.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
arup@linux-wzza:~/Git_tutorial> git add test.txt
arup@linux-wzza:~/Git_tutorial> git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   test.txt
#
arup@linux-wzza:~/Git_tutorial>

It is now telling to USE "git reset HEAD <file>..." to unstage, NOT   "git rm 
--cached <file>..." to unstage.

Please let me know, If I am making you guys more confused.

-- 
===============
Regards,
Arup Rakshit
