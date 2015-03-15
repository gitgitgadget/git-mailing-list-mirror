From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: fatal: Unable to mark file .ruby-version
Date: Sun, 15 Mar 2015 16:31:18 +0630
Organization: CognitiveClouds
Message-ID: <1645103.91WotSCBpm@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 12:09:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX6QM-0005Dw-3g
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 12:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbCOLJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 07:09:33 -0400
Received: from nm5-vm1.bullet.mail.sg3.yahoo.com ([106.10.148.144]:53982 "EHLO
	nm5-vm1.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721AbbCOLJc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 07:09:32 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2015 07:09:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1426417417; bh=zUs9XPCKpPwm1m4LH9MEVPKhIZt6IYrFQHQZF7Xv6Lk=; h=From:To:Subject:Date:From:Subject; b=NRP8PyH7PyhFdPCN7QO+2aFy7oumFNhxeUMsEtOFpl18MB6OcFQI31Z9UXzZzsvIjP1mzZ4hndbSzOg5aif56+HjyQFVR4S0xqOITy+IcJ02lrM+PRLeInOJOTNbRXxuXvlK3DmceIDJTxrWPaAo1E2RSbROM3GEAAW2T9/5tTc0ZxvvtQH8X1tZEGlAN4HzciEBvfN3f+ScV4uY+4KllmunSsKFjdQWwvzWcIUv5Gi5aTEONlOV2mxYXa0dqIok8du17sOrOF980qbNBqDAfv/3NKfZ4t68KNFgHq3Khp3gkdsIicBUJUzUqQt00bN/J6AI0uwNJGIx6cZcHdzklw==
Received: from [106.10.166.62] by nm5.bullet.mail.sg3.yahoo.com with NNFMP; 15 Mar 2015 11:03:37 -0000
Received: from [106.10.167.131] by tm19.bullet.mail.sg3.yahoo.com with NNFMP; 15 Mar 2015 11:03:37 -0000
Received: from [127.0.0.1] by smtp104.mail.sg3.yahoo.com with NNFMP; 15 Mar 2015 11:03:37 -0000
X-Yahoo-Newman-Id: 775825.6668.bm@smtp104.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: s1DYJcUVM1mxZhOankD0lUOFyy1UuAUZEds9CI_ZGoA6HTX
 RNrKesgAHF1QYicXwrBQgKKYaISzqxVbl7I3Gi8SdAMw2gaUnYoLpVk8c3ew
 1AlibAK7E8KbsChTcmeBMHWZBu8TGh3zroYdsjfD6BGfeNM8pwPHbkOqsI2T
 6sdUir79pM1kZpebXOxv0epm81Zxeb8868UWPv9VBrWH.CZCwWxHTedvRcCQ
 jFezNOHp_YUiSoCdFoYX53uOxwSOeHs.b.VAttcfv_PkbfXktewaMvrzru_G
 vJgAAeyxUG6BMsTHoyIVGT18Nu7It5Bxt8gKNHjuaCNt.lEs5sgua7fwUGWd
 RTxxKJDY4qHXZ2RMx0xKRfZYDgVA3SrHD_aHnREpxYfsd3Y5J19C1w0jR1V9
 _HkoAlriwgGAL0iNXpet.2vYmRwasDOxatJPQwkZKcaWK_tFH9hn3_IHM6kR
 KioVaMWFuYNae0JQTY57MV0_7Hs1t11fYBte1C7aN4xmnA7As83fac0L_gf0
 XOJQnUYIW.iRPdjQcssvOZvcRFMuJVTcvH.qgF7POmCmgpwSDGaMCHYm_BF5
 n0.wzOaRx
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-25-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265488>

Hi,

I am trying to ignore 2 files, but getting error -

[arup@sztukajedzenia (SJ002)]$ git status
# On branch SJ002
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .ruby-gemset
#       .ruby-version
nothing added to commit but untracked files present (use "git add" to track)
[arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-gemset
fatal: Unable to mark file .ruby-gemset
[arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-version
fatal: Unable to mark file .ruby-version
[arup@sztukajedzenia (SJ002)]$

Why it is throwing error ? And how to achieve this without taking the help of the file `.gitignore` ?

-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.

--Brian Kernighan
