From: Nicolas Pitre <nico@cam.org>
Subject: reversible binary diff
Date: Fri, 25 Aug 2006 21:04:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608252050140.3683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Aug 26 03:04:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGmbX-0002tf-Am
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 03:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWHZBEt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 21:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWHZBEt
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 21:04:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26169 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932284AbWHZBEs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 21:04:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4K00A1LYZXNX90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Aug 2006 21:04:45 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26024>


I just noticed that the binary diff format was augmented in order to 
carry the reverse diff information.

Why was this needed?

I mean, if you want to reverse a binary diff you only need to retrieve 
the original blob the forward diff was meant to apply against, and it is 
certainly already available in the object store if the forward diff has 
been previously applied.  Or has this assumption been wrong for some 
work flow?


Nicolas
