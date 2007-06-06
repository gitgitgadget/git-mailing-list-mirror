From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Wed, 06 Jun 2007 15:46:11 -0700
Message-ID: <7vlkewya4s.fsf@assigned-by-dhcp.cox.net>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw4Gz-0001Nf-3t
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbXFFWqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXFFWqP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:46:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56284 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbXFFWqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:46:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606224613.JIZE9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 18:46:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8NmC1X0051kojtg0000000; Wed, 06 Jun 2007 18:46:12 -0400
In-Reply-To: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz> (Sam
	Vilain's message of "Wed, 6 Jun 2007 23:08:25 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49329>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> +			c_gen=`eval "echo \\\$c_gen_$i"`
> +			packs=`eval "echo \\\$gen_$i"`

I used to write something like these myself when I was young
;-), but it is enough to write:

	eval 'c_gen=$c_gen_'$i
	eval "packs=\$gen_$i"
