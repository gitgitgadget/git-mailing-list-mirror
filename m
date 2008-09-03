From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] ignore trailing slash when creating leading directories
Date: Wed, 3 Sep 2008 21:02:31 +0200
Message-ID: <20080903190230.GA12990@localhost>
References: <20080902081909.GA2059@localhost> <7vk5dul7f5.fsf@gitster.siamese.dyndns.org> <20080902191322.GA11172@localhost> <7vod36jne1.fsf@gitster.siamese.dyndns.org> <7v1w02jlu0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaxdS-0002T6-Us
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 21:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbYICTBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756196AbYICTBv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 15:01:51 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:54851 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbYICTBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 15:01:50 -0400
Received: from darc.dyndns.org ([84.154.106.129]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Sep 2008 21:01:48 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Kaxcd-0005fu-Pa; Wed, 03 Sep 2008 21:02:31 +0200
Content-Disposition: inline
In-Reply-To: <7v1w02jlu0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 03 Sep 2008 19:01:48.0789 (UTC) FILETIME=[8480DA50:01C90DF7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94837>

On Tue, Sep 02, 2008 at 02:10:15PM -0700, Junio C Hamano wrote:
> And just so that you do not misunderstand that I am opposed to the change
> to c-l-d, here is a replacement to your original patch.  I didn't fix the
> caller, as I didn't want to do an overlapping fix with you.

You beat me to it - again. :-) But I like yours much better.

Clemens
