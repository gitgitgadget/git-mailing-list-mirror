From: Nicolas Pitre <nico@cam.org>
Subject: git log is a bit antisocial
Date: Fri, 14 Apr 2006 16:50:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 14 22:50:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUVFR-0004Hu-AC
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 22:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWDNUuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 16:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWDNUuQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 16:50:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:5499 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965159AbWDNUuH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 16:50:07 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXQ00A6VCJJBF70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Apr 2006 16:50:07 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18700>


$  git log -h
fatal: unrecognized argument: -h
$ git log --help
fatal: unrecognized argument: --help

Maybe the usage string could be printed in those cases?


Nicolas
