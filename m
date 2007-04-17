From: Nicolas Pitre <nico@cam.org>
Subject: Re: Initial push of a fully packed repo - why repack?
Date: Mon, 16 Apr 2007 22:21:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704162215520.4504@xanadu.home>
References: <46a038f90704161812r143b6d27scbcc401ee77c4597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 04:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HddK0-0006cc-VT
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 04:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbXDQCVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 22:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbXDQCV3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 22:21:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34002 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbXDQCV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 22:21:29 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGM00L47EJCWI22@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 22:21:12 -0400 (EDT)
In-reply-to: <46a038f90704161812r143b6d27scbcc401ee77c4597@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44707>

On Tue, 17 Apr 2007, Martin Langhoff wrote:

> Pushing to a new empty repo, git spends a lot of time repacking, even
> if we have just run git-repack. The process looks like
> 
> - use parsecvs to import a large CVS repo
> - git-repack -a -d (packs to ~550MB, taking ~1hr)
> - git-push --all git+ssh://host/newlycreatedrepo.git
> 
> Does it make sense to detect and optimise for this case?

Maybe...  Although the second repack during the push should be much much 
faster than the first one.


Nicolas
