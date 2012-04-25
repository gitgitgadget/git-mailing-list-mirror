From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv3 0/4] git p4: label import/export
Date: Wed, 25 Apr 2012 18:22:05 -0400
Message-ID: <20120425222205.GA1753@padd.com>
References: <1335254897-15242-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:22:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNAbK-0006L1-Er
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 00:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759259Ab2DYWWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 18:22:10 -0400
Received: from honk.padd.com ([74.3.171.149]:59019 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759097Ab2DYWWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 18:22:09 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id 5F68B1F80;
	Wed, 25 Apr 2012 15:22:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D5FC65A9BF; Wed, 25 Apr 2012 18:22:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1335254897-15242-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196342>

luke@diamand.org wrote on Tue, 24 Apr 2012 09:08 +0100:
> This is a reworked version of my earlier patches for adding
> improved label import/export support to "git p4", and
> incorporates comments from Pete Wyckoff and Junio:
> 
> Comments from Pete:
> 
> * The verbose flag has been hoisted to the Command class.

Thanks, this looks great.

> * Uses the existing functions to fish out p4 changelist numbers.
> * Config options renamed to be self-consistent, and regexp
>   now includes lower-case characters.
> 
> I have left the tests in t9811 where they are, so that the t9804
> script can be used solely for "--detect-labels".

Oh, okay.  9804 is about --detect-labels, which still has the
two-labels-on-same-changelist problem.  9811 is the new stuff,
and the similar test there works.

Anyway, ack your v4 that is this plus your doc fix.  Thanks,

		-- Pete

> Comments from Junio:
> 
> * P4EDITOR is set to the always-true value in the test harness
> * Treat an empty P4EDITOR the same as an unset P4EDITOR.
> 
> There was a discussion about having "git p4" fall back to a default in
> the same way that "p4" does, but this would change the existing behavior
> (use git var GIT_EDITOR) and confuse users.
> 
> This patch series was reworked against ld/git-p4-tags-and-labels and
> also has a very small documentation fix.
