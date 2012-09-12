From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in
 "binary" merge driver
Date: Wed, 12 Sep 2012 13:50:36 -0400 (EDT)
Message-ID: <1041293807.327912.1347472236069.JavaMail.root@genarts.com>
References: <7vhar3dvkl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBr5P-00040H-D3
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab2ILRun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:50:43 -0400
Received: from hq.genarts.com ([173.9.65.1]:10338 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753357Ab2ILRum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:50:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id D3CF9BE142A;
	Wed, 12 Sep 2012 13:50:41 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aQ62Jj+wQPLY; Wed, 12 Sep 2012 13:50:36 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1E6E2BE1405;
	Wed, 12 Sep 2012 13:50:36 -0400 (EDT)
In-Reply-To: <7vhar3dvkl.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205313>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Wednesday, September 12, 2012 1:01:30 PM
> Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in "binary" merge driver
> 
> >> Perhaps something like this makes it better.
> >
> > Patch didn't apply on top of the previous two for me,...
> 
> Look at 'pu' and see how it applies.

Ah, that seems to work better.
 
> > ...  The only remaining
> > question for me is should -Xtheirs resolve "deleted by them"
> > conflicts?
> 
> I do not know, and I do not care to worry about it too deeply, which
> means I would rather err on the safe side and have users inspect the
> situation, make the decision when such a conflict happens and
> resolve them themselves, instead of claiming a clean resolution that
> is possibly wrong.

A reasonable approach.  Thanks for clarifying.

Stephen
