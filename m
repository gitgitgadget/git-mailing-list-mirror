From: Luben Tuikov <ltuikov@yahoo.com>
Subject: manual merge/fixup question
Date: Sat, 7 Jan 2006 08:55:06 -0800 (PST)
Message-ID: <20060107165506.67640.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jan 07 17:55:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvHLU-0001HW-8J
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 17:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbWAGQzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 11:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbWAGQzH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 11:55:07 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:40613 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030508AbWAGQzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 11:55:06 -0500
Received: (qmail 67642 invoked by uid 60001); 7 Jan 2006 16:55:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=R6bS8m5aeyc+NAHW5G8fJPW2amvzKNSdA66Wb8PDANBihhLkib+P60IoaWYBlP8kmlzp9QT5S+7L9hVKbFM5gI7Y8+zxGk3Keu2qv+vk+9chSve9BAlOd/+8MfN5HGOoQzfbTV/Sq68eN8BDiA4+GFgWokpDyGnAy36emlD63EA=  ;
Received: from [68.221.7.47] by web31812.mail.mud.yahoo.com via HTTP; Sat, 07 Jan 2006 08:55:06 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14261>

git resolve or git merge fails, complaining
about file(s) having conflicts. I go ahead and fix up
those files and then update the index.

Can I assume now that I can go ahead and do git commit,
or is there any more/other files which need fixing?

I.e. does git resolve/merge fail on the first file
which needs fixing or would it go through all of them,
and then report the ones which need fixing?

Thanks,
   Luben
