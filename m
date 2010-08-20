From: Thomas Jampen <jampen@kinet.ch>
Subject: Re: Out of memory error during git push
Date: Fri, 20 Aug 2010 18:01:57 +0200 (CEST)
Message-ID: <15798303.640.1282320117609.JavaMail.root@hermes>
References: <20100820145011.GF16190@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 18:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmU2x-0002O1-77
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 18:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab0HTQCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 12:02:02 -0400
Received: from hermes.gymkirchenfeld.ch ([86.118.137.202]:36727 "EHLO
	hermes.gymkirchenfeld.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab0HTQCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 12:02:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTP id B33A68C4328;
	Fri, 20 Aug 2010 18:01:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at hermes.gymkirchenfeld.ch
Received: from hermes.gymkirchenfeld.ch ([127.0.0.1])
	by localhost (hermes.gymkirchenfeld.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pFggRpaXlPsO; Fri, 20 Aug 2010 18:01:57 +0200 (CEST)
Received: from hermes.gymkirchenfeld.ch (localhost [127.0.0.1])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTP id C51228C42E6;
	Fri, 20 Aug 2010 18:01:57 +0200 (CEST)
In-Reply-To: <20100820145011.GF16190@burratino>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - FF3.0 (Win)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154051>

> > vm.overcommit_memory = 0
> >
> > Do you propose to set this to '2' in order to disable
> > overcommitting?
> 
> It might be interesting to try
> 
> echo 1 >/proc/sys/vm/overcommit_memory
> 
> but 0 is generally the only sane setting.

I set the value on both (Laptop and NAS) and got the following error:
Counting objects: 13051, done.
Delta compression using up to 2 threads.
warning: suboptimal pack - out of memory
Compressing objects: 100% (9848/9848), done.
error: index-pack died of signal 9), 1.27 GiB | 308 KiB/s
error: pack-objects died of signal 13
error: pack-objects died with strange error
error: failed to push some refs to 'ssh://...'

Any ideas?
Tom
