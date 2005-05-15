From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] adding merge-node to parent lines in a commit
Date: Sun, 15 May 2005 15:36:07 -0700
Message-ID: <7v64xkqfqg.fsf@assigned-by-dhcp.cox.net>
References: <1282.10.10.10.24.1116192147.squirrel@linux1>
	<7vfywoqira.fsf@assigned-by-dhcp.cox.net>
	<1441.10.10.10.24.1116194876.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:36:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXRiU-0000ck-UK
	for gcvg-git@gmane.org; Mon, 16 May 2005 00:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVEOWgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 18:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVEOWgQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 18:36:16 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40640 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261285AbVEOWgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 18:36:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515223607.FSKL8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 18:36:07 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <1441.10.10.10.24.1116194876.squirrel@linux1> (seanlkml@sympatico.ca's
 message of "Sun, 15 May 2005 18:07:56 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:

S> Yes, it's pretty basic unless i'm overlooking something:

    Rn---\
         Mn
         Mn-1
    Rn-1  |
    Rn-2  |
    Rn-3--/
    Initial

S> So for this particular case it's rather simple, the Rn merge
S> node would have:

S> parent  Rn-1  (ommitted)
S> parent  Mn    Rn-3

Isn't that something you can obtain by scanning the parents and
running merge-base across them without recording it in the
commit?

