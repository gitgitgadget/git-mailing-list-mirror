From: David Kastrup <dak@gnu.org>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 23:53:21 +0100
Message-ID: <858x5ix5em.fsf@lola.goethe.zz>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0710312111170.4362@racer.site>
	<7vhck7gdzs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 23:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InMQf-0002fV-VL
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762478AbXJaWwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762369AbXJaWwA
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:52:00 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:57451 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762362AbXJaWv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:51:59 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1InMPm-0000JA-76; Wed, 31 Oct 2007 18:51:58 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A2DE61C464E3; Wed, 31 Oct 2007 23:53:21 +0100 (CET)
In-Reply-To: <7vhck7gdzs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 31 Oct 2007 14:39:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62896>

Junio C Hamano <gitster@pobox.com> writes:

> A rebase conflict resolution that results in emptiness is a rather
> rare event (especially because rebase drops upfront the identical
> changes from the set of commits to be replayed), but it does happen.
> One could argue that "rebase --continue" can notice that the resolved
> index is identical to the tree of the HEAD commit and skip it
> automatically.
>
> Given an index that is identical to HEAD, however, it is not
> easy to safely determine if that is because the patch did not
> apply at all,

Wouldn't there be a conflict in the index?  A conflict which can only be
resolved by adding?  Which then results in a question whether you forgot
to add?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
