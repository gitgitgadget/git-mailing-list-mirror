From: Thomas Jampen <jampen@kinet.ch>
Subject: Re: Out of memory error during git push
Date: Fri, 20 Aug 2010 16:26:17 +0200 (CEST)
Message-ID: <23639398.583.1282314377177.JavaMail.root@hermes>
References: <20100820125119.GA9762@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 16:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmSfG-0002Px-6Y
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 16:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0HTOdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 10:33:45 -0400
Received: from hermes.gymkirchenfeld.ch ([86.118.137.202]:47438 "EHLO
	hermes.gymkirchenfeld.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab0HTOdn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 10:33:43 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2010 10:33:43 EDT
Received: from localhost (localhost [127.0.0.1])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTP id 499E38C432A;
	Fri, 20 Aug 2010 16:26:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at hermes.gymkirchenfeld.ch
Received: from hermes.gymkirchenfeld.ch ([127.0.0.1])
	by localhost (hermes.gymkirchenfeld.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIJhc+1PmVA0; Fri, 20 Aug 2010 16:26:17 +0200 (CEST)
Received: from hermes.gymkirchenfeld.ch (localhost [127.0.0.1])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTP id 53A2B8C4328;
	Fri, 20 Aug 2010 16:26:17 +0200 (CEST)
In-Reply-To: <20100820125119.GA9762@burratino>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - FF3.0 (Win)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154044>

Hi

>> I'm experiencing the following error while pushing a git repo (home
>> directory) to my QNAP TS-210:
>>
>> user@mypc:~$ git push origin master
>> Counting objects: 12532, done.
>> Delta compression using up to 2 threads.
>> Compressing objects: 100% (8974/8974), done.
>> fatal: Out of memory, malloc failed, 986.06 MiB | 1.65 MiB/s
>> error: pack-objects died of signal 13
> 
> What version of git are you using?  Do you have overcommit accounting
> enabled?

I'm using git version 1.7.0.4 on my Kubuntu 10.04 Laptop and git version
1.7.1.1 on my QNAP NAS.

On my Laptop and on the NAS, when I execute: sudo sysctl vm.overcommit_memory
I get:
vm.overcommit_memory = 0

Do you propose to set this to '2' in order to disable overcommitting? If yes, where (on the Laptop and/or on the NAS)?

Thanks,
Tom
