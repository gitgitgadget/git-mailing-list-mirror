From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] escape tilde in Documentation/git-rev-parse.txt
Date: Tue, 03 Oct 2006 01:00:56 -0700
Message-ID: <7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
	<452211C2.8020402@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 10:01:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUfD2-00069P-9R
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 10:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWJCIA6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 04:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965272AbWJCIA5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 04:00:57 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22510 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965266AbWJCIA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 04:00:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003080056.QMBD13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 04:00:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Vk0z1V0031kojtg0000000
	Tue, 03 Oct 2006 04:00:59 -0400
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <452211C2.8020402@s5r6.in-berlin.de> (Stefan Richter's message of
	"Tue, 03 Oct 2006 09:31:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28251>

Stefan Richter <stefanr@s5r6.in-berlin.de> writes:

> Junio C Hamano wrote:
> ...
>> This works for me on 7.1; is your 8.0 happy with it?
> ...
>> +tilde=&#126;
> ...
>> -* A suffix '~<n>' to a revision parameter means the commit
>> +* A suffix '{tilde}<n>' to a revision parameter means the commit
> ...
>
> Yes, this works as intended. Thanks,

Thanks.  It's a bit sad that asciidoc's nicer quoting features
are not backward compatible.
