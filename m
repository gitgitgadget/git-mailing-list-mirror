From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Not able to create feature branch Git
Date: Wed, 13 Aug 2014 01:32:56 +0630
Organization: CognitiveClouds
Message-ID: <10058843.3H3SQKIfkQ@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 22:10:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHIPA-0003hM-0f
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbaHLUKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 16:10:43 -0400
Received: from nm9-vm3.bullet.mail.sg3.yahoo.com ([106.10.148.210]:48497 "EHLO
	nm9-vm3.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754794AbaHLUKm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2014 16:10:42 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Aug 2014 16:10:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1407873811; bh=ETkrhP7bIphPBwBjwS+LKhbz4boeFaIkdskXtv8GnD0=; h=Received:Received:Received:DKIM-Signature:X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Subject:Date:Message-ID:Organization:User-Agent:MIME-Version:Content-Transfer-Encoding:Content-Type; b=Y9pLTlieOIGKec7cVLPHREwnTMzwKZXoMQLCu25k+KlGxrw9idVUVJYtIYX74ZIo76btKdLySWohnndgQdtrgkl8SRW0ubu+0RZ3JwoXP6k+NUfF3/GuGI+gfEA4zNVIRTAb3Q9UlLGgPp6LzZFUfBwIvjmZ/9t6wBSeWBCnAKKoj04WR/dKRXW48900bkO4MY58sP7d0Pujr9YNks6KQKxh4TiqNYBw1XIywNSOOu3pNDgaJpt+lzlXyNWvoWbWWOirFfNkMzogdOG47HKfqmtytr+HZrmJIo4dO6s3WKp0shcee6xdY4ILZImO/n8cXv71HRheyFRKG09IG8CfyQ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s2048; d=rocketmail.com;
	b=kKkl4FWi1FEDwZJxs0ZsmZAW4vT9q9QsoQHfKXW6A98eQJHiH2qw9XzQ+SFTWeYFjlme2XxwGImVW+yZSKnYuBqV06n0hMjAdOhyuIK5oRpF4uDO42Q6uoiYcnjXO4S48M6hCNduD5SFG+dv1qbVWPPhw/uxzI05eemXIRagGC02Z2Ih5JfskSXnLJimUt1AmwDxnp89a0rwItGsrWh0Hk+RgNhwZUPkOYWWVe0/GS0lZJfCwmMTPu2flzIcmvroZ+obnuHWfDPmPEqWVhDKkzXTIrR2n2+ZTDjK/dzOKv3D7nNqDUtHJvq3ngZACQ+Bv1gURzv/xEpwqOiHKoRXeg==;
Received: from [106.10.166.121] by nm9.bullet.mail.sg3.yahoo.com with NNFMP; 12 Aug 2014 20:03:31 -0000
Received: from [106.10.167.134] by tm10.bullet.mail.sg3.yahoo.com with NNFMP; 12 Aug 2014 20:03:31 -0000
Received: from [127.0.0.1] by smtp107.mail.sg3.yahoo.com with NNFMP; 12 Aug 2014 20:03:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1407873811; bh=ETkrhP7bIphPBwBjwS+LKhbz4boeFaIkdskXtv8GnD0=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Subject:Date:Message-ID:Organization:User-Agent:MIME-Version:Content-Transfer-Encoding:Content-Type; b=cGpgZcDZw0sFBv8zyMLs/KBbAImK4LupG8Qx3S9/XH3fR4tdmQ+RrpSf/Sm3T8JhsjJdZ3HCpSKMRhxdiPu9TBRp8msY7U60KwowMOJzHz4oo9Vmf8O7Ae0D7YGPa9rQ1ejaf2gmy2C+L3XbWuAFVaRoJi/1VStrmuDDovExoTU=
X-Yahoo-Newman-Id: 772294.81872.bm@smtp107.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: ZPH8QYEVM1ng..Qk.3.NbgdWeXAA.YpR0p9jZnbl0z2nI0L
 4MWvwg1OCuA1X4CiDolo.k8UUD_fkbLyNtIbPFonNG3enaUntecBt_ZW7ANo
 RYACOIABAje6CgxnSZBaE25zaqaq03lIR3gLVpwXVwZrPgHwRLXUwWLjXSB4
 VZE7tB.qvq8EOQb8sSroqy8kbrynBQ2UOTz9HZkDJmA8LX6KpgKbn35z_Lts
 OktjJtJjsVbMS9FuLIsqnv8sGkkpS7feLTLA5xosR2g1702ZDJqA1BK_tldJ
 VjtYeJITfLqgGuJuq5ipgwImbi_VEdkTSPXfQQv2LD5_DmCa6lGiA62nHe.W
 EFmr2HoNQcd5o6lyTxPGGroFq7GkUO0b0P1XrDCU7cgzsqIDN2aj_hGv8Z4U
 _6O0cTFE13DcLFV_Sri6krJ0QDf0MkDl13w.3E9IumHSuZzYLeEn4kv7V0pT
 HTPC1Om7AGC9z7VAlJvOmmMgsL92.EzS4ND37_OfIi4U_SKFbDi8w49MNUrG
 QykH01k9R9b0VVNvA5_F2kEaLcrpTuCo-
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-17-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255162>

Hi,

I am not able to push my feature branch using Git. I cloned using SSH and SSH 
key is also added.

arup@linux-wzza:~/Ruby/yzz> git status
# On branch posward
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       lib/yzz/posward_side.rb
nothing added to commit but untracked files present (use "git add" to track)
arup@linux-wzza:~/Ruby/yzz> git add lib/yzz/posward_side.rb
arup@linux-wzza:~/Ruby/yzz> git status
# On branch posward
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   lib/yzz/posward_side.rb
#
arup@linux-wzza:~/Ruby/yzz> git commit -m "Yzz::Side is now refactord into 2 
classes, one of which is Yzz::PoswardSide."
[posward a31be0c] Yzz::Side is now refactord into 2 classes, one of which is 
Yzz::PoswardSide.
 1 file changed, 41 insertions(+)
 create mode 100644 lib/yzz/posward_side.rb
arup@linux-wzza:~/Ruby/yzz> git push origin posward
Warning: Permanently added the RSA host key for IP address '192.30.252.131' to 
the list of known hosts.
ERROR: Permission to boris-s/yzz.git denied to aruprakshit.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
arup@linux-wzza:~/Ruby/yzz> ls -al ~/.ssh
total 20
drwxr-xr-x  2 arup users 4096 May 27 00:17 .
drwxr-xr-x 44 arup users 4096 Aug 13 01:07 ..
-rw-------  1 arup users 1675 May 10 22:22 id_rsa
-rw-r--r--  1 arup users  408 May 10 22:22 id_rsa.pub
-rw-r--r--  1 arup users 2210 Aug 13 01:18 known_hosts
arup@linux-wzza:~/Ruby/yzz> xclip -sel clip < ~/.ssh/id_rsa.pub
arup@linux-wzza:~/Ruby/yzz> git push origin posward
ERROR: Permission to boris-s/yzz.git denied to aruprakshit.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
arup@linux-wzza:~/Ruby/yzz>



Can anyone tell me what is the problem ?

-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, 
if you write the code as cleverly as possible, you are, by definition, not 
smart enough to debug it.

--Brian Kernighan
