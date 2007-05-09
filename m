From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 16:25:05 -0700
Message-ID: <7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu May 10 01:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlvX3-0004e0-GE
	for gcvg-git@gmane.org; Thu, 10 May 2007 01:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760036AbXEIXZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 19:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760020AbXEIXZK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 19:25:10 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39456 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759954AbXEIXZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 19:25:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509232506.NPUP6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 19:25:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xBR51W00j1kojtg0000000; Wed, 09 May 2007 19:25:07 -0400
In-Reply-To: <20070509.162301.48802460.davem@davemloft.net> (David Miller's
	message of "Wed, 09 May 2007 16:23:01 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46812>

David Miller <davem@davemloft.net> writes:

> From: Junio C Hamano <junkio@cox.net>
> Date: Wed, 09 May 2007 15:59:23 -0700
>
>> The above sequence is called before we create the new directory
>> and chdir to it.  Maybe pwd has funny behaviour (e.g. $PWD) and
>> we need to explicitly say /bin/pwd or somesuch...
>
> Indeed:
>
> [davem@hera ~]$ pwd
> /home/davem
> [davem@hera ~]$ cd git
> [davem@hera git]$ pwd
> /home/davem/git
> [davem@hera git]$ /bin/pwd
> /home/ftp/pub/scm/linux/kernel/git/davem
> [davem@hera git]$ 

Thanks.
