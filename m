From: Sergei Organov <osv@javad.com>
Subject: Re: git-merge: inconsistent manual page.
Date: Tue, 30 Oct 2007 22:32:40 +0300
Message-ID: <87wst44cvb.fsf@osv.gnss.ru>
References: <fg7b6o$k1f$1@ger.gmane.org>
	<7vsl3sla5q.fsf@gitster.siamese.dyndns.org>
	<7vk5p4l9gs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxAM-00027C-HT
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbXJ3TyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbXJ3TyG
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:54:06 -0400
Received: from javad.com ([216.122.176.236]:1534 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbXJ3TyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:54:05 -0400
X-Greylist: delayed 1277 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2007 15:54:04 EDT
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id l9UJWjm36373
	for <git@vger.kernel.org>; Tue, 30 Oct 2007 19:32:46 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1ImwpM-0002PL-2U
	for git@vger.kernel.org; Tue, 30 Oct 2007 22:32:40 +0300
In-Reply-To: <7vk5p4l9gs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 30 Oct 2007 11\:54\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62743>

Junio C Hamano <gitster@pobox.com> writes:
> Subject: git-merge: document but discourage the historical syntax
>
> Historically "git merge" took its command line arguments in a
> rather strange order.  Document the historical syntax, and also
> document clearly that it is not encouraged in new scripts.
>
> There is no reason to deprecate the historical syntax, as the
> current code can sanely tell which syntax the caller is using,
> and existing scripts by people do use the historical syntax.

OK, your patch is better than what I've suggested. The only thing that
your patch seems to be missing is prepending -m to <msg>:: in the
OPTIONS section. Yeah, it could be more strict to just describe <msg>,
but if there were no historical syntax, then you'd put '-m <msg>'
description in, right? So the latter might be better anyway.

-- 
Sergei.
