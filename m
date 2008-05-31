From: david@lang.hm
Subject: unable to push
Date: Sat, 31 May 2008 08:03:47 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 17:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Sdb-0005TF-NI
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 17:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYEaPDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 11:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYEaPDg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 11:03:36 -0400
Received: from mail.lang.hm ([64.81.33.126]:53986 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbYEaPDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 11:03:35 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m4VF3YVC026675
	for <git@vger.kernel.org>; Sat, 31 May 2008 08:03:34 -0700
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83391>

for some reason when I try to push to my public repo I get a message that 
everything is up to date, but if I switch to that repo and do a pull it 
updates properly

I tried recreating the public repo the last time this happened, but it 
looks like when I do git am followed by git revert --hard HEAD^ (to fix 
the patch) followed by git am it breaks again.

David Lang

root@asgard:/var/www/adastra/xml2pdf/current# git push public
root@asgard's password:
Everything up-to-date
root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote public
root@asgard's password:
d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        HEAD
d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        refs/heads/localmaster
d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        refs/remotes/origin/master
7fcb26098cb3885f8b553b052ca3c3dfef3a508b        refs/tags/1.5.1
73580be6e04cf2e106c70ab352a94e2bfd5faeb6        refs/tags/1.5.10
85fe03cb12f795c2b40239d0e656de63eb7c81d7        refs/tags/1.5.11
469a1473911289b9a60c069094113bb9ef97a0f8        refs/tags/1.5.12
94bc2757622ccfd3668dd9b505d623893e37efbe        refs/tags/1.6.0
5aef76575a993d51f0ae628b36964c37cd26a7c3        refs/tags/1.7.0
0141ecaa92a34aac63fb2c0689683eb1a701dca3        refs/tags/1.7.1
d5d7d1962bdb8d5f7444696cb4ea07d6a6ab8d9e        refs/tags/1.7.2
2a844908229621f9c31ccb5b33d8907abeb64b36        refs/tags/1.7.4
8c07c4666d6e9eb88f0197416a38f841cf2c9b9d        refs/tags/1.7.6
046968a4fa5767db9387e940d5138ac10391020f        refs/tags/1.8.0
ec48db4ecacda648333596ef17ce8a0a588645a8        refs/tags/1.8.1
ad7c88741bf2631eca9c3d24721b1bd8ec4a4793        refs/tags/1.8.2
be0f3ccd11f5064b40f089b62152b820fb3aaf6f        refs/tags/1.8.3
root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote .
71ab4eea48eb3407a2ff4eef2befe9251897d676        HEAD
71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/heads/master
7fcb26098cb3885f8b553b052ca3c3dfef3a508b        refs/tags/1.5.1
73580be6e04cf2e106c70ab352a94e2bfd5faeb6        refs/tags/1.5.10
85fe03cb12f795c2b40239d0e656de63eb7c81d7        refs/tags/1.5.11
469a1473911289b9a60c069094113bb9ef97a0f8        refs/tags/1.5.12
94bc2757622ccfd3668dd9b505d623893e37efbe        refs/tags/1.6.0
5aef76575a993d51f0ae628b36964c37cd26a7c3        refs/tags/1.7.0
0141ecaa92a34aac63fb2c0689683eb1a701dca3        refs/tags/1.7.1
d5d7d1962bdb8d5f7444696cb4ea07d6a6ab8d9e        refs/tags/1.7.2
2a844908229621f9c31ccb5b33d8907abeb64b36        refs/tags/1.7.4
8c07c4666d6e9eb88f0197416a38f841cf2c9b9d        refs/tags/1.7.6
046968a4fa5767db9387e940d5138ac10391020f        refs/tags/1.8.0
ec48db4ecacda648333596ef17ce8a0a588645a8        refs/tags/1.8.1
ad7c88741bf2631eca9c3d24721b1bd8ec4a4793        refs/tags/1.8.2
be0f3ccd11f5064b40f089b62152b820fb3aaf6f        refs/tags/1.8.3
a633ac7b02b513e0d8a44152448e3c43ace996d0        refs/tags/1.8.4
71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/tags/1.8.5
root@asgard:/var/www/adastra/xml2pdf/current# cd /var/www/git/xml2pdf.git/
root@asgard:/var/www/git/xml2pdf.git# git pull
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (6/6), done.
From /movies/www/adastra/xml2pdf/current/
    d3f3d84..71ab4ee  master     -> origin/master
  * [new tag]         1.8.5      -> 1.8.5
Updating d3f3d84..71ab4ee
Fast forward
  xml2pdf.pl |   22 +++++++++++-----------
  1 files changed, 11 insertions(+), 11 deletions(-)
root@asgard:/var/www/git/xml2pdf.git# cd -
/var/www/adastra/xml2pdf/current
root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote public
root@asgard's password:
71ab4eea48eb3407a2ff4eef2befe9251897d676        HEAD
71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/heads/localmaster
71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/remotes/origin/master
7fcb26098cb3885f8b553b052ca3c3dfef3a508b        refs/tags/1.5.1
73580be6e04cf2e106c70ab352a94e2bfd5faeb6        refs/tags/1.5.10
85fe03cb12f795c2b40239d0e656de63eb7c81d7        refs/tags/1.5.11
469a1473911289b9a60c069094113bb9ef97a0f8        refs/tags/1.5.12
94bc2757622ccfd3668dd9b505d623893e37efbe        refs/tags/1.6.0
5aef76575a993d51f0ae628b36964c37cd26a7c3        refs/tags/1.7.0
0141ecaa92a34aac63fb2c0689683eb1a701dca3        refs/tags/1.7.1
d5d7d1962bdb8d5f7444696cb4ea07d6a6ab8d9e        refs/tags/1.7.2
2a844908229621f9c31ccb5b33d8907abeb64b36        refs/tags/1.7.4
8c07c4666d6e9eb88f0197416a38f841cf2c9b9d        refs/tags/1.7.6
046968a4fa5767db9387e940d5138ac10391020f        refs/tags/1.8.0
ec48db4ecacda648333596ef17ce8a0a588645a8        refs/tags/1.8.1
ad7c88741bf2631eca9c3d24721b1bd8ec4a4793        refs/tags/1.8.2
be0f3ccd11f5064b40f089b62152b820fb3aaf6f        refs/tags/1.8.3
71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/tags/1.8.5
root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote .
71ab4eea48eb3407a2ff4eef2befe9251897d676        HEAD
71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/heads/master
7fcb26098cb3885f8b553b052ca3c3dfef3a508b        refs/tags/1.5.1
73580be6e04cf2e106c70ab352a94e2bfd5faeb6        refs/tags/1.5.10
85fe03cb12f795c2b40239d0e656de63eb7c81d7        refs/tags/1.5.11
469a1473911289b9a60c069094113bb9ef97a0f8        refs/tags/1.5.12
94bc2757622ccfd3668dd9b505d623893e37efbe        refs/tags/1.6.0
5aef76575a993d51f0ae628b36964c37cd26a7c3        refs/tags/1.7.0
0141ecaa92a34aac63fb2c0689683eb1a701dca3        refs/tags/1.7.1
d5d7d1962bdb8d5f7444696cb4ea07d6a6ab8d9e        refs/tags/1.7.2
2a844908229621f9c31ccb5b33d8907abeb64b36        refs/tags/1.7.4
8c07c4666d6e9eb88f0197416a38f841cf2c9b9d        refs/tags/1.7.6
046968a4fa5767db9387e940d5138ac10391020f        refs/tags/1.8.0
ec48db4ecacda648333596ef17ce8a0a588645a8        refs/tags/1.8.1
ad7c88741bf2631eca9c3d24721b1bd8ec4a4793        refs/tags/1.8.2
be0f3ccd11f5064b40f089b62152b820fb3aaf6f        refs/tags/1.8.3
a633ac7b02b513e0d8a44152448e3c43ace996d0        refs/tags/1.8.4
71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/tags/1.8.5
