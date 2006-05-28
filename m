From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sun, 28 May 2006 18:33:14 +1000
Message-ID: <8694.1148805194@ocs3.ocs.com.au>
References: <Pine.LNX.4.61.0605271441080.4857@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 28 10:33:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkGiK-0002RL-1W
	for gcvg-git@gmane.org; Sun, 28 May 2006 10:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWE1Id2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 04:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWE1Id2
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 04:33:28 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:32197 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751354AbWE1Id1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 04:33:27 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id 1286DE0B20E;
	Sun, 28 May 2006 18:32:47 +1000 (EST)
Received: by ocs3.ocs.com.au (Postfix, from userid 16331)
	id C930E2ED2; Sun, 28 May 2006 18:33:14 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id A175B8017B;
	Sun, 28 May 2006 18:33:14 +1000 (EST)
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-reply-to: Your message of "Sat, 27 May 2006 14:42:02 +0200."
             <Pine.LNX.4.61.0605271441080.4857@yvahk01.tjqt.qr> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20875>

Jan Engelhardt (on Sat, 27 May 2006 14:42:02 +0200 (MEST)) wrote:
>And the CL form is
>  perl -i -pe '...'
>Somehow, you can't group it to -ipe, but who cares.

-i takes an optional extension which is used to optionally create
backup files.  As such, -i must be followed by space if you want no
extension (and no backup).
