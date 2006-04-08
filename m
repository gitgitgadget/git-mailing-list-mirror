From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Funny repack behaviour
Date: Sun, 9 Apr 2006 00:11:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604090010120.9176@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604081233170.3283@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604081528070.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 00:11:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSLee-00033C-C0
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 00:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWDHWLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWDHWLh
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 18:11:37 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10463 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751439AbWDHWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 18:11:37 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C9A12C94;
	Sun,  9 Apr 2006 00:11:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id BE010C89;
	Sun,  9 Apr 2006 00:11:35 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 9F28BC64;
	Sun,  9 Apr 2006 00:11:35 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604081528070.2215@localhost.localdomain>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18534>

Hi,

On Sat, 8 Apr 2006, Nicolas Pitre wrote:

> On Sat, 8 Apr 2006, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > I just accidentally reran "git-repack -a -d" on a repository, where I just 
> > had run it. And I noticed a funny thing: Of about 4000 objects, it reused 
> > all but 8. So I reran it, and it reused all but 2. I ran it once again, 
> > and it reused all.
> > 
> > The really funny thing is: it created the same pack every time!
> 
> Probably not.  Subsequent packs were most probably even smaller !

Oh, you're right. I was tricked by the identical pack-names. Somehow I 
forgot that the pack name just reflects a hash of the _unpacked_ objects, 
not the pack file itself.

Sorry for the noise.

Ciao,
Dscho
