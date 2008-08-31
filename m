From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Correct documentation wording for diff options -S and --pickaxe-all
Date: Mon, 1 Sep 2008 02:59:57 +0300
Message-ID: <20080831235957.GB16289@zakalwe.fi>
References: <20080831230304.GA30480@zakalwe.fi> <7v63pg3h4o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 02:01:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZwr4-0001Mu-Qx
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 02:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYHaX77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 19:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYHaX77
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 19:59:59 -0400
Received: from zakalwe.fi ([80.83.5.154]:57007 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYHaX76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 19:59:58 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 49FCE2BC68; Mon,  1 Sep 2008 02:59:57 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7v63pg3h4o.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94516>

On Sun, Aug 31, 2008 at 04:21:43PM -0700, Junio C Hamano wrote:
> Thanks, but if we are doing this, we should reword it to something less
> misleading.  The pickaxe search does not look for changes that contains
> string in the sense people might expect (e.g. "diff -u0 | grep string").
> 
> The machinery looks at the old and new copy, and considers it a match if
> they have different numbers of "string" in them.
> 
> So perhaps something like this
> 
> -S<string>::
> 	Look for differences that changes the number of <string> in the
> 	file.
> 
> --pickaxe-all::
> 	When -S finds a change, show all the changes in that changeset,
>         not just the files for which the number of <string> in them
> 	changes.
> 
> but I am bad at writing, so I'll ask others to come up with a better
> wording.

Perhaps like this:

-S:
"Look for differences that change the number of <string> matches in a file.
In other words, moving the <string> inside a file does not imply a 
match, but adding or removing <string> will."

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
