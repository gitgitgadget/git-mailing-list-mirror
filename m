From: Gonsolo <gonsolo@gmail.com>
Subject: Direct ancestors from commit to HEAD
Date: Wed, 16 Sep 2009 16:01:36 +0200
Message-ID: <4AB0EFC0.8020005@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 16:01:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnv50-0003D7-Q0
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 16:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbZIPOBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 10:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZIPOBj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 10:01:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55969 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbZIPOBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 10:01:37 -0400
Received: by bwz19 with SMTP id 19so3511121bwz.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=hePd7xKAb8kXnlObFYhLdlx7PafJssYJhcqUn7fJq6c=;
        b=MO+FstgN+R1UKRcx8ZocBKnIu1hHa3aX9nBxQVp9Ffz0CQgTIsRw/Q5/92/sT9jqEd
         DfibRiRWykYo+slYzi2f7CeHLF4Wo0ay2UgnQHMafOmXoEmT1QFVUIcTk5wi8g0/PMPZ
         llVm+TD8om93JKJHXengYbFqEAQ1VES++QQ7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=ihdmw526rv2AKE2qbzu7BTlpVUfZSoblIDIGqJHdHqXTd9sFruw3vSitf2PF18bDRl
         KnTHJKPCttvODFrR2vzimNqyMnUOciPuNZ/orvnqqN0GitSTh7od8niwCp7/DZtYxlXx
         2+8QWIrIhZZih8mp7N8zkYCZzWaNrQwlTgC5E=
Received: by 10.204.136.217 with SMTP id s25mr7473868bkt.149.1253109699511;
        Wed, 16 Sep 2009 07:01:39 -0700 (PDT)
Received: from ?192.168.2.100? (port-92-195-101-71.dynamic.qsc.de [92.195.101.71])
        by mx.google.com with ESMTPS id 1sm3551139fks.5.2009.09.16.07.01.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 07:01:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128655>

Is there a way to see only the direct line of (merge) ancestors from 
patch to HEAD? Something like:

commit 0cb583fd2862f19ea88b02eb307d11c09e51e2f8
Merge: 723e9db... a2d1056...
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Sep 15 10:01:16 2009 -0700

	Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6

commit 88512935a24305fea7aecc9ba4d675869e97fc2a
Merge: 8a62bab... 6b26dea...
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Aug 14 12:27:19 2009 -0700

	Merge branch 'master' of 
git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6

commit edd7fc7003f31da48d06e215a93ea966a22c2a03
Author: Nick Kossifidis <mick@madwifi-project.org>
Date:   Mon Aug 10 03:29:02 2009 +0300

     ath5k: Wakeup fixes


Here I can see exactly how the ath5k patch came to mainline and since 
when it is there.
