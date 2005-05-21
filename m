From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Fri, 20 May 2005 22:08:19 -0700
Message-ID: <7voeb5np30.fsf@assigned-by-dhcp.cox.net>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 07:07:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZMCl-0001ig-IH
	for gcvg-git@gmane.org; Sat, 21 May 2005 07:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVEUFIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 01:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEUFIV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 01:08:21 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37117 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261661AbVEUFIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 01:08:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521050818.KXPQ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 01:08:18 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <4870.10.10.10.24.1116646732.squirrel@linux1> (seanlkml@sympatico.ca's
 message of "Fri, 20 May 2005 23:38:52 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The patch looks good.  Before you proceed to convert the rest,
could I ask you to first let us see the list of new set of
options and semantics changes, if any ("checkout-cache -f -a" vs
"checkout-cache -a -f" immediately comes to mind)?

Presumably you would be doing the Documentation updates as well,
so starting from the documentaiton updates before writing the
actual code may be a good way for us to understand and ack on
what is going to happen.

