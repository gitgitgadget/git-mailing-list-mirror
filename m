From: Ian Hobson <ian@ianhobson.co.uk>
Subject: Strange permission problem - advice needed
Date: Wed, 28 Apr 2010 12:13:31 +0100
Message-ID: <4BD8185B.5060706@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 28 13:50:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O75mF-00062J-P4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 13:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab0D1Lt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 07:49:57 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:60786 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752498Ab0D1Lt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 07:49:56 -0400
X-Greylist: delayed 2181 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2010 07:49:56 EDT
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100428111334.XXRF10460.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:13:34 +0100
Received: from jupiter.ianhobson.co.uk ([86.12.69.89])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100428111334.XGEG13959.aamtaout02-winn.ispmail.ntl.com@jupiter.ianhobson.co.uk>
          for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:13:34 +0100
Received: (qmail 21821 invoked by uid 453); 28 Apr 2010 11:13:27 -0000
X-Virus-Checked: Checked by ClamAV on ianhobson.co.uk
Received: from bobgriffiths.mars.hcs (HELO [192.168.0.13]) (192.168.0.13)
    by ianhobson.co.uk (qpsmtpd/0.40) with ESMTP; Wed, 28 Apr 2010 12:13:27 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4 ThunderBrowse/3.2.8.1
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=jDn6BSCZXKIA:10 a=8nJEP1OIZ-IA:10 a=wzgxZwZbnT8PuY2evNAA:9 a=ojCDJuBfqwjKnhBJT1AA:7 a=2z7szCI3bH7Sup8_tM7J64kcovQA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145987>

Hi all,

I'm using git on windows (XP) and the GUI told me there were too may 
objects so I allowed it to tidy up. It errors, that it could not unlink 
some files. So I checked the properties - all files are readable.

I repeated the gc in git bash with the following results.

$ git gc
Counting objects: 398, done.
Compressing objects: 100% (205/205), done.
Writing objects: 100% (398/398), done.
Total 398 (delta 191), reused 398 (delta 191)
rm: cannot unlink `pack-6f07bacdef764f32f12af14877b307d2cb36a1e4.pack': 
Permission denied
rm: cannot unlink `pack-6f07bacdef764f32f12af14877b307d2cb36a1e4.idx': 
Permission denied
rm: cannot unlink `pack-cba55771937a4549af73c09c17b10cfceb1320df.pack': 
Permission denied
rm: cannot unlink `pack-cba55771937a4549af73c09c17b10cfceb1320df.idx': 
Permission denied
Removing duplicate objects: 100% (256/256), done.

Ian@MARS /d/websites/SOPSystem (master)
$ git version
git version 1.7.0.2.msysgit.0

Note - this is Windows XP so there are no permissions on the files. The 
files are all local.

I even disabled AVG and tried again. Same result.

What is going on? and does it matter?

A thought - I copy/pasted (not cloned) the whole repo from a Samba share 
(presented by Ubuntu) about 2 weeks ago. Could it be something left
over from that? The share was read/write and I owned all the files.

Thanks

Ian
