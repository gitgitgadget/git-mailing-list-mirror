From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Thu, 4 Feb 2010 12:16:19 -0500
Message-ID: <20100204171619.GA9367@cthulhu>
References: <20100130020548.GA29343@cthulhu>
 <7vsk9oysds.fsf@alter.siamese.dyndns.org>
 <20100201005751.GA8322@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 18:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5Jt-00022N-NN
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab0BDRQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:16:21 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:44247 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab0BDRQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:16:20 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 5C5E182200D; Thu,  4 Feb 2010 12:16:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100201005751.GA8322@cthulhu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138984>

* Larry D'Anna (larry@elder-gods.org) [100131 19:57]:
> So i guess you're saying that it would be better for update_local_ref and
> print_summary_for_push_or_fetch to clear the flags, and just pass a rev_info for
> print_summary_for_push_or_fetch instead of quickref?

So, should I submit a version of the patch that does it this way?  Should it use
a subprocess?  Should the option be called something other than --summary?
Should I just forget about it?

  --larry
