From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: confusion with some `git reset` commands
Date: Wed, 17 Dec 2014 01:09:08 +0630
Organization: CognitiveClouds
Message-ID: <2055441.uOK6yH3IMG@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 20:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0y4o-0006bD-KD
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbaLPTqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:46:30 -0500
Received: from nm22-vm4.bullet.mail.sg3.yahoo.com ([106.10.151.51]:45036 "EHLO
	nm22-vm4.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897AbaLPTqa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Dec 2014 14:46:30 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Dec 2014 14:46:29 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1418758830; bh=DFVmYimOwQVRw/f02GiBKdhOYYD/Z94JALmW9Dma2yo=; h=From:To:Subject:Date:From:Subject; b=R8fukWaB1VEYEAbHKG9fkfxniuDdvI+yqfFFeGYjRCgQd30EkLYkor2LXjZmQKZRkj5lJaPOFb4oR0GiXkwFS3yfQNeQ4cx2Bqf3TSeMSiFL0WFRWGnwSUbSOM6MQIF97yfaeEIDwCj7kl00rOrDWOPq7cOP3YQBWAk/zOEjY7rsnxriFiznQDTT9rKJPj2PzWdWkauVGunwGk5knk/zTZSl/Z6gCeXas5BUOgjmlFEj4R0X5auL4lgjuW32dmedaXq1bnqOvdxj4jQxlX1afOBI0XJarM5I2zon5IdWkjddPRjPYlDLjU95UOulmcHLMORewGrmeC3Q4LfFuEkIrw==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s2048; d=rocketmail.com;
	b=efUMcFq/++5XkK8n1T0L9cBMR/hMYI9cTevKN9whQSlof4rALR77L1sL02U2agN/xPUvsRNyJXnssMMAgMME9Tkiuc/vth1V7t7hOd0VINaoHdrC4AVc7Nr3fP/K/sPIdj+Ha1d7c2UuzidO5dPkd7g4hINxME1a1NA+aOHbPFaVnRGn+yKu/oMmWPtrxLDMRrtmUVzoO8fBk3alDP+M+yWaiK9/eWhZjDugcXcDRowYOFP8GlIuBFh35KyeRfSGT1J0s3wUxsO4MM8IxwgyjIuj4p8scanCRd7Nl0yEEF2mOFotdeps//VouXIK3e7RFprT97rxUXVLQSE7G+j0wA==;
Received: from [106.10.166.63] by nm22.bullet.mail.sg3.yahoo.com with NNFMP; 16 Dec 2014 19:40:30 -0000
Received: from [106.10.167.152] by tm20.bullet.mail.sg3.yahoo.com with NNFMP; 16 Dec 2014 19:40:30 -0000
Received: from [127.0.0.1] by smtp125.mail.sg3.yahoo.com with NNFMP; 16 Dec 2014 19:40:30 -0000
X-Yahoo-Newman-Id: 48847.95242.bm@smtp125.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 4xU71LkVM1k2yWQsJ2IvkH2GaQPePxoDWRkmnfxv9W3tnVc
 XCljUOVsGs_89ZKurJH_vr3UsmVnPO0ESDet8qm3ssUq.PjA7P1d37pi66Y0
 kLgI5UVldwlba9tikCbBs.fA56VupbKhIdm6GzHayyK9g.5ANhrkQsJ.CIPj
 9pM6l49M0yxgqLBSDSeZzBqPJVm41v9.xSp0MPVhRY3IYMkWJyx9DTvTdv5A
 m73mXvVluKjomkQ.X8poegudiD9e.ZzLgLxy.mv4DEjEth5TmDhtDos_K2DK
 2dnlfzT2.CxaQaE581h.L7tbQTzjF11wt8BLhnAruEXYKO5fuB_n7paO_GPN
 nzN9_CWZ2oik7K2NXIajDLbdRKPhvWdgvamcx537kcw5kZiL67Rir3R0LcNj
 1h0.oXlxfn.isWbnssmwWCPsG92IBsYsBI2M9vi1eByqH.sJn990oZAG2nXB
 HfhPoSKKM77Xa0w00skroyMaq5KVUlwEV91HNQ1.kJdIOSHpQxn95_JMudwm
 2Q3HuZpzC1jOffcrqujNegOfbxbe7526R
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-21-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261462>

Hi,

>From the command help I see - 

[arup@to_do_app]$ git reset -h
usage: git reset [--mixed | --soft | --hard | --merge | --keep] [-q] 
[<commit>]
   or: git reset [-q] <tree-ish> [--] <paths>...
   or: git reset --patch [<tree-ish>] [--] [<paths>...]

    -q, --quiet           be quiet, only report errors
    --mixed               reset HEAD and index
    --soft                reset only HEAD
    --hard                reset HEAD, index and working tree
    --merge               reset HEAD, index and working tree
    --keep                reset HEAD but keep local changes
    -p, --patch           select hunks interactively

But I am looking for any differences -

a) git reset --soft and git reset --keep
b) git reset --hard and git reset --merge


-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, 
if you write the code as cleverly as possible, you are, by definition, not 
smart enough to debug it.

--Brian Kernighan
