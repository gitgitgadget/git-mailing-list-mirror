From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: git-send-email: threaded view issue with Thunderbird
Date: Thu, 24 Aug 2006 08:12:28 +0000 (GMT)
Message-ID: <20060824081228.69110.qmail@web25808.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 24 10:12:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGAKI-0005MM-FX
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 10:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWHXIMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 04:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWHXIMb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 04:12:31 -0400
Received: from web25808.mail.ukl.yahoo.com ([217.12.10.193]:16981 "HELO
	web25808.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750825AbWHXIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 04:12:30 -0400
Received: (qmail 69112 invoked by uid 60001); 24 Aug 2006 08:12:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=sBSuVfU4pK14FlrpuN945HGErbIm/Db599J371uvIkTE2Yl1318ylAq28dX+j702HMd/MpHqtyu0eE/GLXjBS/IWwKS218S1HotRRvimiblsQmIK17hENN41HkTxsj5zPCAe/B8ojywcbQw+PjJd0zeE/0G5CdG7MiK3WqT93u8=  ;
Received: from [194.3.162.233] by web25808.mail.ukl.yahoo.com via HTTP; Thu, 24 Aug 2006 08:12:28 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25947>

Hi,

Sometimes, actually most of the time, git-send-email _seems_ to not
work properly with Thunderbird: for example if I send a patchset made
up by 4 single patchs, then Thunderbird show me this patchset 'broken'
that is [PATCH 2/4] is not shown as a reply to [PATCH 1/4].

For example I can see:

[PATCH 0/4]
       [PATCH 1/4]
[PATCH 2/4]
[PATCH 3/4]
       [PATCH 4/4]

instead of

[PATCH 0/4]
       [PATCH 1/4]
          [PATCH 2/4]
             [PATCH 3/4]
                [PATCH 4/4]

The strange thing is that all email headers are correct.

I recently notice that someone has sent a patchset using
git-send-email and I can see it 'broken' as well. The subject of the
first email of the set is

[PATCH 0/7] C cleanup series, mostly nasty shadowing

Does anybody have an idea on what's going wrong ?

thanks,

Francis
