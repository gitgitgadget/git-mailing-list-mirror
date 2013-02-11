From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: git bisect result off by 1 commit
Date: Mon, 11 Feb 2013 09:20:30 -0800
Message-ID: <1360603230.17632.183.camel@schen9-DESK>
References: <1360374853.17632.182.camel@schen9-DESK>
	 <7v1ucqxmyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ak <ak@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:20:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4x3l-0006Hd-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154Ab3BKRUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:20:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:46610 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757838Ab3BKRUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:20:30 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 11 Feb 2013 09:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,643,1355126400"; 
   d="scan'208";a="284274434"
Received: from schen9-desk.jf.intel.com (HELO [10.7.199.63]) ([10.7.199.63])
  by orsmga002.jf.intel.com with ESMTP; 11 Feb 2013 09:20:28 -0800
In-Reply-To: <7v1ucqxmyd.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.3 (2.32.3-1.fc14) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216063>


> 
> Looks perfectly normal to me.  The message above:
> 
> > HEAD is now at a0d271c... Linux 3.6
> > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > [d54b1a9e0eaca92cde678d19bd82b9594ed00450] perf script: Remove use of die/exit
> 
> is asking you to test the commit at d54b1a9e and tell it the result
> of the test.  The message says "0 left to test *after* this";
> doesn't it mean you still need to do *this*?
> 
> A bisecct session ends when it tells you
> 
> 	XXXXXX is the first bad commit
> 
> which I do not see in the above.  You seem to have stopped before
> that happens.

Yes, I should do one more step.  Thanks for catching.

Tim
