From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/5] Rework diff options
Date: Fri, 23 Jun 2006 16:28:47 -0700
Message-ID: <7vodwj8n9s.fsf@assigned-by-dhcp.cox.net>
References: <20060624011538.9bb179e7.tihirvon@gmail.com>
	<Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 01:28:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftv53-00052Z-LM
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 01:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWFWX2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWFWX2s
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 19:28:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16280 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751662AbWFWX2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 19:28:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623232847.CIDZ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 19:28:47 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 24 Jun 2006 00:28:41 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22455>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 24 Jun 2006, Timo Hirvonen wrote:
>
>> This patch series cleans up diff output format options.
>
> Very good.
>
> Although I understand that to convert all users to the new convention, it 
> is sensible to rename the constants, I think it is not good to change 
> something as DIFF_FORMAT_RAW to OUTPUT_FMT_RAW in the resulting patch.

I personally feel that the benefit of being able to make sure
you covered everything outweighs the size of initial diff.

Thanks Timo.  Will take a look.
